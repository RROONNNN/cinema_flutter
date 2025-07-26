import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cinema.freezed.dart';
part 'cinema.g.dart';

class RoomConverter implements JsonConverter<Room, Map<String, dynamic>> {
  const RoomConverter();

  @override
  Room fromJson(Map<String, dynamic> json) => Room.fromJson(json);

  @override
  Map<String, dynamic> toJson(Room room) => room.toJson();
}

@freezed
class Cinema with _$Cinema {
  const factory Cinema({
    required String id,
    required String name,
    required String address,
    required String city,
    @Default(true) bool isActive,
    double? longitude,
    double? latitude,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<Room> rooms,
  }) = _Cinema;

  factory Cinema.fromJson(Map<String, dynamic> json) => _$CinemaFromJson(json);
}
