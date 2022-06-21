import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../hooks/use_router.dart';
import '../theme/app_theme.dart';

class CommonDrawer extends HookConsumerWidget {
  const CommonDrawer({Key? key}) : super(key: key);

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
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(),
                accountName: Text("User Name", style: theme.textTheme.h30
                    // .copyWith(
                    //   color: theme.appColors.onPrimary,
                    // ),
                    ),
                accountEmail: Text("User Email", style: theme.textTheme.h30
                    // .copyWith(
                    //   color: theme.appColors.onPrimary,
                    // ),
                    ),
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
                title: const Text('signin'),
                onTap: () {
                  // appRoute.push(const AuthRoute());
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('test3'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
