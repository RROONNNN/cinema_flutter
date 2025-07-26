part of 'admin_room_bloc.dart';

enum AdminRoomStatus { loading, loaded, error }

class AdminRoomState extends Equatable {
  final AdminRoomStatus status;
  final String highestRow;
  final int highestColumn;
  final List<SeatLayoutItem> seatLayout;
  final SeatType selectedSeatType;
  final String? errorMessage;
  final bool isSaving;
  final String? successMessage;
  final Room? roomSaved;

  const AdminRoomState({
    this.status = AdminRoomStatus.loading,
    this.highestRow = 'H',
    this.highestColumn = 10,
    this.seatLayout = const [],
    this.selectedSeatType = SeatType.NORMAL,
    this.errorMessage,
    this.isSaving = false,
    this.successMessage,
    this.roomSaved,
  });

  @override
  List<Object?> get props => [
    status,
    highestRow,
    highestColumn,
    seatLayout,
    selectedSeatType,
    errorMessage,
    isSaving,
    successMessage,
    roomSaved,
  ];

  AdminRoomState copyWith({
    AdminRoomStatus? status,
    String? highestRow,
    int? highestColumn,
    List<SeatLayoutItem>? seatLayout,
    SeatType? selectedSeatType,
    String? errorMessage,
    bool? isSaving,
    String? successMessage,
    Room? roomSaved,
  }) {
    return AdminRoomState(
      status: status ?? this.status,
      highestRow: highestRow ?? this.highestRow,
      highestColumn: highestColumn ?? this.highestColumn,
      seatLayout: seatLayout ?? this.seatLayout,
      selectedSeatType: selectedSeatType ?? this.selectedSeatType,
      errorMessage: errorMessage,
      isSaving: isSaving ?? false,
      successMessage: successMessage,
      roomSaved: roomSaved ?? this.roomSaved,
    );
  }
}
