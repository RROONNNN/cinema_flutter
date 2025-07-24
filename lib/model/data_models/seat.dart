import 'package:freezed_annotation/freezed_annotation.dart';
import 'room.dart';

part 'seat.freezed.dart';
part 'seat.g.dart';

@freezed
class Seat with _$Seat {
  const factory Seat({
    required String id,
    required String roomId,
    Room? room,
    required String seatNumber,
    @Default('NORMAL') String seatType,
    @Default(0.0) double extraPrice,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Seat;

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);
}
