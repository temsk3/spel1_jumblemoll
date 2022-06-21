import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/drawer.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    return Scaffold(
      // appBar: TopHeader(title: 'Products you care about'),
      // drawer: const CustomDrawer(),
      // appBar: AppBar(
      //   backgroundColor: theme.appColors.primary,
      //   foregroundColor: theme.appColors.onPrimary,
      //   leading: Builder(
      //     builder: (context) {
      //       return IconButton(
      //         icon: const Icon(Icons.account_circle),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //       );
      //     },
      //   ),
      //   title: Text(
      //     'Favorite',
      //     style: theme.textTheme.h50,
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Row(
          children: [
            MediaQuery.of(context).size.width > 768
                ? CustomDrawer()
                : Container(),
            Expanded(
              child: Center(
                child: ListView(children: const []),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
