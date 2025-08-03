part of 'admin_showtime_bloc.dart';

sealed class AdminShowtimeEvent extends Equatable {
  const AdminShowtimeEvent();

  @override
  List<Object> get props => [];
}

final class AdminShowtimeInitial extends AdminShowtimeEvent {}

final class AdminShowtimeLoadMore extends AdminShowtimeEvent {}

final class AdminShowtimeCreateShowtime extends AdminShowtimeEvent {
  final Map<String, dynamic> showtimeMap;

  const AdminShowtimeCreateShowtime({required this.showtimeMap});

  @override
  List<Object> get props => [showtimeMap];
}

final class AdminShowtimeUpdateShowtime extends AdminShowtimeEvent {
  final String showtimeId;
  final Map<String, dynamic> showtimeMap;

  const AdminShowtimeUpdateShowtime({
    required this.showtimeId,
    required this.showtimeMap,
  });
}

final class AdminShowtimeArchiveShowtime extends AdminShowtimeEvent {
  final String showtimeId;

  const AdminShowtimeArchiveShowtime({required this.showtimeId});
}

final class AdminShowtimeRestoreShowtime extends AdminShowtimeEvent {
  final String showtimeId;

  const AdminShowtimeRestoreShowtime({required this.showtimeId});
}

final class AdminShowtimeSearchShowtimes extends AdminShowtimeEvent {
  const AdminShowtimeSearchShowtimes();
}

final class AdminShowtimeOnSearch extends AdminShowtimeEvent {
  final String searchQuery;

  const AdminShowtimeOnSearch({required this.searchQuery});
}

final class AdminShowtimeGetAllMovies extends AdminShowtimeEvent {}

final class AdminShowtimeGetAllCinemas extends AdminShowtimeEvent {}
