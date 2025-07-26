part of 'admin_cinema_bloc.dart';

enum AdminCinemaStatus { loading, loaded, error, success }

class AdminCinemaState extends Equatable {
  final AdminCinemaStatus status;
  final List<Cinema> cinemas;
  final int page;
  final int limit;
  final bool hasLoadMore;
  final String? searchQuery;
  final String? errorMessage;
  final String? successMessage;
  final Map<String, Image> cachedThumbnails;
  final bool isSaving;
  final Cinema? loadedCinema;

  const AdminCinemaState({
    this.status = AdminCinemaStatus.loading,
    this.cinemas = const [],
    this.page = 1,
    this.limit = 3,
    this.hasLoadMore = true,
    this.searchQuery,
    this.errorMessage,
    this.successMessage,
    this.cachedThumbnails = const {},
    this.isSaving = false,
    this.loadedCinema,
  });

  @override
  List<Object?> get props => [
    status,
    cinemas,
    page,
    limit,
    hasLoadMore,
    errorMessage,
    successMessage,
    cachedThumbnails,
    isSaving,
    loadedCinema,
  ];

  AdminCinemaState copyWith({
    AdminCinemaStatus? status,
    List<Cinema>? cinemas,
    int? page,
    int? limit,
    bool? hasLoadMore,
    String? searchQuery,
    String? errorMessage,
    String? successMessage,
    Map<String, Image>? cachedThumbnails,
    bool? isSaving,
    Cinema? loadedCinema,
  }) {
    return AdminCinemaState(
      status: status ?? this.status,
      cinemas: cinemas ?? this.cinemas,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      hasLoadMore: hasLoadMore ?? this.hasLoadMore,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      cachedThumbnails: cachedThumbnails ?? this.cachedThumbnails,
      isSaving: isSaving ?? this.isSaving,
      loadedCinema: loadedCinema ?? this.loadedCinema,
    );
  }
}
