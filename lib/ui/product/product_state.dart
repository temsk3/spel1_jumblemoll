import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/product/product_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(<Product>[]) List<Product> productList,
  }) = _ProductState;
}
