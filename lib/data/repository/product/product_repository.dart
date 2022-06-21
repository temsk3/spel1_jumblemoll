import '../../model/product/product_model.dart';
import '../../model/result/result.dart';

abstract class ProductRepository {
  // アイテムのリストを返す
  Future<Result<List<Product>>> readProduct();
  // アイテムを保存する
  Future<Result<String>> createProduct({required Product product});
  // アイテムを更新する
  Future<Result<void>> updateProduct({required Product product});
  // アイテムを削除する
  Future<Result<void>> deleteProduct({required String productId});
}
