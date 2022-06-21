import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ui/routes/app_route.gr.dart';
import 'common/drawer.dart';
import 'hooks/use_media_query.dart';
import 'hooks/use_router.dart';
import 'theme/app_theme.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final appRoute = useRouter();
    final appMQ = useMediaQuery();
    //
    // final initialize = ref.watch(firebaseinitializerProvider);
    // initialize.when(
    //     data: (data) {
    //       return const AuthChecker();
    //     },
    //     loading: () => const LoadingScreen(),
    //     error: (e, stackTrace) => ErrorScreen(e, stackTrace));

    return WillPopScope(
      onWillPop: () => _finishNextPage(),
      child: AutoTabsScaffold(
        // backgroundColor: theme.appColors.background,
        appBarBuilder: (_, tabsRouter) {
          return AppBar(
            // surfaceTintColor: Colors.transparent, scrolledUnderElevation: 5,
            // backgroundColor: theme.appColors.primary,
            // foregroundColor: theme.appColors.onPrimary,
            // elevation: 0,
            // title: const Text(
            //   'Jumble Moll',
            // style: theme.textTheme.h50,
            // ),
            centerTitle: true,
            leading: const AutoLeadingButton(
                // color: theme.appColors.onPrimary,
                ),
            actions: const [],
          );
        },
        // drawer: const CustomDrawer(),
        drawer: appMQ.size.width <= 768 ? const CustomDrawer() : null,
        homeIndex: 1,
        routes: const [
          ProductRouter(),
          BazaarListRouter(),
          FavoriteRoute(),
          PurchaseRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return NavigationBar(
            // type: BottomNavigationBarType.shifting,
            // backgroundColor: theme.appColors.primary,
            // selectedIconTheme:
            //     IconThemeData(size: 30, color: theme.appColors.onPrimary),
            // selectedItemColor: theme.appColors.onPrimary,
            // unselectedIconTheme:
            //     IconThemeData(size: 25, color: theme.appColors.onPrimary),
            // currentIndex: tabsRouter.activeIndex,
            selectedIndex: tabsRouter.activeIndex,
            // onTap: tabsRouter.setActiveIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            // items: const [
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.shopping_basket),
            //     label: 'Item List',
            //     // backgroundColor: theme.appColors.primary,
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.event),
            //     label: 'Event List',
            //     // backgroundColor: theme.appColors.primary,
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.bookmark),
            //     label: 'Favorite',
            //     // backgroundColor: theme.appColors.primary,
            //   ),
            //   BottomNavigationBarItem(
            //     icon: FaIcon(FontAwesomeIcons.ticketSimple),
            //     label: 'Purchased Items',
            //     // backgroundColor: theme.appColors.primary,
            //   ),
            // ],
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.shopping_basket),
                icon: Icon(Icons.shopping_basket_outlined),
                label: 'Item List',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.event),
                icon: Icon(Icons.event_outlined),
                label: 'Event List',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark),
                icon: Icon(Icons.bookmark_border),
                label: 'Favorite',
              ),
              NavigationDestination(
                selectedIcon: FaIcon(FontAwesomeIcons.ticketSimple),
                icon: FaIcon(FontAwesomeIcons.ticket),
                label: 'Purchased Items',
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<bool> _finishNextPage() async {
  return false;
}
