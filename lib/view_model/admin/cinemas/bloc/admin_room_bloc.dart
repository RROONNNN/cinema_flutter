import 'package:bloc/bloc.dart';
import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:cinema_flutter/model/services/cinema_service.dart';
import 'package:cinema_flutter/shared/enums/seat_type.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/seat_layout_item.dart';
import 'package:equatable/equatable.dart';

part 'admin_room_event.dart';
part 'admin_room_state.dart';

class AdminRoomBloc extends Bloc<AdminRoomEvent, AdminRoomState> {
  late final CinemaService _cinemaService;
  AdminRoomBloc() : super(const AdminRoomState()) {
    _cinemaService = CinemaService();
    on<AdminRoomSelectHighestRow>(_onSelectHighestRow);
    on<AdminRoomSelectHighestColumn>(_onSelectHighestColumn);
    on<AdminRoomSelectSeatType>(_onSelectSeatType);
    on<AdminRoomAddSeat>(_onAddSeat);
    on<AdminRoomRemoveSeat>(_onRemoveSeat);
    on<AdminRoomCreateRoom>(_onCreateRoom);
    //create a blocListener to add this room to the cinema in admin_cinema_bloc
  }

  Future<void> _onCreateRoom(
    AdminRoomCreateRoom event,
    Emitter<AdminRoomState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true));
      final room = await _cinemaService.createRoom(event.roomData);
      emit(
        state.copyWith(
          successMessage: 'Room created successfully',
          roomSaved: room,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to create room'));
    }
  }

  Future<void> _onSelectHighestRow(
    AdminRoomSelectHighestRow event,
    Emitter<AdminRoomState> emit,
  ) async {
    emit(state.copyWith(highestRow: event.row));
  }

  Future<void> _onSelectHighestColumn(
    AdminRoomSelectHighestColumn event,
    Emitter<AdminRoomState> emit,
  ) async {
    emit(state.copyWith(highestColumn: event.column));
  }

  Future<void> _onSelectSeatType(
    AdminRoomSelectSeatType event,
    Emitter<AdminRoomState> emit,
  ) async {
    emit(state.copyWith(selectedSeatType: event.seatType));
  }

  Future<void> _onAddSeat(
    AdminRoomAddSeat event,
    Emitter<AdminRoomState> emit,
  ) async {
    emit(state.copyWith(seatLayout: [...state.seatLayout, event.seat]));
  }

  Future<void> _onRemoveSeat(
    AdminRoomRemoveSeat event,
    Emitter<AdminRoomState> emit,
  ) async {
    emit(
      state.copyWith(
        seatLayout: state.seatLayout
            .where(
              (seat) =>
                  seat.row != event.seat.row || seat.col != event.seat.col,
            )
            .toList(),
      ),
    );
  }
}
