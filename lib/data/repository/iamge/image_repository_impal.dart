import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../model/result/result.dart';
import 'image_repository.dart';

final imageRepositoryProvider =
    Provider<ImageRepository>((ref) => ImageRepositoryImpl(ref.read));

class ImageRepositoryImpl implements ImageRepository {
  ImageRepositoryImpl(this._reader);
  final Reader _reader;

  final storage = FirebaseStorage.instance;
  final _path = 'events';

  // @override
  // Future<Result<void>> readImagePath() async {
  //   return Result.guardFuture(
  //     () async {
  //       return;
  //     },
  //   );
  // }
  @override
  Future<Result<String>> pictureNameing({required String path}) async {
    return Result.guardFuture(() async {
      var uuid = const Uuid();
      var newName = uuid.v4();
      final storageRef = storage.ref();
      final ref = storageRef.child(path);
      final listResult = await ref.listAll();
      while (listResult.items.any((item) => item.name == '$newName.jpg')) {
        newName = uuid.v4();
      }
      String fileName = '$newName.jpg';
      return fileName;
    });
  }

  @override
  Future<Result<String>> uploadImage(
      {required Uint8List image,
      required String path,
      required String pictureName}) async {
    return Result.guardFuture(
      () async {
        // 登録
        final storageRef = storage.ref();
        final mountainsRef = storageRef.child(path).child(pictureName);
        try {
          await mountainsRef.putData(
            image,
            SettableMetadata(
              contentType: "image/jpeg",
            ),
          );
        } on FirebaseException catch (e) {
          e.toString();
        }
        return await mountainsRef.getDownloadURL();
      },
    );
  }

  // @override
  // Future<Result<String>> updateImage(
  //     {required Uint8List image, required String id}) async {
  //   return Result.guardFuture(
  //     () async {
  //       final imagePath = await uploadImage(image: image, id: id) as String;
  //       return imagePath;
  //     },
  //   );
  // }

  @override
  Future<Result<void>> deleteImage(
      {required String path, required String pictureName}) async {
    return Result.guardFuture(
      () async {
        final storageRef = storage.ref();
        final mountainsRef = storageRef.child(path);
        final listResult = await mountainsRef.listAll();
        for (var item in listResult.items) {
          if (item.name == pictureName) {
            await mountainsRef.child(pictureName).delete();
          }
        }
        // アイテムを削除
        // await storage.ref('$id.jpg').delete();
      },
    );
  }
}
