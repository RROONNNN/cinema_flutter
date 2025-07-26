part of 'admin_room_bloc.dart';

sealed class AdminRoomEvent extends Equatable {
  const AdminRoomEvent();

  @override
  List<Object> get props => [];
}

final class AdminRoomInitial extends AdminRoomEvent {
  const AdminRoomInitial();
}

final class AdminRoomSelectHighestRow extends AdminRoomEvent {
  final String row;
  const AdminRoomSelectHighestRow({required this.row});
}

final class AdminRoomSelectHighestColumn extends AdminRoomEvent {
  final int column;
  const AdminRoomSelectHighestColumn({required this.column});
}

final class AdminRoomSelectSeatType extends AdminRoomEvent {
  final SeatType seatType;
  const AdminRoomSelectSeatType({required this.seatType});
}

final class AdminRoomAddSeat extends AdminRoomEvent {
  final SeatLayoutItem seat;
  const AdminRoomAddSeat({required this.seat});
}

final class AdminRoomRemoveSeat extends AdminRoomEvent {
  final SeatLayoutItem seat;
  const AdminRoomRemoveSeat({required this.seat});
}

final class AdminRoomCreateRoom extends AdminRoomEvent {
  final Map<String, dynamic> roomData;
  const AdminRoomCreateRoom({required this.roomData});
}
