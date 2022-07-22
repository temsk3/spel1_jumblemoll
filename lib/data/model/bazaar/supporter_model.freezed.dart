// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'supporter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Supporter _$SupporterFromJson(Map<String, dynamic> json) {
  return _Supporter.fromJson(json);
}

/// @nodoc
mixin _$Supporter {
  String? get uid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupporterCopyWith<Supporter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupporterCopyWith<$Res> {
  factory $SupporterCopyWith(Supporter value, $Res Function(Supporter) then) =
      _$SupporterCopyWithImpl<$Res>;
  $Res call(
      {String? uid,
      String? name,
      bool? isActive,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt,
      String? eventId});
}

/// @nodoc
class _$SupporterCopyWithImpl<$Res> implements $SupporterCopyWith<$Res> {
  _$SupporterCopyWithImpl(this._value, this._then);

  final Supporter _value;
  // ignore: unused_field
  final $Res Function(Supporter) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
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
abstract class _$$_SupporterCopyWith<$Res> implements $SupporterCopyWith<$Res> {
  factory _$$_SupporterCopyWith(
          _$_Supporter value, $Res Function(_$_Supporter) then) =
      __$$_SupporterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? uid,
      String? name,
      bool? isActive,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt,
      String? eventId});
}

/// @nodoc
class __$$_SupporterCopyWithImpl<$Res> extends _$SupporterCopyWithImpl<$Res>
    implements _$$_SupporterCopyWith<$Res> {
  __$$_SupporterCopyWithImpl(
      _$_Supporter _value, $Res Function(_$_Supporter) _then)
      : super(_value, (v) => _then(v as _$_Supporter));

  @override
  _$_Supporter get _value => super._value as _$_Supporter;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? eventId = freezed,
  }) {
    return _then(_$_Supporter(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$_Supporter extends _Supporter {
  const _$_Supporter(
      {this.uid,
      required this.name,
      required this.isActive,
      @timestampkey this.createdAt,
      @timestampkey this.updatedAt,
      @timestampkey this.deletedAt,
      this.eventId})
      : super._();

  factory _$_Supporter.fromJson(Map<String, dynamic> json) =>
      _$$_SupporterFromJson(json);

  @override
  final String? uid;
  @override
  final String? name;
  @override
  final bool? isActive;
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
    return 'Supporter(uid: $uid, name: $name, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, eventId: $eventId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Supporter &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.isActive, isActive) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            const DeepCollectionEquality().equals(other.eventId, eventId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isActive),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(deletedAt),
      const DeepCollectionEquality().hash(eventId));

  @JsonKey(ignore: true)
  @override
  _$$_SupporterCopyWith<_$_Supporter> get copyWith =>
      __$$_SupporterCopyWithImpl<_$_Supporter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupporterToJson(
      this,
    );
  }
}

abstract class _Supporter extends Supporter {
  const factory _Supporter(
      {final String? uid,
      required final String? name,
      required final bool? isActive,
      @timestampkey final DateTime? createdAt,
      @timestampkey final DateTime? updatedAt,
      @timestampkey final DateTime? deletedAt,
      final String? eventId}) = _$_Supporter;
  const _Supporter._() : super._();

  factory _Supporter.fromJson(Map<String, dynamic> json) =
      _$_Supporter.fromJson;

  @override
  String? get uid;
  @override
  String? get name;
  @override
  bool? get isActive;
  @override
  @timestampkey
  DateTime? get createdAt;
  @override
  @timestampkey
  DateTime? get updatedAt;
  @override
  @timestampkey
  DateTime? get deletedAt;
  @override
  String? get eventId;
  @override
  @JsonKey(ignore: true)
  _$$_SupporterCopyWith<_$_Supporter> get copyWith =>
      throw _privateConstructorUsedError;
}
