import 'package:cinema_flutter/view_model/admin/movies/bloc/admin_movies_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminGenresPage extends StatefulWidget {
  const AdminGenresPage({super.key});

  @override
  State<AdminGenresPage> createState() => _AdminGenresPageState();
}

class _AdminGenresPageState extends State<AdminGenresPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<AdminMoviesBloc>().add(AdminMoviesInitial());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<AdminMoviesBloc>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50 &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      bloc.add(AdminMoviesLoadMoreGenres());
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  void _showGenreDialog({Map<String, dynamic>? initial, String? genreId}) {
    final nameController = TextEditingController(text: initial?['name'] ?? '');
    final descController = TextEditingController(
      text: initial?['description'] ?? '',
    );
    final bloc = context.read<AdminMoviesBloc>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(genreId == null ? 'Create Genre' : 'Update Genre'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                minLines: 2,
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final map = {
                  'name': nameController.text.trim(),
                  'description': descController.text.trim(),
                };
                if (genreId == null) {
                  bloc.add(AdminMoviesCreateGenre(genreMap: map));
                } else {
                  bloc.add(
                    AdminMoviesUpdateGenre(genreId: genreId, genreMap: map),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(genreId == null ? 'Create' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminMoviesBloc, AdminMoviesState>(
      listener: (context, state) {
        if (state.status == AdminMoviesStatus.success) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage ?? ''),
              backgroundColor: Colors.green,
            ),
          );
          context.read<AdminMoviesBloc>().add(AdminMoviesReset());
        }
        if (state.status == AdminMoviesStatus.error) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? ''),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Genres',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AdminMoviesBloc>().add(AdminMoviesReset());
                _showGenreDialog();
              },
              icon: const Icon(Icons.add, color: Colors.blueAccent),
              tooltip: 'Add Genre',
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<AdminMoviesBloc>().add(
                          AdminMoviesOnSearchChange(searchQuery: value.trim()),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Search genres...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                      ),
                      onSubmitted: (value) {
                        context.read<AdminMoviesBloc>().add(
                          AdminMoviesSearchGenres(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AdminMoviesBloc>().add(
                        AdminMoviesSearchGenres(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<AdminMoviesBloc, AdminMoviesState>(
                builder: (context, state) {
                  if (state.status == AdminMoviesStatus.loading &&
                      state.availableGenres.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == AdminMoviesStatus.error &&
                      state.availableGenres.isEmpty) {
                    return const Center(
                      child: Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                    );
                  }
                  if (state.availableGenres.isNotEmpty) {
                    return Stack(
                      children: [
                        ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          itemCount: state.availableGenres.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final genre = state.availableGenres[index];
                            return Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                title: Text(
                                  genre.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                subtitle: Text(
                                  genre.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CupertinoSwitch(
                                      value: genre.isActive,
                                      onChanged: (value) {
                                        if (value) {
                                          context.read<AdminMoviesBloc>().add(
                                            AdminMoviesRestoreGenre(
                                              genreId: genre.id,
                                            ),
                                          );
                                        } else {
                                          context.read<AdminMoviesBloc>().add(
                                            AdminMoviesArchiveGenre(
                                              genreId: genre.id,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        _showGenreDialog(
                                          initial: {
                                            'name': genre.name,
                                            'description': genre.description,
                                          },
                                          genreId: genre.id,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (_isLoadingMore)
                          const Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No genres found',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
