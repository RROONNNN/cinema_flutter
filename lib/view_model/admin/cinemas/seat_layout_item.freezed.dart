// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_layout_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SeatLayoutItem _$SeatLayoutItemFromJson(Map<String, dynamic> json) {
  return _SeatLayoutItem.fromJson(json);
}

/// @nodoc
mixin _$SeatLayoutItem {
  String get row => throw _privateConstructorUsedError;
  int get col => throw _privateConstructorUsedError;
  @SeatTypeConverter()
  SeatType get type => throw _privateConstructorUsedError;

  /// Serializes this SeatLayoutItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatLayoutItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatLayoutItemCopyWith<SeatLayoutItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatLayoutItemCopyWith<$Res> {
  factory $SeatLayoutItemCopyWith(
    SeatLayoutItem value,
    $Res Function(SeatLayoutItem) then,
  ) = _$SeatLayoutItemCopyWithImpl<$Res, SeatLayoutItem>;
  @useResult
  $Res call({String row, int col, @SeatTypeConverter() SeatType type});
}

/// @nodoc
class _$SeatLayoutItemCopyWithImpl<$Res, $Val extends SeatLayoutItem>
    implements $SeatLayoutItemCopyWith<$Res> {
  _$SeatLayoutItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatLayoutItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? row = null, Object? col = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            row: null == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as String,
            col: null == col
                ? _value.col
                : col // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SeatType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatLayoutItemImplCopyWith<$Res>
    implements $SeatLayoutItemCopyWith<$Res> {
  factory _$$SeatLayoutItemImplCopyWith(
    _$SeatLayoutItemImpl value,
    $Res Function(_$SeatLayoutItemImpl) then,
  ) = __$$SeatLayoutItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String row, int col, @SeatTypeConverter() SeatType type});
}

/// @nodoc
class __$$SeatLayoutItemImplCopyWithImpl<$Res>
    extends _$SeatLayoutItemCopyWithImpl<$Res, _$SeatLayoutItemImpl>
    implements _$$SeatLayoutItemImplCopyWith<$Res> {
  __$$SeatLayoutItemImplCopyWithImpl(
    _$SeatLayoutItemImpl _value,
    $Res Function(_$SeatLayoutItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatLayoutItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? row = null, Object? col = null, Object? type = null}) {
    return _then(
      _$SeatLayoutItemImpl(
        row: null == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as String,
        col: null == col
            ? _value.col
            : col // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SeatType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatLayoutItemImpl implements _SeatLayoutItem {
  const _$SeatLayoutItemImpl({
    required this.row,
    required this.col,
    @SeatTypeConverter() required this.type,
  });

  factory _$SeatLayoutItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatLayoutItemImplFromJson(json);

  @override
  final String row;
  @override
  final int col;
  @override
  @SeatTypeConverter()
  final SeatType type;

  @override
  String toString() {
    return 'SeatLayoutItem(row: $row, col: $col, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatLayoutItemImpl &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.col, col) || other.col == col) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, row, col, type);

  /// Create a copy of SeatLayoutItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatLayoutItemImplCopyWith<_$SeatLayoutItemImpl> get copyWith =>
      __$$SeatLayoutItemImplCopyWithImpl<_$SeatLayoutItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatLayoutItemImplToJson(this);
  }
}

abstract class _SeatLayoutItem implements SeatLayoutItem {
  const factory _SeatLayoutItem({
    required final String row,
    required final int col,
    @SeatTypeConverter() required final SeatType type,
  }) = _$SeatLayoutItemImpl;

  factory _SeatLayoutItem.fromJson(Map<String, dynamic> json) =
      _$SeatLayoutItemImpl.fromJson;

  @override
  String get row;
  @override
  int get col;
  @override
  @SeatTypeConverter()
  SeatType get type;

  /// Create a copy of SeatLayoutItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatLayoutItemImplCopyWith<_$SeatLayoutItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
