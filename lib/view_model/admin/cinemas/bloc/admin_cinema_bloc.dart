import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:cinema_flutter/model/services/cinema_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/model/data_models/cinema.dart';
import 'package:equatable/equatable.dart';

part 'admin_cinema_event.dart';
part 'admin_cinema_state.dart';

class AdminCinemaBloc extends Bloc<AdminCinemaEvent, AdminCinemaState> {
  late final CinemaService _cinemaService;
  AdminCinemaBloc() : super(AdminCinemaState()) {
    _cinemaService = CinemaService();
    on<AdminCinemaInitial>(_onAdminCinemaInitial);
    on<AdminCinemaLoadMore>(_onAdminCinemaLoadMore);
    on<AdminCinemaCacheImage>(_onAdminCinemaCacheImage);
    on<AdminCinemaCreateCinema>(_onAdminCinemaCreateCinema);
    on<AdminCinemaUpdateCinema>(_onAdminCinemaUpdateCinema);
    on<AdminCinemaArchiveCinema>(_onAdminCinemaArchiveCinema);
    on<AdminCinemaRestoreCinema>(_onAdminCinemaRestoreCinema);
    on<AdminCinemaSearchCinemas>(_onAdminCinemaSearchCinemas);
    on<AdminCinemaOnSearch>(_onAdminCinemaOnSearch);
    on<AdminRoomAddedToCinema>(_onAdminRoomAddedToCinema);
    on<AdminCinemaLoadCinema>(_onAdminCinemaLoadCinema);
    on<AdminCinemaRemoveLoadedCinema>(_onAdminCinemaRemoveLoadedCinema);
  }

  Future<void> _onAdminCinemaRemoveLoadedCinema(
    AdminCinemaRemoveLoadedCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    emit(state.copyWith(loadedCinema: null));
  }

  Future<void> _onAdminCinemaLoadCinema(
    AdminCinemaLoadCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      final cinema = await _cinemaService.getCinemaById(event.cinemaId);
      emit(state.copyWith(loadedCinema: cinema));
    } catch (e) {
      debugPrint("Error loading cinema: $e");
      emit(state.copyWith(errorMessage: "Error loading cinema: $e"));
    }
  }

  Future<void> _onAdminRoomAddedToCinema(
    AdminRoomAddedToCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      bool found = false;
      final newCinemas = state.cinemas.map((cinema) {
        if (cinema.id == event.room.cinemaId) {
          found = true;
          return cinema.copyWith(rooms: [...cinema.rooms, event.room]);
        }
        return cinema;
      }).toList();
      if (!found) {
        final cinema = await _cinemaService.getCinemaById(event.room.cinemaId);
        newCinemas.add(cinema.copyWith(rooms: [event.room]));
      }
      emit(state.copyWith(cinemas: newCinemas));
    } catch (e) {
      debugPrint("Error adding room to cinema: $e");
      emit(state.copyWith(errorMessage: "Error adding room to cinema: $e"));
    }
  }

  Future<void> _onAdminCinemaOnSearch(
    AdminCinemaOnSearch event,
    Emitter<AdminCinemaState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  Future<void> _onAdminCinemaSearchCinemas(
    AdminCinemaSearchCinemas event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      final cinemas = await _cinemaService.getCinemas(
        page: 1,
        limit: 10,
        search: state.searchQuery?.trim(),
      );
      emit(state.copyWith(status: AdminCinemaStatus.loaded, cinemas: cinemas));
    } catch (e) {
      debugPrint("Error searching cinemas: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdminCinemaRestoreCinema(
    AdminCinemaRestoreCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      await _cinemaService.restoreCinema(event.cinemaId);
      final newCinemas = state.cinemas.map((c) {
        if (c.id == event.cinemaId) {
          return c.copyWith(isActive: true);
        }
        return c;
      }).toList();

      emit(
        state.copyWith(
          status: AdminCinemaStatus.loaded,
          cinemas: newCinemas,
          isSaving: false,
        ),
      );
    } catch (e) {
      debugPrint("Error restoring cinema: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminCinemaArchiveCinema(
    AdminCinemaArchiveCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      await _cinemaService.archiveCinema(event.cinemaId);
      final newCinemas = state.cinemas.map((c) {
        if (c.id == event.cinemaId) {
          return c.copyWith(isActive: false);
        }
        return c;
      }).toList();

      emit(
        state.copyWith(
          status: AdminCinemaStatus.loaded,
          cinemas: newCinemas,
          isSaving: false,
        ),
      );
    } catch (e) {
      debugPrint("Error archiving cinema: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminCinemaUpdateCinema(
    AdminCinemaUpdateCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true));
      final cinema = await _cinemaService.updateCinema(
        event.cinemaId,
        event.cinemaMap,
      );
      emit(
        state.copyWith(
          status: AdminCinemaStatus.loaded,
          cinemas: [...state.cinemas, cinema],
          isSaving: false,
        ),
      );
    } catch (e) {
      debugPrint("Error updating cinema: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminCinemaCreateCinema(
    AdminCinemaCreateCinema event,
    Emitter<AdminCinemaState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true));
      final cinema = await _cinemaService.createCinema(event.cinemaMap);
      emit(
        state.copyWith(
          status: AdminCinemaStatus.loaded,
          cinemas: [...state.cinemas, cinema],
          isSaving: false,
        ),
      );
    } catch (e) {
      debugPrint("Error creating cinema: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
          isSaving: false,
        ),
      );
    }
  }

  Future<void> _onAdminCinemaCacheImage(
    AdminCinemaCacheImage event,
    Emitter<AdminCinemaState> emit,
  ) async {
    emit(
      state.copyWith(
        cachedThumbnails: {
          ...state.cachedThumbnails,
          event.cinemaId: event.thumbnail,
        },
      ),
    );
  }

  Future<void> _onAdminCinemaInitial(
    AdminCinemaInitial event,
    Emitter<AdminCinemaState> emit,
  ) async {
    if (state.status == AdminCinemaStatus.loaded) {
      return;
    }
    emit(state.copyWith(status: AdminCinemaStatus.loading));
    try {
      final cinemas = await _cinemaService.getCinemas(page: 1, limit: 10);
      emit(state.copyWith(status: AdminCinemaStatus.loaded, cinemas: cinemas));
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdminCinemaLoadMore(
    AdminCinemaLoadMore event,
    Emitter<AdminCinemaState> emit,
  ) async {
    if (!state.hasLoadMore) {
      return;
    }
    try {
      final cinemas = await _cinemaService.getCinemas(
        page: state.page + 1,
        limit: state.limit,
        search: state.searchQuery,
      );
      if (cinemas.isNotEmpty) {
        final hasLoadMore = cinemas.length == state.limit;
        final newPage = hasLoadMore ? state.page + 1 : state.page;
        emit(
          state.copyWith(
            cinemas: [...state.cinemas, ...cinemas],
            page: newPage,
            hasLoadMore: hasLoadMore,
          ),
        );
      } else {
        emit(state.copyWith(hasLoadMore: false));
      }
    } catch (e) {
      debugPrint("Error loading more cinemas: $e");
      emit(
        state.copyWith(
          status: AdminCinemaStatus.error,
          errorMessage: "Error loading more cinemas: $e",
        ),
      );
    }
  }
}
