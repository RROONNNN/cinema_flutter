// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  cinemaId: json['cinemaId'] as String,
  cinema: json['cinema'] == null
      ? null
      : Cinema.fromJson(json['cinema'] as Map<String, dynamic>),
  totalSeats: (json['totalSeats'] as num).toInt(),
  seatLayout: json['seatLayout'] as Map<String, dynamic>,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  seats:
      (json['seats'] as List<dynamic>?)
          ?.map((e) => Seat.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cinemaId': instance.cinemaId,
      'cinema': instance.cinema,
      'totalSeats': instance.totalSeats,
      'seatLayout': instance.seatLayout,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'seats': instance.seats,
    };
