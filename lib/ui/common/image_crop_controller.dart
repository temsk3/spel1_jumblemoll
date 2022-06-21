import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as imgLib;
import 'package:image_picker/image_picker.dart';

part 'image_crop_controller.freezed.dart';

@freezed
class ImageCropState with _$ImageCropState {
  const factory ImageCropState({
    // Image? cropImage,
    Uint8List? imageFile,
    bool? isProcessing,
    Uint8List? croppedData,
    Uint8List? uint8list,
  }) = _ImageCropState;
}

final imageCropProvider =
    StateNotifierProvider.autoDispose<ImageCropController, ImageCropState>(
        (ref) {
  return ImageCropController();
});

class ImageCropController extends StateNotifier<ImageCropState> {
  ImageCropController() : super(const ImageCropState());

  // Future<void> crop(Image? image) async {
  //   if (image == null) return;
  //   state = state.copyWith(cropImage: image);
  // }

  // Future<void> cropImage(XFile image) async {
  //   Uint8List byte = await image.readAsBytes();
  //   state = state.copyWith(imageFile: byte);
  // }
  Future<void> saveImage(Uint8List? value) async {
    if (value == null) return;
    imgLib.Image? image = imgLib.decodeImage(value);
    Uint8List imageData = Uint8List.fromList(imgLib.encodeJpg(image!));
    state = state.copyWith(imageFile: imageData);
  }

  Future<void> isProcessing(bool? value) async {
    if (value == null) return;
    state = state.copyWith(isProcessing: value);
  }

  Future<void> croppedData(Uint8List? value) async {
    state = state.copyWith(croppedData: value);
  }

  Future<void> pickImage(XFile? value) async {
    if (value == null) return;
    state = state.copyWith(uint8list: await value.readAsBytes());
  }
}
