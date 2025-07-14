part of 'admin_movies_bloc.dart';

sealed class AdminMoviesEvent extends Equatable {
  const AdminMoviesEvent();

  @override
  List<Object> get props => [];
}

final class AdminMoviesInitial extends AdminMoviesEvent {}

final class AdiminMoviesLoadMore extends AdminMoviesEvent {}

final class AdminMoviesCacheImage extends AdminMoviesEvent {
  final String movieId;
  final Image thumbnail;

  const AdminMoviesCacheImage({required this.movieId, required this.thumbnail});

  @override
  List<Object> get props => [movieId, thumbnail];
}

final class AdminMoviesCreateMovie extends AdminMoviesEvent {
  final Map<String, dynamic> movieMap;

  const AdminMoviesCreateMovie({required this.movieMap});

  @override
  List<Object> get props => [movieMap];
}

final class AdminMoviesUpdateMovie extends AdminMoviesEvent {
  final String movieId;
  final Map<String, dynamic> movieMap;

  const AdminMoviesUpdateMovie({required this.movieId, required this.movieMap});

  @override
  List<Object> get props => [movieId, movieMap];
}
