import 'package:cinema_flutter/model/data_models/cinema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/model/data_models/movie.dart';
import 'package:cinema_flutter/model/data_models/showtime.dart';
import 'package:cinema_flutter/model/services/cinema_service.dart';
import 'package:cinema_flutter/model/services/movie_service.dart';
import 'package:cinema_flutter/model/services/showtime_service.dart';
import 'package:equatable/equatable.dart';

part 'admin_showtime_event.dart';
part 'admin_showtime_state.dart';

class AdminShowtimeBloc extends Bloc<AdminShowtimeEvent, AdminShowtimeState> {
  late final ShowtimeService _showtimeService;
  late final MovieService _movieService;
  late final CinemaService _cinemaService;
  AdminShowtimeBloc() : super(AdminShowtimeState()) {
    _showtimeService = ShowtimeService();
    _movieService = MovieService();
    _cinemaService = CinemaService();
    on<AdminShowtimeInitial>(_onAdminShowtimeInitial);
    on<AdminShowtimeLoadMore>(_onAdminShowtimeLoadMore);
    on<AdminShowtimeCreateShowtime>(_onAdminShowtimeCreateShowtime);
    on<AdminShowtimeUpdateShowtime>(_onAdminShowtimeUpdateShowtime);
    on<AdminShowtimeArchiveShowtime>(_onAdminShowtimeArchiveShowtime);
    on<AdminShowtimeRestoreShowtime>(_onAdminShowtimeRestoreShowtime);
    on<AdminShowtimeSearchShowtimes>(_onAdminShowtimeSearchShowtimes);
    on<AdminShowtimeOnSearch>(_onAdminShowtimeOnSearch);
    on<AdminShowtimeGetAllMovies>(_onAdminShowtimeGetAllMovies);
    on<AdminShowtimeGetAllCinemas>(_onAdminShowtimeGetAllCinemas);
  }
  Future<void> _onAdminShowtimeGetAllCinemas(
    AdminShowtimeGetAllCinemas event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    final cinemas = await _cinemaService.getCinemas();
    emit(
      state.copyWith(
        cinemas: cinemas.map((cinema) => _mapCinemaToJson(cinema)).toList(),
      ),
    );
  }

  Image _getCachedThumbnail(String movieId, String thumbnail) {
    return state.cachedThumbnails[movieId] ?? Image.network(thumbnail);
  }

  Map<String, dynamic> _mapMovieToJson(Movie movie) {
    return {
      'id': movie.id,
      'name': movie.title,
      'thumbnailImage': _getCachedThumbnail(movie.id, movie.thumbnail),
    };
  }

  Map<String, dynamic> _mapCinemaToJson(Cinema cinema) {
    return {'id': cinema.id, 'name': cinema.name, 'address': cinema.address};
  }

  Future<void> _onAdminShowtimeGetAllMovies(
    AdminShowtimeGetAllMovies event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    try {
      final movies = await _movieService.getMovies();
      emit(
        state.copyWith(
          movies: movies.map((movie) => _mapMovieToJson(movie)).toList(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeOnSearch(
    AdminShowtimeOnSearch event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  Future<void> _onAdminShowtimeSearchShowtimes(
    AdminShowtimeSearchShowtimes event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    emit(state.copyWith(status: AdminShowtimeStatus.loading));
    try {
      final showtimes = await _showtimeService.getShowtimes(
        page: 1,
        limit: 10,
        search: state.searchQuery,
      );
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.loaded,
          showtimes: showtimes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeRestoreShowtime(
    AdminShowtimeRestoreShowtime event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    try {
      await _showtimeService.restoreShowtime(event.showtimeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeArchiveShowtime(
    AdminShowtimeArchiveShowtime event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    try {
      await _showtimeService.archiveShowtime(event.showtimeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeUpdateShowtime(
    AdminShowtimeUpdateShowtime event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      final showtime = await _showtimeService.updateShowtime(
        event.showtimeId,
        event.showtimeMap,
      );
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.success,
          showtimes: [...state.showtimes, showtime],
          isSaving: false,
          successMessage: 'Showtime updated successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeCreateShowtime(
    AdminShowtimeCreateShowtime event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      final showtime = await _showtimeService.createShowtime(event.showtimeMap);
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.success,
          showtimes: [...state.showtimes, showtime],
          isSaving: false,
          successMessage: 'Showtime created successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeInitial(
    AdminShowtimeInitial event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    emit(state.copyWith(status: AdminShowtimeStatus.loading));
    try {
      final showtimes = await _showtimeService.getShowtimes(
        page: 1,
        limit: 10,
        search: state.searchQuery,
      );
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.loaded,
          showtimes: showtimes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdminShowtimeLoadMore(
    AdminShowtimeLoadMore event,
    Emitter<AdminShowtimeState> emit,
  ) async {
    if (!state.hasLoadMore) {
      return;
    }
    try {
      final showtimes = await _showtimeService.getShowtimes(
        page: state.page + 1,
        limit: state.limit,
        search: state.searchQuery,
      );
      if (showtimes.isNotEmpty) {
        final hasLoadMore = showtimes.length == state.limit;
        final newPage = hasLoadMore ? state.page + 1 : state.page;
        emit(
          state.copyWith(
            showtimes: [...state.showtimes, ...showtimes],
            page: newPage,
            hasLoadMore: hasLoadMore,
          ),
        );
      } else {
        emit(state.copyWith(hasLoadMore: false));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminShowtimeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
