import 'package:cinema_flutter/shared/enums/seat_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_layout_item.freezed.dart';
part 'seat_layout_item.g.dart';

class SeatTypeConverter implements JsonConverter<SeatType, String> {
  const SeatTypeConverter();

  @override
  SeatType fromJson(String json) => SeatTypeExtension.fromString(json);

  @override
  String toJson(SeatType object) => object.name;
}

@freezed
class SeatLayoutItem with _$SeatLayoutItem {
  const factory SeatLayoutItem({
    required String row,
    required int col,
    @SeatTypeConverter() required SeatType type,
  }) = _SeatLayoutItem;

  factory SeatLayoutItem.fromJson(Map<String, dynamic> json) =>
      _$SeatLayoutItemFromJson(json);
}
