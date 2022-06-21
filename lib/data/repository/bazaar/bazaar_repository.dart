import '../../model/bazaar/bazaar_model.dart';
import '../../model/result/result.dart';

abstract class BazaarRepository {
  // アイテムのリストを返す
  Future<Result<List<Bazaar>>> readBazaar();
  // アイテムを保存する
  Future<Result<String>> createBazaar({required Bazaar bazaar});
  // アイテムを更新する
  Future<Result<void>> updateBazaar({required Bazaar bazaar});
  // アイテムを削除する
  Future<Result<void>> deleteBazaar({required String bazaarId});
}
