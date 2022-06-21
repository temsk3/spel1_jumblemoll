import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final appRoute = useRouter();
    return SafeArea(
      bottom: false,
      child: ClipRRect(
        // 角丸のためにラップ
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                // decoration:
                //     BoxDecoration(color: theme.appColors.onInverseSurface),
                accountName: Text(
                  "User Name",
                  // style: theme.textTheme.h30
                  // .copyWith(
                  //   color: theme.appColors.onPrimary,
                  // ),
                ),
                accountEmail: Text(
                  "User Email",
                  // style: theme.textTheme.h30
                  // .copyWith(
                  //   color: theme.appColors.onPrimary,
                  // ),
                ),
                currentAccountPicture: CircleAvatar(
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
                title: const Text('SignIn'),
                onTap: () {
                  // appRoute.push(const LoginRoute());
                  appRoute.replaceAll([const AuthRoute()]);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  appRoute.push(const AuthRoute());
                },
              ),
              ListTile(
                title: const Text('test3'),
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
