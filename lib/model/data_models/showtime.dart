import 'package:freezed_annotation/freezed_annotation.dart';

part 'showtime.freezed.dart';
part 'showtime.g.dart';

@freezed
class Showtime with _$Showtime {
  const factory Showtime({
    required String id,
    required String movieId,
    required String roomId,
    required String cinemaId,
    required DateTime startTime,
    required DateTime endTime,
    required int price,
    @Default('vi') String language,
    @Default(true) bool subtitle,
    @Default('2D') String format,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Showtime;

  factory Showtime.fromJson(Map<String, dynamic> json) =>
      _$ShowtimeFromJson(json);
}
