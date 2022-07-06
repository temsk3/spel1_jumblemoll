import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/stripe/stripe_individual.dart';
import '../../data/model/user/user_model.dart';
import '../../data/repository/stripe/stripe_repository.dart';

final stripeViewModelProvider =
    StateNotifierProvider.autoDispose<StripeViewModel, AsyncValue<dynamic>>(
  (ref) => StripeViewModel(ref: ref),
);

class StripeViewModel extends StateNotifier<AsyncValue<dynamic>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  StripeViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading());

  late final StripeRepository stripeRepository =
      _ref.watch(stripeRepositoryProvider);

  Future<String> createCustomer(String email) async {
    return await stripeRepository.createCustomer(email);
  }

  Future retrieveCard(String customerId, String sourceId) async {
    return await retrieveCard(customerId, sourceId);
  }

  Future<String> registerCard(String customerId, String cardToken) async {
    return await registerCard(customerId, cardToken);
  }

  Future<Map<String, dynamic>> retrieveConnectAccount(User? user) async {
    return await retrieveConnectAccount(user);
  }

  Future<String> createConnectAccount(String email) async {
    return await createConnectAccount(email);
  }

  Future<void> updateConnectAccount(
    User? user,
    StripeIndividual? individual,
    TosAcceptance? tosAcceptance,
  ) async {
    await updateConnectAccount(user, individual, tosAcceptance);
  }

  Future<void> createCharge(
    String? customerId,
    int? amount,
    String? accountId,
  ) async {
    await createCharge(customerId, amount, accountId);
  }
}
