// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Cart.fromJson(json);
}

/// @nodoc
mixin _$Cart {
  String? get id => throw _privateConstructorUsedError;
  String? get userRef => throw _privateConstructorUsedError;
  String? get eventRef => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampkey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? userRef,
      String? eventRef,
      String? eventName,
      bool? isActive,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt});
}

/// @nodoc
class _$CartCopyWithImpl<$Res> implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  final Cart _value;
  // ignore: unused_field
  final $Res Function(Cart) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userRef = freezed,
    Object? eventRef = freezed,
    Object? eventName = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userRef: userRef == freezed
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as String?,
      eventRef: eventRef == freezed
          ? _value.eventRef
          : eventRef // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: eventName == freezed
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
abstract class _$$_CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$_CartCopyWith(_$_Cart value, $Res Function(_$_Cart) then) =
      __$$_CartCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? userRef,
      String? eventRef,
      String? eventName,
      bool? isActive,
      @timestampkey DateTime? createdAt,
      @timestampkey DateTime? updatedAt,
      @timestampkey DateTime? deletedAt});
}

/// @nodoc
class __$$_CartCopyWithImpl<$Res> extends _$CartCopyWithImpl<$Res>
    implements _$$_CartCopyWith<$Res> {
  __$$_CartCopyWithImpl(_$_Cart _value, $Res Function(_$_Cart) _then)
      : super(_value, (v) => _then(v as _$_Cart));

  @override
  _$_Cart get _value => super._value as _$_Cart;

  @override
  $Res call({
    Object? id = freezed,
    Object? userRef = freezed,
    Object? eventRef = freezed,
    Object? eventName = freezed,
    Object? isActive = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_Cart(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userRef: userRef == freezed
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as String?,
      eventRef: eventRef == freezed
          ? _value.eventRef
          : eventRef // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: eventName == freezed
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cart extends _Cart {
  const _$_Cart(
      {this.id,
      this.userRef,
      this.eventRef,
      this.eventName,
      required this.isActive,
      @timestampkey this.createdAt,
      @timestampkey this.updatedAt,
      @timestampkey this.deletedAt})
      : super._();

  factory _$_Cart.fromJson(Map<String, dynamic> json) => _$$_CartFromJson(json);

  @override
  final String? id;
  @override
  final String? userRef;
  @override
  final String? eventRef;
  @override
  final String? eventName;
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
  String toString() {
    return 'Cart(id: $id, userRef: $userRef, eventRef: $eventRef, eventName: $eventName, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Cart &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userRef, userRef) &&
            const DeepCollectionEquality().equals(other.eventRef, eventRef) &&
            const DeepCollectionEquality().equals(other.eventName, eventName) &&
            const DeepCollectionEquality().equals(other.isActive, isActive) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userRef),
      const DeepCollectionEquality().hash(eventRef),
      const DeepCollectionEquality().hash(eventName),
      const DeepCollectionEquality().hash(isActive),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(deletedAt));

  @JsonKey(ignore: true)
  @override
  _$$_CartCopyWith<_$_Cart> get copyWith =>
      __$$_CartCopyWithImpl<_$_Cart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CartToJson(this);
  }
}

abstract class _Cart extends Cart {
  const factory _Cart(
      {final String? id,
      final String? userRef,
      final String? eventRef,
      final String? eventName,
      required final bool? isActive,
      @timestampkey final DateTime? createdAt,
      @timestampkey final DateTime? updatedAt,
      @timestampkey final DateTime? deletedAt}) = _$_Cart;
  const _Cart._() : super._();

  factory _Cart.fromJson(Map<String, dynamic> json) = _$_Cart.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get userRef => throw _privateConstructorUsedError;
  @override
  String? get eventRef => throw _privateConstructorUsedError;
  @override
  String? get eventName => throw _privateConstructorUsedError;
  @override
  bool? get isActive => throw _privateConstructorUsedError;
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
  @JsonKey(ignore: true)
  _$$_CartCopyWith<_$_Cart> get copyWith => throw _privateConstructorUsedError;
}
