import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/user/user_model.dart';
import '../../data/repository/auth/auth_repository.dart';
import '../../data/repository/user/user_repository.dart';
import '../auth/error_screen.dart';
import '../auth/loading_screen.dart';
import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';

enum Status {
  login,
  logout,
}

Status type = Status.logout;

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final appRoute = useRouter();
    final data = ref.watch(fireBaseAuthProvider);
    final auth = ref.watch(authenticationProvider);
    final authState = ref.watch(authStateProvider);
    final userStream = ref.watch(userStreamProvider);
    String uid = 'non';
    String name = 'non';
    String email = 'non';
    User? user;
    userStream.whenData((value) => user = value);
    if (user != null) {
      uid = user!.id.toString();
      name = user!.displayName.toString();
      email = user!.email.toString();
    }
    authState.when(
      data: (data) {
        if (data != null) {
          type = Status.login;
        } else {
          type = Status.logout;
        }
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e, trace),
    );

    return SafeArea(
      bottom: false,
      child: ClipRRect(
        // 角丸のためにラップ
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                // decoration:
                //     BoxDecoration(color: theme.appColors.onInverseSurface),
                accountName: type == Status.login
                    // ? Text(data.currentUser!.displayName.toString())
                    ? Text(name)
                    : const Text('non'),
                // style: theme.textTheme.h30
                // .copyWith(
                //   color: theme.appColors.onPrimary,
                // ),
                // ),
                accountEmail: type == Status.login
                    // ? Text(data.currentUser!.email.toString())

                    ? Text(email)
                    : const Text('non'),
                // style: theme.textTheme.h30
                // .copyWith(
                //   color: theme.appColors.onPrimary,
                // ),
                // ),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  // backgroundImage: NetworkImage(userAvatarUrl),
                ),
              ),
              // DrawerHeader(
              //   child: Text(
              //     'header',
              //     style: theme.textTheme.h50,
              //   ),
              //   decoration: BoxDecoration(color: theme.appColors.primary),
              // ),
              ListTile(
                title: type == Status.login
                    ? const Text('log out')
                    : const Text('log in'),
                onTap: type == Status.login
                    ? () {
                        auth.signOut();
                      }
                    : () {
                        appRoute.replaceAll([const AuthRoute()]);
                      },
              ),
              if (type == Status.login)
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    appRoute.push(const AccountRoute());
                  },
                ),
              ListTile(
                title: const Text('terms'),
                onTap: () {
                  // appRoute.push(const StartRoute());ß
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
