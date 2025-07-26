// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CinemaImpl _$$CinemaImplFromJson(Map<String, dynamic> json) => _$CinemaImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  isActive: json['isActive'] as bool? ?? true,
  longitude: (json['longitude'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  rooms:
      (json['rooms'] as List<dynamic>?)
          ?.map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CinemaImplToJson(_$CinemaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'isActive': instance.isActive,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rooms': instance.rooms,
    };
