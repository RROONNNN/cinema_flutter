// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  duration: (json['duration'] as num).toInt(),
  releaseDate: DateTime.parse(json['releaseDate'] as String),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  thumbnail: json['thumbnail'] as String,
  thumbnailPublicId: json['thumbnailPublicId'] as String,
  trailerUrl: json['trailerUrl'] as String,
  trailerPublicId: json['trailerPublicId'] as String,
  genres:
      (json['genres'] as List<dynamic>?)
          ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isActive: json['isActive'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
      'thumbnailPublicId': instance.thumbnailPublicId,
      'trailerUrl': instance.trailerUrl,
      'trailerPublicId': instance.trailerPublicId,
      'genres': instance.genres,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
