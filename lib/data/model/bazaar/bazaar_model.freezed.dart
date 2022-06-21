// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bazaar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bazaar _$BazaarFromJson(Map<String, dynamic> json) {
  return _Bazaar.fromJson(json);
}

/// @nodoc
mixin _$Bazaar {
  String? get id => throw _privateConstructorUsedError;
  String? get organizer => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get salesStart => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get salesEnd => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get eventFrom => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get eventTo => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get pictureName => throw _privateConstructorUsedError;
  String? get pictureURL => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BazaarCopyWith<Bazaar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BazaarCopyWith<$Res> {
  factory $BazaarCopyWith(Bazaar value, $Res Function(Bazaar) then) =
      _$BazaarCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? organizer,
      String? name,
      String? message,
      @timestampkey DateTime? salesStart,
      @timestampkey DateTime? salesEnd,
      @timestampkey DateTime? eventFrom,
      @timestampkey DateTime? eventTo,
      String? place,
      String? pictureName,
      String? pictureURL,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt,
      String? eventId});
}

/// @nodoc
class _$BazaarCopyWithImpl<$Res> implements $BazaarCopyWith<$Res> {
  _$BazaarCopyWithImpl(this._value, this._then);

  final Bazaar _value;
  // ignore: unused_field
  final $Res Function(Bazaar) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? organizer = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? eventFrom = freezed,
    Object? eventTo = freezed,
    Object? place = freezed,
    Object? pictureName = freezed,
    Object? pictureURL = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizer: organizer == freezed
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      salesStart: salesStart == freezed
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: salesEnd == freezed
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventFrom: eventFrom == freezed
          ? _value.eventFrom
          : eventFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventTo: eventTo == freezed
          ? _value.eventTo
          : eventTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      place: place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureName: pictureName == freezed
          ? _value.pictureName
          : pictureName // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureURL: pictureURL == freezed
          ? _value.pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventId: eventId == freezed
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_BazaarCopyWith<$Res> implements $BazaarCopyWith<$Res> {
  factory _$$_BazaarCopyWith(_$_Bazaar value, $Res Function(_$_Bazaar) then) =
      __$$_BazaarCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? organizer,
      String? name,
      String? message,
      @timestampkey DateTime? salesStart,
      @timestampkey DateTime? salesEnd,
      @timestampkey DateTime? eventFrom,
      @timestampkey DateTime? eventTo,
      String? place,
      String? pictureName,
      String? pictureURL,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt,
      String? eventId});
}

