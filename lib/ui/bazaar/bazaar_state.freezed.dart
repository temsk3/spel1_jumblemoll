// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bazaar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BazaarState {
  List<Bazaar> get bazaarList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BazaarStateCopyWith<BazaarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BazaarStateCopyWith<$Res> {
  factory $BazaarStateCopyWith(
          BazaarState value, $Res Function(BazaarState) then) =
      _$BazaarStateCopyWithImpl<$Res>;
  $Res call({List<Bazaar> bazaarList});
}

/// @nodoc
class _$BazaarStateCopyWithImpl<$Res> implements $BazaarStateCopyWith<$Res> {
  _$BazaarStateCopyWithImpl(this._value, this._then);

  final BazaarState _value;
  // ignore: unused_field
  final $Res Function(BazaarState) _then;

  @override
  $Res call({
    Object? bazaarList = freezed,
  }) {
    return _then(_value.copyWith(
      bazaarList: bazaarList == freezed
          ? _value.bazaarList
          : bazaarList // ignore: cast_nullable_to_non_nullable
              as List<Bazaar>,
    ));
  }
}

/// @nodoc
abstract class _$$_BazaarStateCopyWith<$Res>
    implements $BazaarStateCopyWith<$Res> {
  factory _$$_BazaarStateCopyWith(
          _$_BazaarState value, $Res Function(_$_BazaarState) then) =
      __$$_BazaarStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Bazaar> bazaarList});
}

/// @nodoc
class __$$_BazaarStateCopyWithImpl<$Res> extends _$BazaarStateCopyWithImpl<$Res>
    implements _$$_BazaarStateCopyWith<$Res> {
  __$$_BazaarStateCopyWithImpl(
      _$_BazaarState _value, $Res Function(_$_BazaarState) _then)
      : super(_value, (v) => _then(v as _$_BazaarState));

  @override
  _$_BazaarState get _value => super._value as _$_BazaarState;

  @override
  $Res call({
    Object? bazaarList = freezed,
  }) {
    return _then(_$_BazaarState(
      bazaarList: bazaarList == freezed
          ? _value._bazaarList
          : bazaarList // ignore: cast_nullable_to_non_nullable
              as List<Bazaar>,
    ));
  }
}

/// @nodoc

class _$_BazaarState implements _BazaarState {
  const _$_BazaarState({final List<Bazaar> bazaarList = const <Bazaar>[]})
      : _bazaarList = bazaarList;

  final List<Bazaar> _bazaarList;
  @override
  @JsonKey()
  List<Bazaar> get bazaarList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bazaarList);
  }

  @override
  String toString() {
    return 'BazaarState(bazaarList: $bazaarList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BazaarState &&
            const DeepCollectionEquality()
                .equals(other._bazaarList, _bazaarList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bazaarList));

  @JsonKey(ignore: true)
  @override
  _$$_BazaarStateCopyWith<_$_BazaarState> get copyWith =>
      __$$_BazaarStateCopyWithImpl<_$_BazaarState>(this, _$identity);
}

abstract class _BazaarState implements BazaarState {
  const factory _BazaarState({final List<Bazaar> bazaarList}) = _$_BazaarState;

  @override
  List<Bazaar> get bazaarList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BazaarStateCopyWith<_$_BazaarState> get copyWith =>
      throw _privateConstructorUsedError;
}
