// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showtime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShowtimeImpl _$$ShowtimeImplFromJson(Map<String, dynamic> json) =>
    _$ShowtimeImpl(
      id: json['id'] as String,
      movieId: json['movieId'] as String,
      roomId: json['roomId'] as String,
      cinemaId: json['cinemaId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      price: (json['price'] as num).toInt(),
      language: json['language'] as String? ?? 'vi',
      subtitle: json['subtitle'] as bool? ?? true,
      format: json['format'] as String? ?? '2D',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ShowtimeImplToJson(_$ShowtimeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'roomId': instance.roomId,
      'cinemaId': instance.cinemaId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'price': instance.price,
      'language': instance.language,
      'subtitle': instance.subtitle,
      'format': instance.format,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
