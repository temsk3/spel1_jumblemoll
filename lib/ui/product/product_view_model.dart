import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product/product_model.dart';
import '../../data/repository/iamge/image_repository.dart';
import '../../data/repository/iamge/image_repository_impal.dart';
import '../../data/repository/product/product_repository.dart';
import '../../data/repository/product/product_repository_impal.dart';
import 'product_state.dart';

final productViewModelProvider = StateNotifierProvider.autoDispose<
    ProductViewModel, AsyncValue<ProductState>>(
  (ref) => ProductViewModel(ref: ref),
);

class ProductViewModel extends StateNotifier<AsyncValue<ProductState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  ProductViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    readProduct();
  }
  final String _path = 'products';
  // repository
  late final ProductRepository productRepository =
      _ref.read(productRepositoryProvider);
  late final ImageRepository imageRepository =
      _ref.read(imageRepositoryProvider);

  // 取得
  Future<void> readProduct() async {
    final result = await productRepository.readProduct();
    result.when(
      success: (data) {
        state = AsyncValue.data(
          ProductState(productList: data),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  // 追加
  Future<void> addProduct({
    required String organizer,
    required String bazaarId,
    required DateTime salesStart,
    required DateTime salesEnd,
    required String register,
    required String? code,
    required String name,
    required String genre,
    required String desc,
    required int stock,
    required int price,
    required DateTime expirationFrom,
    required DateTime expirationTo,
    required bool isPublished,
    required Uint8List? picture1,
    // required Uint8List? picture2,
    // required Uint8List? picture3,
  }) async {
    var product = Product(
      organizer: organizer,
      bazaarId: bazaarId,
      salesStart: salesStart,
      salesEnd: salesEnd,
      register: register,
      code: code,
      name: name,
      genre: genre,
      desc: desc,
      stock: stock,
      price: price,
      expirationFrom: expirationFrom,
      expirationTo: expirationTo,
      isPublished: isPublished,
    );
    if (picture1 != null) {
      product = await pictureAdd(
        path: _path,
        newPicture1: picture1,
        updateProduct: product,
      );
    }
    final productId = await productRepository.createProduct(product: product);
    productId.when(
      success: (id) async {
        final productList = state.value!.productList;
        state = AsyncValue.data(
          ProductState(
            productList: productList
              ..add(
                product.copyWith(id: id),
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
  Future<void> updateProduct({
    required Product updateProduct,
    Uint8List? newPicture1,
    String? oldPicture1,
  }) async {
    if (newPicture1 != null) {
      if (oldPicture1 != null) {
        await imageRepository.deleteImage(
          path: _path,
          pictureName: updateProduct.picture1Name.toString(),
        );
      }
      updateProduct = await pictureAdd(
        path: _path,
        newPicture1: newPicture1,
        updateProduct: updateProduct,
      );
    }
    final result =
        await productRepository.updateProduct(product: updateProduct);
    result.when(
      success: (data) {
        final products = state.value!.productList;
        state = AsyncValue.data(
          ProductState(
            productList: [
              for (final product in products)
                if (product.id == updateProduct.id) updateProduct else product
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
  Future<void> deleteProduct({required String productId}) async {
    final result = await productRepository.deleteProduct(productId: productId);
    result.when(
      success: (data) async {
        final productList = state.value!.productList;
        for (var product in productList) {
          if (product.id == productId) {
            if (product.picture1URL != null) {
              await imageRepository.deleteImage(
                path: _path,
                pictureName: product.picture1Name.toString(),
              );
            }
          }
        }
        state = AsyncValue.data(
          ProductState(
            productList: productList
              ..removeWhere((product) => product.id == productId),
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  //image
  Future<Product> pictureAdd({
    required String path,
    required Uint8List newPicture1,
    required Product updateProduct,
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
        image: newPicture1, path: _path, pictureName: pictureName.toString());
    url.when(
      success: (url) {
        pictureURL = url;
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
    return updateProduct.copyWith(
      picture1Name: pictureName,
      picture1URL: pictureURL,
    );
  }
}
