// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenresImpl _$$GenresImplFromJson(Map<String, dynamic> json) => _$GenresImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$GenresImplToJson(_$GenresImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
