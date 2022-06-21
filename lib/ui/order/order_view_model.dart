import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/transaction/purchase/order_model.dart';
import '../../data/repository/transaction/purchase/order_repository.dart';
import '../../data/repository/transaction/purchase/order_repository_impal.dart';
import 'order_state.dart';

final orderViewModelProvider =
    StateNotifierProvider.autoDispose<OrderViewModel, AsyncValue<OrderState>>(
  (ref) => OrderViewModel(ref: ref),
);

class OrderViewModel extends StateNotifier<AsyncValue<OrderState>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  OrderViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    readOrder();
  }
  // repository
  late final OrderRepository orderRepository =
      _ref.read(orderRepositoryProvider);

  // 取得
  Future<void> readOrder() async {
    final result = await orderRepository.readOrder();
    result.when(
      success: (data) {
        state = AsyncValue.data(
          OrderState(orderList: data),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }

  // 追加
  Future<void> addOrder({
    String? userId,
    String? userName,
    String? organizer,
    String? bazaarId,
    String? bazaarName,
    int? exchangeNumber,
    String? code,
    required String? name,
    required String? desc,
    required int price,
    required int numberOfUse,
    required int quantity,
    String? picture1URL,
    String? picture2URL,
    String? picture3URL,
    required DateTime? expirationFrom,
    required DateTime? expirationTo,
  }) async {
    var order = Order(
      userId: userId,
      userName: userName,
      organizer: organizer,
      bazaarId: bazaarId,
      bazaarName: bazaarName,
      code: code,
      name: name,
      desc: desc,
      price: price,
      numberOfUse: quantity,
      quantity: quantity,
      sum: price * quantity,
      picture1URL: picture1URL,
      picture2URL: picture2URL,
      picture3URL: picture3URL,
      expirationFrom: expirationFrom,
      expirationTo: expirationTo,
      isActive: true,
    );
    final orderId = await orderRepository.createOrder(order: order);
    orderId.when(
      success: (id) async {
        final orderList = state.value!.orderList;
        state = AsyncValue.data(
          OrderState(
            orderList: orderList
              ..add(
                order.copyWith(id: id),
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
  Future<void> updateOrder({required Order updateOrder}) async {
    final result = await orderRepository.updateOrder(order: updateOrder);
    result.when(
      success: (data) {
        final orders = state.value!.orderList;
        state = AsyncValue.data(
          OrderState(
            orderList: [
              for (final order in orders)
                if (order.id == updateOrder.id) updateOrder else order
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
  Future<void> deleteOrder({required String orderId}) async {
    final result = await orderRepository.deleteOrder(orderId: orderId);
    result.when(
      success: (data) async {
        final orderList = state.value!.orderList;
        state = AsyncValue.data(
          OrderState(
            orderList: orderList
              ..removeWhere((product) => product.id == orderId),
          ),
        );
      },
      failure: (error) {
        state = AsyncValue.error(error);
      },
    );
  }
}
