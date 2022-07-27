import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/user/user_model.dart';
import '../../data/repository/auth/auth_repository.dart';
import '../../data/repository/user/user_repository.dart';
import '../../gen/assets.gen.dart';
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
    final editName = useTextEditingController.fromValue(TextEditingValue.empty);

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
      data: (data) async {
        if (data != null) {
          type = Status.login;
        } else {
          type = Status.logout;
        }

        // PackageInfo packageInfo = await PackageInfo.fromPlatform();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // place the logout at the end of the drawer
            children: <Widget>[
              Flexible(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      // decoration:
                      //     BoxDecoration(color: theme.appColors.onInverseSurface),
                      accountName: type == Status.login
                          // ? Text(data.currentUser!.displayName.toString())
                          ? Row(
                              children: [
                                Text(name),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        final localizations =
                                            MaterialLocalizations.of(context);
                                        return AlertDialog(
                                          // title: Text('タイトル'),
                                          content: TextField(
                                            controller: editName,
                                            decoration: const InputDecoration(
                                                hintText: "Full Name"),
                                            onChanged: (value) {
                                              editName.text = value;
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(localizations
                                                  .cancelButtonLabel),
                                              onPressed: () {
                                                appRoute.pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                  localizations.okButtonLabel),
                                              onPressed: () {
                                                logger.d(editName.text);

                                                final editUser = User(
                                                  id: uid,
                                                  displayName: editName.text,
                                                );
                                                ref
                                                    .watch(
                                                        userRepositoryProvider)
                                                    .updateUser(editUser);
                                                appRoute.pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
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
                      leading: type == Status.login
                          ? const Icon(Icons.logout)
                          : const Icon(Icons.login),
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
                        leading: const Icon(Icons.person_outline_outlined),
                        title: const Text('Profile'),
                        onTap: () {
                          appRoute.push(const AccountRoute());
                        },
                      ),
                    // ListTile(
                    //   title: const Text('License'),
                    //   onTap: () => showLicensePage(
                    //     context: context,
                    //     applicationName: "a",
                    //     applicationVersion: '1.0.0',
                    //   ),
                    // ),
                    // ListTile(
                    //   title: const Text('Information'),
                    //   onTap: () => showAboutDialog(
                    //     context: context,
                    //     applicationName: "a",
                    //     applicationVersion: '1.0.0',
                    //   ),
                    // ),Terms
                  ],
                ),
              ),
              // Flexible(
              //   child: ListView(
              //     children: [
              ListTile(
                leading: const Icon(Icons.library_books_outlined),
                title: const Text('Terms'),
                onTap: () {},
              ),
              //     ],
              //   ),
              // ),
              AboutListTile(
                icon: const Icon(Icons.info_outline),
                applicationName: 'JumbleMoll',
                applicationVersion: '0.1.0',
                // applicationIcon: Image.asset('icon-32x32.png'),
                applicationIcon: Assets.img.icon32x32.image(),
                applicationLegalese: '2022 Spel1',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
