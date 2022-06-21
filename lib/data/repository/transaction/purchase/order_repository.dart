import '../../../model/result/result.dart';
import '../../../model/transaction/purchase/order_model.dart';

abstract class OrderRepository {
  // アイテムのリストを返す
  Future<Result<List<Order>>> readOrder();
  // アイテムを保存する
  Future<Result<String>> createOrder({required Order order});
  // アイテムを更新する
  Future<Result<void>> updateOrder({required Order order});
  // アイテムを削除する
  Future<Result<void>> deleteOrder({required String orderId});
}
