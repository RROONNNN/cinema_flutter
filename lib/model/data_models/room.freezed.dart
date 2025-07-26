// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get cinemaId => throw _privateConstructorUsedError;
  Cinema? get cinema => throw _privateConstructorUsedError;
  int get totalSeats => throw _privateConstructorUsedError;
  List<SeatLayoutItem> get seatLayout => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<Seat> get seats => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String id,
    String name,
    String cinemaId,
    Cinema? cinema,
    int totalSeats,
    List<SeatLayoutItem> seatLayout,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
    List<Seat> seats,
  });

  $CinemaCopyWith<$Res>? get cinema;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cinemaId = null,
    Object? cinema = freezed,
    Object? totalSeats = null,
    Object? seatLayout = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? seats = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            cinemaId: null == cinemaId
                ? _value.cinemaId
                : cinemaId // ignore: cast_nullable_to_non_nullable
                      as String,
            cinema: freezed == cinema
                ? _value.cinema
                : cinema // ignore: cast_nullable_to_non_nullable
                      as Cinema?,
            totalSeats: null == totalSeats
                ? _value.totalSeats
                : totalSeats // ignore: cast_nullable_to_non_nullable
                      as int,
            seatLayout: null == seatLayout
                ? _value.seatLayout
                : seatLayout // ignore: cast_nullable_to_non_nullable
                      as List<SeatLayoutItem>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            seats: null == seats
                ? _value.seats
                : seats // ignore: cast_nullable_to_non_nullable
                      as List<Seat>,
          )
          as $Val,
    );
  }

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CinemaCopyWith<$Res>? get cinema {
    if (_value.cinema == null) {
      return null;
    }

    return $CinemaCopyWith<$Res>(_value.cinema!, (value) {
      return _then(_value.copyWith(cinema: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String cinemaId,
    Cinema? cinema,
    int totalSeats,
    List<SeatLayoutItem> seatLayout,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
    List<Seat> seats,
  });

  @override
  $CinemaCopyWith<$Res>? get cinema;
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cinemaId = null,
    Object? cinema = freezed,
    Object? totalSeats = null,
    Object? seatLayout = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? seats = null,
  }) {
    return _then(
      _$RoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        cinemaId: null == cinemaId
            ? _value.cinemaId
            : cinemaId // ignore: cast_nullable_to_non_nullable
                  as String,
        cinema: freezed == cinema
            ? _value.cinema
            : cinema // ignore: cast_nullable_to_non_nullable
                  as Cinema?,
        totalSeats: null == totalSeats
            ? _value.totalSeats
            : totalSeats // ignore: cast_nullable_to_non_nullable
                  as int,
        seatLayout: null == seatLayout
            ? _value._seatLayout
            : seatLayout // ignore: cast_nullable_to_non_nullable
                  as List<SeatLayoutItem>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        seats: null == seats
            ? _value._seats
            : seats // ignore: cast_nullable_to_non_nullable
                  as List<Seat>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.name,
    required this.cinemaId,
    this.cinema,
    required this.totalSeats,
    required final List<SeatLayoutItem> seatLayout,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    final List<Seat> seats = const [],
  }) : _seatLayout = seatLayout,
       _seats = seats;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String cinemaId;
  @override
  final Cinema? cinema;
  @override
  final int totalSeats;
  final List<SeatLayoutItem> _seatLayout;
  @override
  List<SeatLayoutItem> get seatLayout {
    if (_seatLayout is EqualUnmodifiableListView) return _seatLayout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seatLayout);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<Seat> _seats;
  @override
  @JsonKey()
  List<Seat> get seats {
    if (_seats is EqualUnmodifiableListView) return _seats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seats);
  }

  @override
  String toString() {
    return 'Room(id: $id, name: $name, cinemaId: $cinemaId, cinema: $cinema, totalSeats: $totalSeats, seatLayout: $seatLayout, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, seats: $seats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cinemaId, cinemaId) ||
                other.cinemaId == cinemaId) &&
            (identical(other.cinema, cinema) || other.cinema == cinema) &&
            (identical(other.totalSeats, totalSeats) ||
                other.totalSeats == totalSeats) &&
            const DeepCollectionEquality().equals(
              other._seatLayout,
              _seatLayout,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._seats, _seats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    cinemaId,
    cinema,
    totalSeats,
    const DeepCollectionEquality().hash(_seatLayout),
    isActive,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_seats),
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final String id,
    required final String name,
    required final String cinemaId,
    final Cinema? cinema,
    required final int totalSeats,
    required final List<SeatLayoutItem> seatLayout,
    final bool isActive,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<Seat> seats,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get cinemaId;
  @override
  Cinema? get cinema;
  @override
  int get totalSeats;
  @override
  List<SeatLayoutItem> get seatLayout;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<Seat> get seats;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
