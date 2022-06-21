import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';

class Footer extends ConsumerWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return AutoTabsScaffold(
      // backgroundColor: theme.appColors.background,
      homeIndex: 1,
      routes: const [
        BazaarListRouter(),
        // UserRoute(),
        // PickerRouter(),
        // ImageCropRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          // backgroundColor: theme.appColors.background,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'All Items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Event List',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.event),
            //   label: 'Purchased items',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_off),
              label: 'User Profile',
            ),
          ],
        );
      },
    );
  }
}
