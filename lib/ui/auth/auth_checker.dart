import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './error_screen.dart';
import './loading_screen.dart';
import '../../data/repository/auth/auth_repository.dart';
import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import 'login_page.dart';

class AuthChecker extends HookConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  //  Notice here we aren't using stateless/statefull widget. Instead we are using
  //  a custom widget that is a consumer of the state.
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.

    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    final authState = ref.watch(authStateProvider);
    final appRoute = useRouter();

    return authState.when(
        data: (data) {
          if (data != null) {
            appRoute.replaceAll([const HomeRoute()]);
          }
          return const LoginPage();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}
