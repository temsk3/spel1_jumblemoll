import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/transaction/purchase/order_model.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState({
    @Default(<Order>[]) List<Order> orderList,
  }) = _OrderState;
}
