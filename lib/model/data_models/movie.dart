import 'package:freezed_annotation/freezed_annotation.dart';
import 'genres.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String id,
    required String title,
    required String description,
    required int duration,
    required DateTime releaseDate,
    @Default(0.0) double rating,
    required String thumbnail,
    required String thumbnailPublicId,
    required String trailerUrl,
    required String trailerPublicId,
    @Default([]) List<Genres> genres,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
