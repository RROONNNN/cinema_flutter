// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_layout_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatLayoutItemImpl _$$SeatLayoutItemImplFromJson(Map<String, dynamic> json) =>
    _$SeatLayoutItemImpl(
      row: json['row'] as String,
      col: (json['col'] as num).toInt(),
      type: const SeatTypeConverter().fromJson(json['type'] as String),
    );

Map<String, dynamic> _$$SeatLayoutItemImplToJson(
  _$SeatLayoutItemImpl instance,
) => <String, dynamic>{
  'row': instance.row,
  'col': instance.col,
  'type': const SeatTypeConverter().toJson(instance.type),
};
