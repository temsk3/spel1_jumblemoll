// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_crop_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageCropState {
// Image? cropImage,
  Uint8List? get imageFile => throw _privateConstructorUsedError;
  bool? get isProcessing => throw _privateConstructorUsedError;
  Uint8List? get croppedData => throw _privateConstructorUsedError;
  Uint8List? get uint8list => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageCropStateCopyWith<ImageCropState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCropStateCopyWith<$Res> {
  factory $ImageCropStateCopyWith(
          ImageCropState value, $Res Function(ImageCropState) then) =
      _$ImageCropStateCopyWithImpl<$Res>;
  $Res call(
      {Uint8List? imageFile,
      bool? isProcessing,
      Uint8List? croppedData,
      Uint8List? uint8list});
}

/// @nodoc
class _$ImageCropStateCopyWithImpl<$Res>
    implements $ImageCropStateCopyWith<$Res> {
  _$ImageCropStateCopyWithImpl(this._value, this._then);

  final ImageCropState _value;
  // ignore: unused_field
  final $Res Function(ImageCropState) _then;

  @override
  $Res call({
    Object? imageFile = freezed,
    Object? isProcessing = freezed,
    Object? croppedData = freezed,
    Object? uint8list = freezed,
  }) {
    return _then(_value.copyWith(
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool?,
      croppedData: croppedData == freezed
          ? _value.croppedData
          : croppedData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      uint8list: uint8list == freezed
          ? _value.uint8list
          : uint8list // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc
abstract class _$$_ImageCropStateCopyWith<$Res>
    implements $ImageCropStateCopyWith<$Res> {
  factory _$$_ImageCropStateCopyWith(
          _$_ImageCropState value, $Res Function(_$_ImageCropState) then) =
      __$$_ImageCropStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Uint8List? imageFile,
      bool? isProcessing,
      Uint8List? croppedData,
      Uint8List? uint8list});
}

/// @nodoc
class __$$_ImageCropStateCopyWithImpl<$Res>
    extends _$ImageCropStateCopyWithImpl<$Res>
    implements _$$_ImageCropStateCopyWith<$Res> {
  __$$_ImageCropStateCopyWithImpl(
      _$_ImageCropState _value, $Res Function(_$_ImageCropState) _then)
      : super(_value, (v) => _then(v as _$_ImageCropState));

  @override
  _$_ImageCropState get _value => super._value as _$_ImageCropState;

  @override
  $Res call({
    Object? imageFile = freezed,
    Object? isProcessing = freezed,
    Object? croppedData = freezed,
    Object? uint8list = freezed,
  }) {
    return _then(_$_ImageCropState(
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool?,
      croppedData: croppedData == freezed
          ? _value.croppedData
          : croppedData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      uint8list: uint8list == freezed
          ? _value.uint8list
          : uint8list // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$_ImageCropState implements _ImageCropState {
  const _$_ImageCropState(
      {this.imageFile, this.isProcessing, this.croppedData, this.uint8list});

// Image? cropImage,
  @override
  final Uint8List? imageFile;
  @override
  final bool? isProcessing;
  @override
  final Uint8List? croppedData;
  @override
  final Uint8List? uint8list;

  @override
  String toString() {
    return 'ImageCropState(imageFile: $imageFile, isProcessing: $isProcessing, croppedData: $croppedData, uint8list: $uint8list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageCropState &&
            const DeepCollectionEquality().equals(other.imageFile, imageFile) &&
            const DeepCollectionEquality()
                .equals(other.isProcessing, isProcessing) &&
            const DeepCollectionEquality()
                .equals(other.croppedData, croppedData) &&
            const DeepCollectionEquality().equals(other.uint8list, uint8list));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(imageFile),
      const DeepCollectionEquality().hash(isProcessing),
      const DeepCollectionEquality().hash(croppedData),
      const DeepCollectionEquality().hash(uint8list));

  @JsonKey(ignore: true)
  @override
  _$$_ImageCropStateCopyWith<_$_ImageCropState> get copyWith =>
      __$$_ImageCropStateCopyWithImpl<_$_ImageCropState>(this, _$identity);
}

abstract class _ImageCropState implements ImageCropState {
  const factory _ImageCropState(
      {final Uint8List? imageFile,
      final bool? isProcessing,
      final Uint8List? croppedData,
      final Uint8List? uint8list}) = _$_ImageCropState;

  @override // Image? cropImage,
  Uint8List? get imageFile => throw _privateConstructorUsedError;
  @override
  bool? get isProcessing => throw _privateConstructorUsedError;
  @override
  Uint8List? get croppedData => throw _privateConstructorUsedError;
  @override
  Uint8List? get uint8list => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ImageCropStateCopyWith<_$_ImageCropState> get copyWith =>
      throw _privateConstructorUsedError;
}
