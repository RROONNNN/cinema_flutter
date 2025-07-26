import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_cinema_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:cinema_flutter/view/admin/cinemas/admin_cinemas_form.dart';
import 'package:cinema_flutter/view/admin/cinemas/admin_rooms_form.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_room_bloc.dart';

class AdminCinemasPage extends StatefulWidget {
  const AdminCinemasPage({super.key});

  @override
  State<AdminCinemasPage> createState() => _AdminCinemasPageState();
}

class _AdminCinemasPageState extends State<AdminCinemasPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    context.read<AdminCinemaBloc>().add(AdminCinemaSearchCinemas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cinemas Admin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      context.read<AdminCinemaBloc>().add(
                        AdminCinemaOnSearch(searchQuery: value),
                      );
                    },
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Cinemas',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onSearch,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<AdminCinemaBloc, AdminCinemaState>(
                builder: (context, state) {
                  if (state.status == AdminCinemaStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == AdminCinemaStatus.error) {
                    return Center(
                      child: Text(
                        state.errorMessage ?? 'Error loading cinemas',
                      ),
                    );
                  }
                  if (state.cinemas.isEmpty) {
                    return const Center(child: Text('No cinemas found.'));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.cinemas.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final cinema = state.cinemas[index];
                            return ListTile(
                              title: Text(cinema.name),
                              subtitle: Text(
                                '${cinema.address}, ${cinema.city}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _showAddRoomDialog(context, cinema),
                                    icon: const Icon(Icons.add_box),
                                    tooltip: 'Add Room',
                                  ),
                                  CupertinoSwitch(
                                    value: cinema.isActive,
                                    onChanged: (value) {
                                      if (value) {
                                        context.read<AdminCinemaBloc>().add(
                                          AdminCinemaRestoreCinema(
                                            cinemaId: cinema.id,
                                          ),
                                        );
                                      } else {
                                        context.read<AdminCinemaBloc>().add(
                                          AdminCinemaArchiveCinema(
                                            cinemaId: cinema.id,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                final bloc = context.read<AdminCinemaBloc>();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: AdminCinemasForm(
                                        cinemaId: cinema.id,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      if (state.hasLoadMore)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AdminCinemaBloc>().add(
                                AdminCinemaLoadMore(),
                              );
                            },
                            child: state.status == AdminCinemaStatus.loading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Load More'),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final bloc = context.read<AdminCinemaBloc>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const AdminCinemasForm(),
              ),
            ),
          );
        },
        tooltip: 'Add Cinema',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddRoomDialog(BuildContext context, cinema) {
    final TextEditingController roomNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Room'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Cinema: ${cinema.name}'),
              const SizedBox(height: 16),
              TextField(
                controller: roomNameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Room 1, VIP Hall, etc.',
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final roomName = roomNameController.text.trim();
                if (roomName.isNotEmpty) {
                  Navigator.of(context).pop();
                  _navigateToRoomForm(context, cinema.id, roomName);
                }
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRoomForm(
    BuildContext context,
    String cinemaId,
    String roomName,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AdminRoomBloc(),
          child: AdminRoomsForm(cinemaId: cinemaId, roomName: roomName),
        ),
      ),
    );
  }
}
