part of 'admin_cinema_bloc.dart';

sealed class AdminCinemaEvent extends Equatable {
  const AdminCinemaEvent();

  @override
  List<Object> get props => [];
}

final class AdminCinemaInitial extends AdminCinemaEvent {}

final class AdminCinemaLoadMore extends AdminCinemaEvent {}

final class AdminCinemaCacheImage extends AdminCinemaEvent {
  final String cinemaId;
  final Image thumbnail;

  const AdminCinemaCacheImage({
    required this.cinemaId,
    required this.thumbnail,
  });

  @override
  List<Object> get props => [cinemaId, thumbnail];
}

final class AdminCinemaCreateCinema extends AdminCinemaEvent {
  final Map<String, dynamic> cinemaMap;

  const AdminCinemaCreateCinema({required this.cinemaMap});

  @override
  List<Object> get props => [cinemaMap];
}

final class AdminCinemaUpdateCinema extends AdminCinemaEvent {
  final String cinemaId;
  final Map<String, dynamic> cinemaMap;

  const AdminCinemaUpdateCinema({
    required this.cinemaId,
    required this.cinemaMap,
  });

  @override
  List<Object> get props => [cinemaId, cinemaMap];
}

final class AdminCinemaArchiveCinema extends AdminCinemaEvent {
  final String cinemaId;

  const AdminCinemaArchiveCinema({required this.cinemaId});

  @override
  List<Object> get props => [cinemaId];
}

final class AdminCinemaRestoreCinema extends AdminCinemaEvent {
  final String cinemaId;

  const AdminCinemaRestoreCinema({required this.cinemaId});

  @override
  List<Object> get props => [cinemaId];
}

final class AdminCinemaSearchCinemas extends AdminCinemaEvent {
  const AdminCinemaSearchCinemas();

  @override
  List<Object> get props => [];
}

final class AdminCinemaLoadMoreCinemas extends AdminCinemaEvent {}

final class AdminCinemaOnSearch extends AdminCinemaEvent {
  final String searchQuery;

  const AdminCinemaOnSearch({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

final class AdminRoomAddedToCinema extends AdminCinemaEvent {
  final Room room;

  const AdminRoomAddedToCinema({required this.room});

  @override
  List<Object> get props => [room];
}

final class AdminCinemaLoadCinema extends AdminCinemaEvent {
  final String cinemaId;

  const AdminCinemaLoadCinema({required this.cinemaId});

  @override
  List<Object> get props => [cinemaId];
}

final class AdminCinemaRemoveLoadedCinema extends AdminCinemaEvent {}
