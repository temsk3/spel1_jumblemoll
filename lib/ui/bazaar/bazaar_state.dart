import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/bazaar/bazaar_model.dart';
import '../../data/model/bazaar/supporter_model.dart';

part 'bazaar_state.freezed.dart';

@freezed
class BazaarState with _$BazaarState {
  const factory BazaarState({
    @Default(<Bazaar>[]) List<Bazaar> bazaarList,
    @Default(<Supporter>[]) List<Supporter> supporterList,
  }) = _BazaarState;
}
