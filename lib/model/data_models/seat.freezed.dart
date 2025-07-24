// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Seat _$SeatFromJson(Map<String, dynamic> json) {
  return _Seat.fromJson(json);
}

/// @nodoc
mixin _$Seat {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  Room? get room => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;
  String get seatType => throw _privateConstructorUsedError;
  double get extraPrice => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Seat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatCopyWith<Seat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatCopyWith<$Res> {
  factory $SeatCopyWith(Seat value, $Res Function(Seat) then) =
      _$SeatCopyWithImpl<$Res, Seat>;
  @useResult
  $Res call({
    String id,
    String roomId,
    Room? room,
    String seatNumber,
    String seatType,
    double extraPrice,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $RoomCopyWith<$Res>? get room;
}

/// @nodoc
class _$SeatCopyWithImpl<$Res, $Val extends Seat>
    implements $SeatCopyWith<$Res> {
  _$SeatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? room = freezed,
    Object? seatNumber = null,
    Object? seatType = null,
    Object? extraPrice = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            room: freezed == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                      as Room?,
            seatNumber: null == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            seatType: null == seatType
                ? _value.seatType
                : seatType // ignore: cast_nullable_to_non_nullable
                      as String,
            extraPrice: null == extraPrice
                ? _value.extraPrice
                : extraPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res>? get room {
    if (_value.room == null) {
      return null;
    }

    return $RoomCopyWith<$Res>(_value.room!, (value) {
      return _then(_value.copyWith(room: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeatImplCopyWith<$Res> implements $SeatCopyWith<$Res> {
  factory _$$SeatImplCopyWith(
    _$SeatImpl value,
    $Res Function(_$SeatImpl) then,
  ) = __$$SeatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String roomId,
    Room? room,
    String seatNumber,
    String seatType,
    double extraPrice,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $RoomCopyWith<$Res>? get room;
}

/// @nodoc
class __$$SeatImplCopyWithImpl<$Res>
    extends _$SeatCopyWithImpl<$Res, _$SeatImpl>
    implements _$$SeatImplCopyWith<$Res> {
  __$$SeatImplCopyWithImpl(_$SeatImpl _value, $Res Function(_$SeatImpl) _then)
    : super(_value, _then);

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? room = freezed,
    Object? seatNumber = null,
    Object? seatType = null,
    Object? extraPrice = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SeatImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        room: freezed == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as Room?,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        seatType: null == seatType
            ? _value.seatType
            : seatType // ignore: cast_nullable_to_non_nullable
                  as String,
        extraPrice: null == extraPrice
            ? _value.extraPrice
            : extraPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatImpl implements _Seat {
  const _$SeatImpl({
    required this.id,
    required this.roomId,
    this.room,
    required this.seatNumber,
    this.seatType = 'NORMAL',
    this.extraPrice = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$SeatImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final Room? room;
  @override
  final String seatNumber;
  @override
  @JsonKey()
  final String seatType;
  @override
  @JsonKey()
  final double extraPrice;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Seat(id: $id, roomId: $roomId, room: $room, seatNumber: $seatNumber, seatType: $seatType, extraPrice: $extraPrice, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.seatType, seatType) ||
                other.seatType == seatType) &&
            (identical(other.extraPrice, extraPrice) ||
                other.extraPrice == extraPrice) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    room,
    seatNumber,
    seatType,
    extraPrice,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatImplCopyWith<_$SeatImpl> get copyWith =>
      __$$SeatImplCopyWithImpl<_$SeatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatImplToJson(this);
  }
}

abstract class _Seat implements Seat {
  const factory _Seat({
    required final String id,
    required final String roomId,
    final Room? room,
    required final String seatNumber,
    final String seatType,
    final double extraPrice,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SeatImpl;

  factory _Seat.fromJson(Map<String, dynamic> json) = _$SeatImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  Room? get room;
  @override
  String get seatNumber;
  @override
  String get seatType;
  @override
  double get extraPrice;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Seat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatImplCopyWith<_$SeatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
