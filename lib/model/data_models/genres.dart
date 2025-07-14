import 'package:freezed_annotation/freezed_annotation.dart';

part 'genres.freezed.dart';
part 'genres.g.dart';

@freezed
class Genres with _$Genres {
  const factory Genres({
    required String id,
    required String name,
    required String description,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Genres;

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
}
