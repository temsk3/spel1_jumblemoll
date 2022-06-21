import 'dart:typed_data';

import '../../model/result/result.dart';

abstract class ImageRepository {
  // アイテムのリストを返す
  // Future<Result<void>> readImagePath();
  //
  Future<Result<String>> pictureNameing({required String path});
  // アイテムを保存する
  Future<Result<String>> uploadImage(
      {required Uint8List image,
      required String path,
      required String pictureName});
  // // アイテムを更新する
  // Future<Result<String>> updateImage(
  //     {required Uint8List image, required String id});
  // アイテムを削除する
  Future<Result<void>> deleteImage(
      {required String path, required String pictureName});
}
