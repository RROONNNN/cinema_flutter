part of 'admin_movies_bloc.dart';

enum AdminMoviesStatus { loading, loaded, error, success }

class AdminMoviesState extends Equatable {
  final AdminMoviesStatus status;
  final List<Genres> availableGenres;
  final List<String> selectedGenreIds;
  final Movie? selectedMovie;
  final bool isLoading;
  final List<Movie> movies;
  final int page;
  final int limit;
  final Map<String, Image> cachedThumbnails;
  final String? errorMessage;
  final String? successMessage;

  const AdminMoviesState({
    this.status = AdminMoviesStatus.loading,
    this.availableGenres = const [],
    this.selectedGenreIds = const [],
    this.selectedMovie,
    this.isLoading = false,
    this.movies = const [],
    this.page = 1,
    this.limit = 10,
    this.cachedThumbnails = const {},
    this.errorMessage,
    this.successMessage,
  });

  @override
  List<Object?> get props => [
    status,
    availableGenres,
    selectedGenreIds,
    isLoading,
    selectedMovie,
    movies,
    page,
    limit,
    cachedThumbnails,
    errorMessage,
    successMessage,
  ];

  AdminMoviesState copyWith({
    AdminMoviesStatus? status,
    List<Genres>? availableGenres,
    List<String>? selectedGenreIds,
    Movie? selectedMovie,
    bool? isLoading,
    List<Movie>? movies,
    int? page,
    int? limit,
    Map<String, Image>? cachedThumbnails,
    String? errorMessage,
    String? successMessage,
  }) {
    return AdminMoviesState(
      status: status ?? AdminMoviesStatus.loaded,
      availableGenres: availableGenres ?? this.availableGenres,
      selectedGenreIds: selectedGenreIds ?? this.selectedGenreIds,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      isLoading: isLoading ?? false,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      cachedThumbnails: cachedThumbnails ?? this.cachedThumbnails,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
