import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/bazaar/bazaar_model.dart';
import '../../data/model/bazaar/supporter_model.dart';
import '../../data/repository/bazaar/bazaar_repository.dart';
import '../../data/repository/bazaar/bazaar_repository_impal.dart';
import '../../data/repository/iamge/image_repository.dart';
import '../../data/repository/iamge/image_repository_impal.dart';
import 'bazaar_state.dart';

final bazaarViewModelProvider =
    StateNotifierProvider.autoDispose<BazaarViewModel, AsyncValue<BazaarState>>(
  (ref) => BazaarViewModel(ref: ref),
);

class BazaarViewModel extends StateNotifier<AsyncValue<BazaarState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  BazaarViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    readBazaar();
  }
  final String _path = 'events';
  // repository
  late final BazaarRepository bazaarRepository =
      _ref.read(bazaarRepositoryProvider);
  late final ImageRepository imageRepository =
      _ref.read(imageRepositoryProvider);

  // 取得
  Future<void> readBazaar() async {
    final result = await bazaarRepository.readBazaar();
    result.when(
      success: (data) {
        state = AsyncValue.data(
          BazaarState(bazaarList: data),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  // 追加
  Future<void> addBazaarEvent({
    required String organizer,
    required String name,
    required String message,
    required DateTime salesStart,
    required DateTime salesEnd,
    required DateTime eventFrom,
    required DateTime eventTo,
    required String place,
    required Uint8List? picture,
  }) async {
    var bazaar = Bazaar(
      organizer: organizer,
      name: name,
      message: message,
      salesStart: salesStart,
      salesEnd: salesEnd,
      eventFrom: eventFrom,
      eventTo: eventTo,
      place: place,
    );
    if (picture != null) {
      bazaar = await pictureAdd(
        path: _path,
        newPicture: picture,
        updateBazaar: bazaar,
      );
    }
    final bazaarId = await bazaarRepository.createBazaar(bazaar: bazaar);
    bazaarId.when(
      success: (id) async {
        final bazaarList = state.value!.bazaarList;
        state = AsyncValue.data(
          BazaarState(
            bazaarList: bazaarList
              ..add(
                bazaar.copyWith(id: id),
              ),
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  // 更新
  Future<void> updateBazaar({
    required Bazaar updateBazaar,
    Uint8List? newPicture,
    String? oldPicture,
  }) async {
    if (newPicture != null) {
      if (oldPicture != null) {
        await imageRepository.deleteImage(
          path: _path,
          pictureName: updateBazaar.pictureName.toString(),
        );
      }
      updateBazaar = await pictureAdd(
        path: _path,
        newPicture: newPicture,
        updateBazaar: updateBazaar,
      );
    }
    final result = await bazaarRepository.updateBazaar(bazaar: updateBazaar);
    result.when(
      success: (data) {
        final bazaars = state.value!.bazaarList;
        state = AsyncValue.data(
          BazaarState(
            bazaarList: [
              for (final bazaar in bazaars)
                if (bazaar.id == updateBazaar.id) updateBazaar else bazaar
            ],
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  //削除
  Future<void> deleteBazaar({required String bazaarId}) async {
    final result = await bazaarRepository.deleteBazaar(bazaarId: bazaarId);
    result.when(
      success: (data) async {
        final bazaarList = state.value!.bazaarList;
        for (var event in bazaarList) {
          if (event.id == bazaarId && event.pictureURL != null) {
            await imageRepository.deleteImage(
              path: _path,
              pictureName: event.pictureName.toString(),
            );
          }
        }
        state = AsyncValue.data(
          BazaarState(
            bazaarList: bazaarList
              ..removeWhere((bazaarEvent) => bazaarEvent.id == bazaarId),
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  //image
  Future<Bazaar> pictureAdd({
    required String path,
    required Uint8List newPicture,
    required Bazaar updateBazaar,
  }) async {
    String? pictureName;
    String? pictureURL;
    final name = await imageRepository.pictureNameing(path: path);
    name.when(success: (name) {
      pictureName = name;
    }, failure: (error) {
      state = AsyncValue.error(error);
    });
    final url = await imageRepository.uploadImage(
        image: newPicture, path: _path, pictureName: pictureName.toString());
    url.when(
      success: (url) {
        pictureURL = url;
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
    return updateBazaar.copyWith(
      pictureName: pictureName,
      pictureURL: pictureURL,
    );
  }

  //Supporter
  // 取得
  Future<void> readSupporters({required String bazaarId}) async {
    final result = await bazaarRepository.readSupporters(bazaarId: bazaarId);
    result.when(
      success: (data) {
        state = AsyncValue.data(
          BazaarState(supporterList: data),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  Future<void> createSupporter({
    required String bazaarId,
    required String uid,
    required String name,
  }) async {
    var supporter = Supporter(
      uid: uid,
      name: name,
      isActive: false,
    );
    final result = await bazaarRepository.createSupporter(
      bazaarId: bazaarId,
      supporter: supporter,
    );
    result.when(
      success: (data) {},
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  Future<void> updateSupporter({
    required String bazaarId,
    required String uid,
    required String name,
    required bool isActive,
  }) async {
    var updateSupporter = Supporter(
      uid: uid,
      name: name,
      isActive: isActive,
    );
    final result = await bazaarRepository.updateSupporter(
      bazaarId: bazaarId,
      supporter: updateSupporter,
    );
    result.when(
      success: (data) {
        final supporters = state.value!.supporterList;
        state = AsyncValue.data(
          BazaarState(
            supporterList: [
              for (final supporter in supporters)
                if (supporter.uid == updateSupporter.uid)
                  updateSupporter
                else
                  supporter
            ],
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }
}
