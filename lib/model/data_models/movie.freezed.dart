// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  DateTime get releaseDate => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get thumbnailPublicId => throw _privateConstructorUsedError;
  String get trailerUrl => throw _privateConstructorUsedError;
  String get trailerPublicId => throw _privateConstructorUsedError;
  List<Genres> get genres => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Movie to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    int duration,
    DateTime releaseDate,
    double rating,
    String thumbnail,
    String thumbnailPublicId,
    String trailerUrl,
    String trailerPublicId,
    List<Genres> genres,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? duration = null,
    Object? releaseDate = null,
    Object? rating = null,
    Object? thumbnail = null,
    Object? thumbnailPublicId = null,
    Object? trailerUrl = null,
    Object? trailerPublicId = null,
    Object? genres = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            releaseDate: null == releaseDate
                ? _value.releaseDate
                : releaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            thumbnail: null == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailPublicId: null == thumbnailPublicId
                ? _value.thumbnailPublicId
                : thumbnailPublicId // ignore: cast_nullable_to_non_nullable
                      as String,
            trailerUrl: null == trailerUrl
                ? _value.trailerUrl
                : trailerUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            trailerPublicId: null == trailerPublicId
                ? _value.trailerPublicId
                : trailerPublicId // ignore: cast_nullable_to_non_nullable
                      as String,
            genres: null == genres
                ? _value.genres
                : genres // ignore: cast_nullable_to_non_nullable
                      as List<Genres>,
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
abstract class _$$MovieImplCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$MovieImplCopyWith(
    _$MovieImpl value,
    $Res Function(_$MovieImpl) then,
  ) = __$$MovieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    int duration,
    DateTime releaseDate,
    double rating,
    String thumbnail,
    String thumbnailPublicId,
    String trailerUrl,
    String trailerPublicId,
    List<Genres> genres,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$MovieImplCopyWithImpl<$Res>
    extends _$MovieCopyWithImpl<$Res, _$MovieImpl>
    implements _$$MovieImplCopyWith<$Res> {
  __$$MovieImplCopyWithImpl(
    _$MovieImpl _value,
    $Res Function(_$MovieImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? duration = null,
    Object? releaseDate = null,
    Object? rating = null,
    Object? thumbnail = null,
    Object? thumbnailPublicId = null,
    Object? trailerUrl = null,
    Object? trailerPublicId = null,
    Object? genres = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$MovieImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        releaseDate: null == releaseDate
            ? _value.releaseDate
            : releaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        thumbnail: null == thumbnail
            ? _value.thumbnail
            : thumbnail // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailPublicId: null == thumbnailPublicId
            ? _value.thumbnailPublicId
            : thumbnailPublicId // ignore: cast_nullable_to_non_nullable
                  as String,
        trailerUrl: null == trailerUrl
            ? _value.trailerUrl
            : trailerUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        trailerPublicId: null == trailerPublicId
            ? _value.trailerPublicId
            : trailerPublicId // ignore: cast_nullable_to_non_nullable
                  as String,
        genres: null == genres
            ? _value._genres
            : genres // ignore: cast_nullable_to_non_nullable
                  as List<Genres>,
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
class _$MovieImpl implements _Movie {
  const _$MovieImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.releaseDate,
    this.rating = 0.0,
    required this.thumbnail,
    required this.thumbnailPublicId,
    required this.trailerUrl,
    required this.trailerPublicId,
    final List<Genres> genres = const [],
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  }) : _genres = genres;

  factory _$MovieImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int duration;
  @override
  final DateTime releaseDate;
  @override
  @JsonKey()
  final double rating;
  @override
  final String thumbnail;
  @override
  final String thumbnailPublicId;
  @override
  final String trailerUrl;
  @override
  final String trailerPublicId;
  final List<Genres> _genres;
  @override
  @JsonKey()
  List<Genres> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, description: $description, duration: $duration, releaseDate: $releaseDate, rating: $rating, thumbnail: $thumbnail, thumbnailPublicId: $thumbnailPublicId, trailerUrl: $trailerUrl, trailerPublicId: $trailerPublicId, genres: $genres, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.thumbnailPublicId, thumbnailPublicId) ||
                other.thumbnailPublicId == thumbnailPublicId) &&
            (identical(other.trailerUrl, trailerUrl) ||
                other.trailerUrl == trailerUrl) &&
            (identical(other.trailerPublicId, trailerPublicId) ||
                other.trailerPublicId == trailerPublicId) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
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
    title,
    description,
    duration,
    releaseDate,
    rating,
    thumbnail,
    thumbnailPublicId,
    trailerUrl,
    trailerPublicId,
    const DeepCollectionEquality().hash(_genres),
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      __$$MovieImplCopyWithImpl<_$MovieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieImplToJson(this);
  }
}

abstract class _Movie implements Movie {
  const factory _Movie({
    required final String id,
    required final String title,
    required final String description,
    required final int duration,
    required final DateTime releaseDate,
    final double rating,
    required final String thumbnail,
    required final String thumbnailPublicId,
    required final String trailerUrl,
    required final String trailerPublicId,
    final List<Genres> genres,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$MovieImpl;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$MovieImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get duration;
  @override
  DateTime get releaseDate;
  @override
  double get rating;
  @override
  String get thumbnail;
  @override
  String get thumbnailPublicId;
  @override
  String get trailerUrl;
  @override
  String get trailerPublicId;
  @override
  List<Genres> get genres;
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Movie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieImplCopyWith<_$MovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
