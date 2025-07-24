import 'package:freezed_annotation/freezed_annotation.dart';
import 'cinema.dart';
import 'seat.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required String cinemaId,
    Cinema? cinema,
    required int totalSeats,
    required Map<String, dynamic> seatLayout,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<Seat> seats,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
