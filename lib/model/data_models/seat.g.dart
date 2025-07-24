// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatImpl _$$SeatImplFromJson(Map<String, dynamic> json) => _$SeatImpl(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  room: json['room'] == null
      ? null
      : Room.fromJson(json['room'] as Map<String, dynamic>),
  seatNumber: json['seatNumber'] as String,
  seatType: json['seatType'] as String? ?? 'NORMAL',
  extraPrice: (json['extraPrice'] as num?)?.toDouble() ?? 0.0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$SeatImplToJson(_$SeatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'room': instance.room,
      'seatNumber': instance.seatNumber,
      'seatType': instance.seatType,
      'extraPrice': instance.extraPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
