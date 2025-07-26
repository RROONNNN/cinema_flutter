// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cinema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Cinema _$CinemaFromJson(Map<String, dynamic> json) {
  return _Cinema.fromJson(json);
}

/// @nodoc
mixin _$Cinema {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<Room> get rooms => throw _privateConstructorUsedError;

  /// Serializes this Cinema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Cinema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CinemaCopyWith<Cinema> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CinemaCopyWith<$Res> {
  factory $CinemaCopyWith(Cinema value, $Res Function(Cinema) then) =
      _$CinemaCopyWithImpl<$Res, Cinema>;
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    String city,
    bool isActive,
    double? longitude,
    double? latitude,
    DateTime createdAt,
    DateTime updatedAt,
    List<Room> rooms,
  });
}

/// @nodoc
class _$CinemaCopyWithImpl<$Res, $Val extends Cinema>
    implements $CinemaCopyWith<$Res> {
  _$CinemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cinema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? isActive = null,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? rooms = null,
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
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            rooms: null == rooms
                ? _value.rooms
                : rooms // ignore: cast_nullable_to_non_nullable
                      as List<Room>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CinemaImplCopyWith<$Res> implements $CinemaCopyWith<$Res> {
  factory _$$CinemaImplCopyWith(
    _$CinemaImpl value,
    $Res Function(_$CinemaImpl) then,
  ) = __$$CinemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    String city,
    bool isActive,
    double? longitude,
    double? latitude,
    DateTime createdAt,
    DateTime updatedAt,
    List<Room> rooms,
  });
}

/// @nodoc
class __$$CinemaImplCopyWithImpl<$Res>
    extends _$CinemaCopyWithImpl<$Res, _$CinemaImpl>
    implements _$$CinemaImplCopyWith<$Res> {
  __$$CinemaImplCopyWithImpl(
    _$CinemaImpl _value,
    $Res Function(_$CinemaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Cinema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? isActive = null,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? rooms = null,
  }) {
    return _then(
      _$CinemaImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        rooms: null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<Room>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CinemaImpl implements _Cinema {
  const _$CinemaImpl({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    this.isActive = true,
    this.longitude,
    this.latitude,
    required this.createdAt,
    required this.updatedAt,
    final List<Room> rooms = const [],
  }) : _rooms = rooms;

  factory _$CinemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CinemaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String city;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final double? longitude;
  @override
  final double? latitude;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<Room> _rooms;
  @override
  @JsonKey()
  List<Room> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'Cinema(id: $id, name: $name, address: $address, city: $city, isActive: $isActive, longitude: $longitude, latitude: $latitude, createdAt: $createdAt, updatedAt: $updatedAt, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CinemaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    city,
    isActive,
    longitude,
    latitude,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_rooms),
  );

  /// Create a copy of Cinema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CinemaImplCopyWith<_$CinemaImpl> get copyWith =>
      __$$CinemaImplCopyWithImpl<_$CinemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CinemaImplToJson(this);
  }
}

abstract class _Cinema implements Cinema {
  const factory _Cinema({
    required final String id,
    required final String name,
    required final String address,
    required final String city,
    final bool isActive,
    final double? longitude,
    final double? latitude,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<Room> rooms,
  }) = _$CinemaImpl;

  factory _Cinema.fromJson(Map<String, dynamic> json) = _$CinemaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get city;
  @override
  bool get isActive;
  @override
  double? get longitude;
  @override
  double? get latitude;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<Room> get rooms;

  /// Create a copy of Cinema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CinemaImplCopyWith<_$CinemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
