import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cinema.freezed.dart';
part 'cinema.g.dart';

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
