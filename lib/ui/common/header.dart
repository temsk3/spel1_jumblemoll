import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';

class Header extends ConsumerWidget with PreferredSizeWidget {
  Header({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return AppBar(
      // backgroundColor: theme.appColors.primary,
      // foregroundColor: theme.appColors.onPrimary,
      // toolbarHeight: 30,
      title: Text(
        title,
        style: theme.textTheme.h40,
      ),
      centerTitle: true,
      leading: const AutoLeadingButton(),
    );
  }
}
