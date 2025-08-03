part of 'admin_showtime_bloc.dart';

enum AdminShowtimeStatus { loading, loaded, error, success }

class AdminShowtimeState extends Equatable {
  final AdminShowtimeStatus status;
  final List<Showtime> showtimes;
  final Showtime? loadedShowtime;
  final int page;
  final int limit;
  final bool hasLoadMore;
  final String? searchQuery;
  final String? errorMessage;
  final String? successMessage;
  final bool isSaving;
  final List<Map<String, dynamic>> movies;
  final List<Map<String, dynamic>> cinemas;
  final Map<String, Image> cachedThumbnails;
  const AdminShowtimeState({
    this.status = AdminShowtimeStatus.loading,
    this.showtimes = const [],
    this.loadedShowtime,
    this.page = 1,
    this.limit = 10,
    this.hasLoadMore = true,
    this.searchQuery,
    this.errorMessage,
    this.successMessage,
    this.isSaving = false,
    this.movies = const [],
    this.cinemas = const [],
    this.cachedThumbnails = const {},
  });

  @override
  List<Object?> get props => [
    status,
    showtimes,
    loadedShowtime,
    page,
    limit,
    hasLoadMore,
    searchQuery,
    errorMessage,
    successMessage,
    isSaving,
    movies,
    cinemas,
    cachedThumbnails,
  ];
  AdminShowtimeState copyWith({
    AdminShowtimeStatus? status,
    List<Showtime>? showtimes,
    Showtime? loadedShowtime,
    int? page,
    int? limit,
    bool? hasLoadMore,
    String? searchQuery,
    String? errorMessage,
    String? successMessage,
    bool clearLoadedShowtime = false,
    bool? isSaving,
    List<Map<String, dynamic>>? movies,
    List<Map<String, dynamic>>? cinemas,
    Map<String, Image>? cachedThumbnails,
  }) {
    return AdminShowtimeState(
      status: status ?? this.status,
      showtimes: showtimes ?? this.showtimes,
      loadedShowtime: clearLoadedShowtime
          ? null
          : loadedShowtime ?? this.loadedShowtime,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasLoadMore: hasLoadMore ?? this.hasLoadMore,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isSaving: isSaving ?? this.isSaving,
      movies: movies ?? this.movies,
      cinemas: cinemas ?? this.cinemas,
      cachedThumbnails: cachedThumbnails ?? this.cachedThumbnails,
    );
  }

  AdminShowtimeState removeLoadedShowtime() {
    return copyWith(clearLoadedShowtime: true);
  }
}
