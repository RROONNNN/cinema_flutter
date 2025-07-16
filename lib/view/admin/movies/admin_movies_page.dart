import 'package:cinema_flutter/view/admin/movies/admin_movies_form.dart';
import 'package:cinema_flutter/view_model/admin/movies/bloc/admin_movies_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMoviesPage extends StatefulWidget {
  const AdminMoviesPage({super.key});

  @override
  State<AdminMoviesPage> createState() => _AdminMoviesPageState();
}

class _AdminMoviesPageState extends State<AdminMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminMoviesBloc>().add(AdminMoviesInitial());
  }

  Image? _loadThumbnail(String thumbnailUrl, String movieId) {
    if (thumbnailUrl.isEmpty) return null;
    try {
      final thumbnail = Image.network(thumbnailUrl);
      context.read<AdminMoviesBloc>().add(
        AdminMoviesCacheImage(movieId: movieId, thumbnail: thumbnail),
      );
      return thumbnail;
    } catch (e) {
      debugPrint('Error loading thumbnail: $e');
      return null;
    }
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
            'Movies',
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
                final bloc = context.read<AdminMoviesBloc>();
                bloc.add(AdminMoviesReset());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: const AdminMoviesForm(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Colors.blueAccent),
              tooltip: 'Add Movie',
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: BlocBuilder<AdminMoviesBloc, AdminMoviesState>(
          builder: (context, state) {
            if (state.status == AdminMoviesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == AdminMoviesStatus.error) {
              return const Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
              );
            }
            if (state.movies.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                itemCount: state.movies.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  final Image? thumbnail =
                      state.cachedThumbnails[movie.id] ??
                      _loadThumbnail(movie.thumbnail, movie.id);
                  return GestureDetector(
                    onTap: () {
                      final bloc = context.read<AdminMoviesBloc>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: AdminMoviesForm(
                              currentMovie: movie,
                              isEditing: true,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 90,
                                height: 60,
                                color: Colors.grey[300],
                                child:
                                    thumbnail ??
                                    const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    movie.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CupertinoSwitch(
                              value: movie.isActive,
                              onChanged: (value) {
                                if (value) {
                                  context.read<AdminMoviesBloc>().add(
                                    AdminMoviesRestoreMovie(movieId: movie.id),
                                  );
                                } else {
                                  context.read<AdminMoviesBloc>().add(
                                    AdminMoviesArchiveMovie(movieId: movie.id),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.movie_filter_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No movies found',
                    style: TextStyle(color: Colors.grey[600], fontSize: 18),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
