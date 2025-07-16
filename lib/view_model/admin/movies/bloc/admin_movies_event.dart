part of 'admin_movies_bloc.dart';

sealed class AdminMoviesEvent extends Equatable {
  const AdminMoviesEvent();

  @override
  List<Object> get props => [];
}

final class AdminMoviesInitial extends AdminMoviesEvent {}

final class AdminMoviesLoadMore extends AdminMoviesEvent {}

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

final class AdminMoviesReset
    extends
        AdminMoviesEvent {} // when create or update is success, reset the state

final class AdminMoviesArchiveMovie extends AdminMoviesEvent {
  final String movieId;

  const AdminMoviesArchiveMovie({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

final class AdminMoviesRestoreMovie extends AdminMoviesEvent {
  final String movieId;

  const AdminMoviesRestoreMovie({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

final class AdminMoviesInitBeforeUpdate extends AdminMoviesEvent {
  final Movie movie;

  const AdminMoviesInitBeforeUpdate({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class AdminMoviesCreateGenre extends AdminMoviesEvent {
  final Map<String, dynamic> genreMap;

  const AdminMoviesCreateGenre({required this.genreMap});

  @override
  List<Object> get props => [genreMap];
}

final class AdminMoviesUpdateGenre extends AdminMoviesEvent {
  final String genreId;
  final Map<String, dynamic> genreMap;

  const AdminMoviesUpdateGenre({required this.genreId, required this.genreMap});

  @override
  List<Object> get props => [genreId, genreMap];
}

final class AdminMoviesArchiveGenre extends AdminMoviesEvent {
  final String genreId;

  const AdminMoviesArchiveGenre({required this.genreId});

  @override
  List<Object> get props => [genreId];
}

final class AdminMoviesRestoreGenre extends AdminMoviesEvent {
  final String genreId;

  const AdminMoviesRestoreGenre({required this.genreId});

  @override
  List<Object> get props => [genreId];
}

final class AdminMoviesSearchMovies extends AdminMoviesEvent {
  const AdminMoviesSearchMovies();

  @override
  List<Object> get props => [];
}

final class AdminMoviesSearchGenres extends AdminMoviesEvent {
  const AdminMoviesSearchGenres();

  @override
  List<Object> get props => [];
}

final class AdminMoviesLoadMoreGenres extends AdminMoviesEvent {}

final class AdminMoviesOnSearchChange extends AdminMoviesEvent {
  final String searchQuery;

  const AdminMoviesOnSearchChange({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}
