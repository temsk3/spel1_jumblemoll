import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/utils/verification_status.dart';
import '../../data/repository/auth/auth_repository.dart';
import '../auth/error_screen.dart';
import '../auth/loading_screen.dart';
import 'account_view_model.dart';
import 'card_edit_page.dart';
import 'identification_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ChangeNotifierProvider<AccountModel>(
    //   create: (_) => AccountModel()..init(),
    //   child: Consumer<AccountModel>(builder: (context, model, child) {
    // final user = model.user;
    final state = ref.watch(userViewModelProvider);
    final auth = ref.watch(authenticationProvider);
    return state.when(
      data: (user) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('アカウント'),
          ),
          body: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.person_rounded,
                  size: 64,
                ),
                Text(user.displayName ?? ''),
                Text('本人確認 : ${user.status!.toEnumString}'),
                Text('被決済 : ${user.chargesEnabled}'),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const EditCardPage();
                        },
                      ),
                    );
                  },
                  title: const Text('クレジットカードの追加'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const IdentificationPage();
                        },
                      ),
                    );
                  },
                  title: const Text('本人確認'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const Divider(),
                ElevatedButton(
                  onPressed: () async {
                    await auth.signOut();
                  },
                  child: const Text('ログアウト'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}
