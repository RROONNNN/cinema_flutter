import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/view_model/admin/bloc/admin_showtime_bloc.dart';
import 'package:cinema_flutter/view/admin/showtimes/showtime_form.dart';
import 'package:cinema_flutter/model/data_models/showtime.dart';
import 'package:intl/intl.dart';

class ShowtimePage extends StatefulWidget {
  const ShowtimePage({super.key});

  @override
  State<ShowtimePage> createState() => _ShowtimePageState();
}

class _ShowtimePageState extends State<ShowtimePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedDaytime;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    context.read<AdminShowtimeBloc>()
      ..add(AdminShowtimeInitial())
      ..add(AdminShowtimeGetAllMovies())
      ..add(AdminShowtimeGetAllCinemas());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      context.read<AdminShowtimeBloc>()
        ..add(AdminShowtimeOnSearch(searchQuery: query))
        ..add(const AdminShowtimeSearchShowtimes());
    });
  }

  String _getDaytimeFilter(DateTime startTime) {
    final hour = startTime.hour;
    if (hour >= 6 && hour < 12) return 'Morning';
    if (hour >= 12 && hour < 18) return 'Afternoon';
    if (hour >= 18 && hour < 24) return 'Evening';
    return 'Night';
  }

  List<Showtime> _getFilteredShowtimes(List<Showtime> showtimes) {
    if (_selectedDaytime == null) return showtimes;

    return showtimes.where((showtime) {
      final daytime = _getDaytimeFilter(showtime.startTime);
      return daytime == _selectedDaytime;
    }).toList();
  }

  String _getMovieName(String movieId, List<Map<String, dynamic>> movies) {
    final movie = movies.firstWhere(
      (movie) => movie['id'] == movieId,
      orElse: () => {'name': 'Unknown Movie'},
    );
    return movie['name'] ?? 'Unknown Movie';
  }

  String _getCinemaName(String cinemaId, List<Map<String, dynamic>> cinemas) {
    final cinema = cinemas.firstWhere(
      (cinema) => cinema['id'] == cinemaId,
      orElse: () => {'name': 'Unknown Cinema'},
    );
    return cinema['name'] ?? 'Unknown Cinema';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Showtimes Management'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AdminShowtimeBloc, AdminShowtimeState>(
        listener: (context, state) {
          if (state.status == AdminShowtimeStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.status == AdminShowtimeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'Operation successful'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Search and Filter Section
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search showtimes...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Daytime Filter
                    Row(
                      children: [
                        const Text(
                          'Filter by time: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedDaytime,
                          hint: const Text('All times'),
                          items: const [
                            DropdownMenuItem(
                              value: null,
                              child: Text('All times'),
                            ),
                            DropdownMenuItem(
                              value: 'Morning',
                              child: Text('Morning (6AM-12PM)'),
                            ),
                            DropdownMenuItem(
                              value: 'Afternoon',
                              child: Text('Afternoon (12PM-6PM)'),
                            ),
                            DropdownMenuItem(
                              value: 'Evening',
                              child: Text('Evening (6PM-12AM)'),
                            ),
                            DropdownMenuItem(
                              value: 'Night',
                              child: Text('Night (12AM-6AM)'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedDaytime = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Showtimes List
              Expanded(
                child: state.status == AdminShowtimeStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildShowtimesList(state),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShowtimeForm()),
          ).then((_) {
            // Refresh the list when returning from form
            context.read<AdminShowtimeBloc>().add(AdminShowtimeInitial());
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildShowtimesList(AdminShowtimeState state) {
    final filteredShowtimes = _getFilteredShowtimes(state.showtimes);

    if (filteredShowtimes.isEmpty) {
      return const Center(
        child: Text(
          'No showtimes found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<AdminShowtimeBloc>().add(AdminShowtimeInitial());
      },
      child: ListView.builder(
        itemCount: filteredShowtimes.length + (state.hasLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == filteredShowtimes.length) {
            return _buildLoadMoreButton(state);
          }

          final showtime = filteredShowtimes[index];
          return _buildShowtimeTile(showtime, state);
        },
      ),
    );
  }

  Widget _buildShowtimeTile(Showtime showtime, AdminShowtimeState state) {
    final movieName = _getMovieName(showtime.movieId, state.movies);
    final cinemaName = _getCinemaName(showtime.cinemaId, state.cinemas);
    final startTime = DateFormat(
      'MMM dd, yyyy - HH:mm',
    ).format(showtime.startTime);
    final endTime = DateFormat('HH:mm').format(showtime.endTime);
    final daytime = _getDaytimeFilter(showtime.startTime);
    final price = NumberFormat.currency(
      symbol: '\$',
    ).format(showtime.price / 100);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getDaytimeColor(daytime),
          child: Icon(_getDaytimeIcon(daytime), color: Colors.white),
        ),
        title: Text(
          movieName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Cinema: $cinemaName',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),
            Text(
              'Time: $startTime - $endTime',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getDaytimeColor(daytime).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    daytime,
                    style: TextStyle(
                      color: _getDaytimeColor(daytime),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: showtime.isActive
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    showtime.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: showtime.isActive ? Colors.blue : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowtimeForm(showtime: showtime),
                ),
              ).then((_) {
                // Refresh the list when returning from form
                context.read<AdminShowtimeBloc>().add(AdminShowtimeInitial());
              });
            } else if (value == 'archive') {
              _showArchiveDialog(showtime);
            } else if (value == 'restore') {
              _showRestoreDialog(showtime);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem(
              value: showtime.isActive ? 'archive' : 'restore',
              child: Row(
                children: [
                  Icon(
                    showtime.isActive ? Icons.archive : Icons.restore,
                    color: showtime.isActive ? Colors.orange : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(showtime.isActive ? 'Archive' : 'Restore'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowtimeForm(showtime: showtime),
            ),
          ).then((_) {
            // Refresh the list when returning from form
            context.read<AdminShowtimeBloc>().add(AdminShowtimeInitial());
          });
        },
      ),
    );
  }

  Widget _buildLoadMoreButton(AdminShowtimeState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          context.read<AdminShowtimeBloc>().add(AdminShowtimeLoadMore());
        },
        child: const Text('Load More'),
      ),
    );
  }

  Color _getDaytimeColor(String daytime) {
    switch (daytime) {
      case 'Morning':
        return Colors.orange;
      case 'Afternoon':
        return Colors.yellow[700]!;
      case 'Evening':
        return Colors.purple;
      case 'Night':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  IconData _getDaytimeIcon(String daytime) {
    switch (daytime) {
      case 'Morning':
        return Icons.wb_sunny;
      case 'Afternoon':
        return Icons.wb_sunny_outlined;
      case 'Evening':
        return Icons.nights_stay;
      case 'Night':
        return Icons.nightlight;
      default:
        return Icons.access_time;
    }
  }

  void _showArchiveDialog(Showtime showtime) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archive Showtime'),
        content: Text('Are you sure you want to archive this showtime?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminShowtimeBloc>().add(
                AdminShowtimeArchiveShowtime(showtimeId: showtime.id),
              );
            },
            child: const Text('Archive'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog(Showtime showtime) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Showtime'),
        content: Text('Are you sure you want to restore this showtime?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminShowtimeBloc>().add(
                AdminShowtimeRestoreShowtime(showtimeId: showtime.id),
              );
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }
}
