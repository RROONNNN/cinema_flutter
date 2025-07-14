part of 'admin_movies_bloc.dart';

enum AdminMoviesStatus { loading, loaded, error }

class AdminMoviesState extends Equatable {
  final AdminMoviesStatus status;
  final List<Genres> availableGenres;
  final List<String> selectedGenreIds;
  final Movie? currentMovie;
  final bool isLoading;
  final List<Movie> movies;
  final int page;
  final int limit;
  final Map<String, Image> cachedThumbnails;

  const AdminMoviesState({
    this.status = AdminMoviesStatus.loading,
    this.availableGenres = const [],
    this.selectedGenreIds = const [],
    this.currentMovie,
    this.isLoading = false,
    this.movies = const [],
    this.page = 1,
    this.limit = 10,
    this.cachedThumbnails = const {},
  });

  @override
  List<Object?> get props => [
    status,
    availableGenres,
    selectedGenreIds,
    isLoading,
    currentMovie,
    movies,
    page,
    limit,
    cachedThumbnails,
  ];

  AdminMoviesState copyWith({
    AdminMoviesStatus? status,
    List<Genres>? availableGenres,
    List<String>? selectedGenreIds,
    Movie? currentMovie,
    bool? isLoading,
    List<Movie>? movies,
    int? page,
    int? limit,
    Map<String, Image>? cachedThumbnails,
  }) {
    return AdminMoviesState(
      status: status ?? this.status,
      availableGenres: availableGenres ?? this.availableGenres,
      selectedGenreIds: selectedGenreIds ?? this.selectedGenreIds,
      currentMovie: currentMovie ?? this.currentMovie,
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      cachedThumbnails: cachedThumbnails ?? this.cachedThumbnails,
    );
  }
}
