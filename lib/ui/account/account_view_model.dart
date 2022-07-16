import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/user/user_model.dart';
import '../../data/repository/user/user_repository.dart';

final userViewModelProvider =
    StateNotifierProvider.autoDispose<AccountViewModel, AsyncValue<User>>(
  (ref) => AccountViewModel(ref: ref),
);

class AccountViewModel extends StateNotifier<AsyncValue<User>> {
  final AutoDisposeStateNotifierProviderRef _ref;
  AccountViewModel({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    fetch();
  }

  // bool isLoading = false;
  // User? user;

  // final userRepo = UserRepository();

  // Future<void> init() async {
  //   user = await userRepo.fetch();
  // }

  // Future<void> signOut() async {
  //   await auth.FirebaseAuth.instance.signOut();
  // }
  late final UserRepository userRepository = _ref.watch(userRepositoryProvider);

  Future<void> createUser(
    auth.User? user,
    String customerId,
    String accountId,
  ) async {
    await userRepository.createUser(user, customerId, accountId);
  }

  Future<User?> fetch() async {
    return await userRepository.fetch();
  }

  Future<void> fetchStatus(String id) async {
    userRepository.fetchStatus(id);
  }

  void deleteLocalCache() {
    userRepository.deleteLocalCache();
  }

  Future<void> updatePaymentMethod(String sourceId) async {
    await userRepository.updatePaymentMethod(sourceId: sourceId);
  }
}