/// @nodoc
class __$$_BazaarCopyWithImpl<$Res> extends _$BazaarCopyWithImpl<$Res>
    implements _$$_BazaarCopyWith<$Res> {
  __$$_BazaarCopyWithImpl(_$_Bazaar _value, $Res Function(_$_Bazaar) _then)
      : super(_value, (v) => _then(v as _$_Bazaar));

  @override
  _$_Bazaar get _value => super._value as _$_Bazaar;

  @override
  $Res call({
    Object? id = freezed,
    Object? organizer = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? eventFrom = freezed,
    Object? eventTo = freezed,
    Object? place = freezed,
    Object? pictureName = freezed,
    Object? pictureURL = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_$_Bazaar(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizer: organizer == freezed
          ? _value.organizer
          : organizer // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      salesStart: salesStart == freezed
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: salesEnd == freezed
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventFrom: eventFrom == freezed
          ? _value.eventFrom
          : eventFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventTo: eventTo == freezed
          ? _value.eventTo
          : eventTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      place: place == freezed
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureName: pictureName == freezed
          ? _value.pictureName
          : pictureName // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureURL: pictureURL == freezed
          ? _value.pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: deletedAt == freezed
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventId: eventId == freezed
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bazaar extends _Bazaar {
  const _$_Bazaar(
      {this.id,
      required this.organizer,
      required this.name,
      required this.message,
      @timestampkey required this.salesStart,
      @timestampkey required this.salesEnd,
      @timestampkey required this.eventFrom,
      @timestampkey required this.eventTo,
      required this.place,
      this.pictureName,
      this.pictureURL,
      @timestampkey this.createdAt,
      @timestampkey this.updatedAt,
      @timestampkey this.deletedAt,
      this.eventId})
      : super._();

  factory _$_Bazaar.fromJson(Map<String, dynamic> json) =>
      _$$_BazaarFromJson(json);

  @override
  final String? id;
  @override
  final String? organizer;
  @override
  final String? name;
  @override
  final String? message;
  @override
  @timestampkey
  final DateTime? salesStart;
  @override
  @timestampkey
  final DateTime? salesEnd;
  @override
  @timestampkey
  final DateTime? eventFrom;
  @override
  @timestampkey
  final DateTime? eventTo;
  @override
  final String? place;
  @override
  final String? pictureName;
  @override
  final String? pictureURL;
  @override
  @timestampkey
  final DateTime? createdAt;
  @override
  @timestampkey
  final DateTime? updatedAt;
  @override
  @timestampkey
  final DateTime? deletedAt;
  @override
  final String? eventId;

  @override
  String toString() {
    return 'Bazaar(id: $id, organizer: $organizer, name: $name, message: $message, salesStart: $salesStart, salesEnd: $salesEnd, eventFrom: $eventFrom, eventTo: $eventTo, place: $place, pictureName: $pictureName, pictureURL: $pictureURL, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, eventId: $eventId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bazaar &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.organizer, organizer) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.salesStart, salesStart) &&
            const DeepCollectionEquality().equals(other.salesEnd, salesEnd) &&
            const DeepCollectionEquality().equals(other.eventFrom, eventFrom) &&
            const DeepCollectionEquality().equals(other.eventTo, eventTo) &&
            const DeepCollectionEquality().equals(other.place, place) &&
            const DeepCollectionEquality()
                .equals(other.pictureName, pictureName) &&
            const DeepCollectionEquality()
                .equals(other.pictureURL, pictureURL) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            const DeepCollectionEquality().equals(other.eventId, eventId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(organizer),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(salesStart),
      const DeepCollectionEquality().hash(salesEnd),
      const DeepCollectionEquality().hash(eventFrom),
      const DeepCollectionEquality().hash(eventTo),
      const DeepCollectionEquality().hash(place),
      const DeepCollectionEquality().hash(pictureName),
      const DeepCollectionEquality().hash(pictureURL),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(deletedAt),
      const DeepCollectionEquality().hash(eventId));

  @JsonKey(ignore: true)
  @override
  _$$_BazaarCopyWith<_$_Bazaar> get copyWith =>
      __$$_BazaarCopyWithImpl<_$_Bazaar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BazaarToJson(this);
  }
}

abstract class _Bazaar extends Bazaar {
  const factory _Bazaar(
      {final String? id,
      required final String? organizer,
      required final String? name,
      required final String? message,
      @timestampkey required final DateTime? salesStart,
      @timestampkey required final DateTime? salesEnd,
      @timestampkey required final DateTime? eventFrom,
      @timestampkey required final DateTime? eventTo,
      required final String? place,
      final String? pictureName,
      final String? pictureURL,
      @timestampkey final DateTime? createdAt,
      @timestampkey final DateTime? updatedAt,
      @timestampkey final DateTime? deletedAt,
      final String? eventId}) = _$_Bazaar;
  const _Bazaar._() : super._();

  factory _Bazaar.fromJson(Map<String, dynamic> json) = _$_Bazaar.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get organizer => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get message => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get salesStart => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get salesEnd => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get eventFrom => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get eventTo => throw _privateConstructorUsedError;
  @override
  String? get place => throw _privateConstructorUsedError;
  @override
  String? get pictureName => throw _privateConstructorUsedError;
  @override
  String? get pictureURL => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @timestampkey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @override
  String? get eventId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BazaarCopyWith<_$_Bazaar> get copyWith =>
      throw _privateConstructorUsedError;
}
