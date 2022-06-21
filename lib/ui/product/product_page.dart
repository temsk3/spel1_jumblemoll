import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/drawer.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';
import 'product_view_model.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);
    return state.when(
      data: (data) {
        return AutoTabsRouter.tabBar(
          routes: const [
            ProductAllRoute(),
            ProductFoodsRoute(),
            ProductGoodsRoute(),
            ProductOthersRoute(),
          ],
          // homeIndex: 1,
          builder: (context, child, controller) {
            return Scaffold(
              // backgroundColor: theme.appColors.background,
              appBar: AppBar(
                // surfaceTintColor: Colors.transparent, scrolledUnderElevation: 5,
                // // toolbarHeight: 30,
                // backgroundColor: theme.appColors.primary,
                // foregroundColor: theme.appColors.onPrimary,
                // leading: Builder(
                //   builder: (context) {
                //     return IconButton(
                //       icon: const Icon(Icons.account_circle),
                //       onPressed: () {
                //         Scaffold.of(context).openDrawer();
                //       },
                //       tooltip: MaterialLocalizations.of(context)
                //           .openAppDrawerTooltip,
                //     );
                //   },
                // ),
                // title: Text(
                //   // l10n.productlist,
                //   'Product List',
                //   style: theme.textTheme.h40,
                // ),
                // centerTitle: true,
                // bottom: TabBar(
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                      controller: controller,
                      // labelColor: theme.appColors.onPrimaryContainer,
                      // unselectedLabelColor: theme.appColors.onPrimaryContainer,
                      // indicatorColor: theme.appColors.onPrimaryContainer,
                      tabs: const <Tab>[
                        Tab(text: 'All Item'),
                        Tab(text: 'Foods'),
                        Tab(text: 'Goods'),
                        Tab(text: 'Others'),
                      ],
                    ),
                  ],
                ),
              ),
              // drawer: const CustomDrawer(),
              body: Row(
                children: [
                  MediaQuery.of(context).size.width > 768
                      ? const CustomDrawer()
                      : Container(),
                  Expanded(
                    child: Center(
                      child: child,
                    ),
                  ),
                ],
              ),
              // SafeArea(
              //   child: RefreshIndicator(
              //     onRefresh: () async {
              //       viewModel.readProduct();
              //     },
              //     child: GridView.builder(
              //       gridDelegate:
              //           const SliverGridDelegateWithMaxCrossAxisExtent(
              //         maxCrossAxisExtent: 200,
              //         childAspectRatio: 0.8,
              //       ),
              //       padding: const EdgeInsets.all(16.0),
              //       itemCount: data.productList.length,
              //       itemBuilder: (_, index) {
              //         final product = data.productList[index];
              //         return ProductCard(index: index, product: product);
              //       },
              //     ),
              //   ),
              // ),
              // floatingActionButton: FloatingActionButton(
              //   backgroundColor: theme.appColors.primary,
              //   foregroundColor: theme.appColors.onPrimary,
              //   onPressed: () {
              //     appRoute.push(const ProductAddRoute());
              //   },
              //   child: Icon(
              //     Icons.add_sharp,
              //     color: theme.appColors.onPrimary,
              //   ),
              // ),
            );
          },
        );
      },
      error: (e, msg) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                e.toString(),
                style: theme.textTheme.h30,
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                  // color: theme.appColors.primary,
                  ),
            ),
          ),
        );
      },
    );
  }
}
