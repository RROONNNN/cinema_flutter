// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'showtime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Showtime _$ShowtimeFromJson(Map<String, dynamic> json) {
  return _Showtime.fromJson(json);
}

/// @nodoc
mixin _$Showtime {
  String get id => throw _privateConstructorUsedError;
  String get movieId => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get cinemaId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  bool get subtitle => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Showtime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Showtime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShowtimeCopyWith<Showtime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowtimeCopyWith<$Res> {
  factory $ShowtimeCopyWith(Showtime value, $Res Function(Showtime) then) =
      _$ShowtimeCopyWithImpl<$Res, Showtime>;
  @useResult
  $Res call({
    String id,
    String movieId,
    String roomId,
    String cinemaId,
    DateTime startTime,
    DateTime endTime,
    int price,
    String language,
    bool subtitle,
    String format,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ShowtimeCopyWithImpl<$Res, $Val extends Showtime>
    implements $ShowtimeCopyWith<$Res> {
  _$ShowtimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Showtime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? movieId = null,
    Object? roomId = null,
    Object? cinemaId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? price = null,
    Object? language = null,
    Object? subtitle = null,
    Object? format = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            movieId: null == movieId
                ? _value.movieId
                : movieId // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            cinemaId: null == cinemaId
                ? _value.cinemaId
                : cinemaId // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as bool,
            format: null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShowtimeImplCopyWith<$Res>
    implements $ShowtimeCopyWith<$Res> {
  factory _$$ShowtimeImplCopyWith(
    _$ShowtimeImpl value,
    $Res Function(_$ShowtimeImpl) then,
  ) = __$$ShowtimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String movieId,
    String roomId,
    String cinemaId,
    DateTime startTime,
    DateTime endTime,
    int price,
    String language,
    bool subtitle,
    String format,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ShowtimeImplCopyWithImpl<$Res>
    extends _$ShowtimeCopyWithImpl<$Res, _$ShowtimeImpl>
    implements _$$ShowtimeImplCopyWith<$Res> {
  __$$ShowtimeImplCopyWithImpl(
    _$ShowtimeImpl _value,
    $Res Function(_$ShowtimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Showtime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? movieId = null,
    Object? roomId = null,
    Object? cinemaId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? price = null,
    Object? language = null,
    Object? subtitle = null,
    Object? format = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ShowtimeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        movieId: null == movieId
            ? _value.movieId
            : movieId // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        cinemaId: null == cinemaId
            ? _value.cinemaId
            : cinemaId // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as bool,
        format: null == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShowtimeImpl implements _Showtime {
  const _$ShowtimeImpl({
    required this.id,
    required this.movieId,
    required this.roomId,
    required this.cinemaId,
    required this.startTime,
    required this.endTime,
    required this.price,
    this.language = 'vi',
    this.subtitle = true,
    this.format = '2D',
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory _$ShowtimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShowtimeImplFromJson(json);

  @override
  final String id;
  @override
  final String movieId;
  @override
  final String roomId;
  @override
  final String cinemaId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int price;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final bool subtitle;
  @override
  @JsonKey()
  final String format;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Showtime(id: $id, movieId: $movieId, roomId: $roomId, cinemaId: $cinemaId, startTime: $startTime, endTime: $endTime, price: $price, language: $language, subtitle: $subtitle, format: $format, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowtimeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.cinemaId, cinemaId) ||
                other.cinemaId == cinemaId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
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
    movieId,
    roomId,
    cinemaId,
    startTime,
    endTime,
    price,
    language,
    subtitle,
    format,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Showtime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowtimeImplCopyWith<_$ShowtimeImpl> get copyWith =>
      __$$ShowtimeImplCopyWithImpl<_$ShowtimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShowtimeImplToJson(this);
  }
}

abstract class _Showtime implements Showtime {
  const factory _Showtime({
    required final String id,
    required final String movieId,
    required final String roomId,
    required final String cinemaId,
    required final DateTime startTime,
    required final DateTime endTime,
    required final int price,
    final String language,
    final bool subtitle,
    final String format,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ShowtimeImpl;

  factory _Showtime.fromJson(Map<String, dynamic> json) =
      _$ShowtimeImpl.fromJson;

  @override
  String get id;
  @override
  String get movieId;
  @override
  String get roomId;
  @override
  String get cinemaId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get price;
  @override
  String get language;
  @override
  bool get subtitle;
  @override
  String get format;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Showtime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShowtimeImplCopyWith<_$ShowtimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
