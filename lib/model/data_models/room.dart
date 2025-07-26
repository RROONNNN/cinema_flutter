import 'package:cinema_flutter/view_model/admin/cinemas/seat_layout_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cinema.dart';
import 'seat.dart';

part 'room.freezed.dart';
part 'room.g.dart';

class SeatLayoutConverter
    implements JsonConverter<List<SeatLayoutItem>, List<dynamic>> {
  const SeatLayoutConverter();

  @override
  List<SeatLayoutItem> fromJson(List<dynamic> json) => json
      .map((e) => SeatLayoutItem.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  List<dynamic> toJson(List<SeatLayoutItem> object) =>
      object.map((e) => e.toJson()).toList();
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required String cinemaId,
    Cinema? cinema,
    required int totalSeats,
    required List<SeatLayoutItem> seatLayout,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<Seat> seats,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
