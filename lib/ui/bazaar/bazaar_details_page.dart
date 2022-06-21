import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/product/product_repository_impal.dart';
import '../common/alertdialog.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../product/widget/product_list.dart';
import '../routes/app_route.gr.dart';
import '../theme/app_theme.dart';
import 'bazaar_view_model.dart';

class BazaarDetailsPage extends HookConsumerWidget {
  const BazaarDetailsPage({
    Key? key,
    @PathParam('index') required this.index,
    this.bazaarEvent,
  }) : super(key: key);
  final int index;
  final bazaarEvent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final state = ref.watch(bazzarViewModelProvider);
    final viewModel = ref.watch(bazzarViewModelProvider.notifier);
    final asyncValue = ref.watch(productListStreamProvider);
    const staff = true;

    return asyncValue.when(
      data: (value) {
        final bazaar = bazaarEvent;

        final data =
            value.where((element) => element.bazaarId == bazaar.id).toList();

        return Scaffold(
          // backgroundColor: theme.appColors.background,
          appBar: AppBar(
            // backgroundColor: theme.appColors.primary,
            // foregroundColor: theme.appColors.onPrimary,
            // leading: const AutoLeadingButton(),
            automaticallyImplyLeading: false,
            actions: [
              Visibility(
                visible: staff,
                child: IconButton(
                    onPressed: () async {
                      // appRoute.pop();
                      var result = await customShowDialog(
                        context,
                        'delete',
                        'Do you want to delete it?',
                      );
                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            // backgroundColor: theme.appColors.error,
                            content: Text('Processing Data',
                                style: theme.textTheme.h30
                                // .copyWith(color: theme.appColors.onError),
                                ),
                          ),
                        );
                        viewModel.deleteBazaar(
                          bazaarId: bazaar.id.toString(),
                        );
                        appRoute.popUntilRoot();
                      } else {}
                    },
                    icon: const Icon(Icons.delete)),
              ),
              Visibility(
                visible: staff,
                child: IconButton(
                    onPressed: () async {
                      appRoute.push(BazaarEditRoute(index: index));
                    },
                    icon: const Icon(Icons.edit)),
              ),
            ],
            title: Text(
              bazaar.name.toString(),
              // style: theme.textTheme.h50,
            ),
            centerTitle: true,
            toolbarHeight: 100,
            flexibleSpace: bazaar.pictureURL != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(bazaar.pictureURL as String),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 0.7, 0.95],
                          colors: [
                            Colors.white12,
                            Colors.white54,
                            Colors.white70,
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          // drawer: const CustomDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  Visibility(
                    visible: staff,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        Text('status:', style: theme.textTheme.h30
                            // .copyWith(color: theme.appColors.onBackground),
                            ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: theme.appColors.primary,
                              // onPrimary: theme.appColors.onPrimary,
                              ),
                          onPressed: () {
                            appRoute.push(OrderRoute(bazaar: bazaar.id));
                          },
                          child: Text('order', style: theme.textTheme.h30
                              // .copyWith(color: theme.appColors.onPrimary),
                              ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: theme.appColors.primary,
                              // onPrimary: theme.appColors.onPrimary,
                              ),
                          onPressed: () {
                            appRoute.push(SalesStatusRoute(bazaar: bazaar.id));
                          },
                          child: Text('sales', style: theme.textTheme.h30
                              // .copyWith(color: theme.appColors.onPrimary),
                              ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: theme.appColors.primary,
                              // onPrimary: theme.appColors.onPrimary,
                              ),
                          onPressed: () {
                            appRoute
                                .push(ProductStatusRoute(bazaar: bazaar.id));
                          },
                          child: Text('product', style: theme.textTheme.h30
                              // .copyWith(color: theme.appColors.onPrimary),
                              ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.8,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      final product = data[index];
                      return ProductCard(
                          index: index, product: product, bazaar: bazaar);
                    },
                  ),
                  // Text(
                  //   index.toString(),
                  // ),
                  // Text(
                  //   bazaar.id.toString(),
                  // ),
                  // Text(
                  //   bazaar.name.toString(),
                  // ),
                  // Text(
                  //   bazaar.message.toString(),
                  // ),
                  // Text(
                  //   bazaar.salesStart.toString(),
                  // ),
                  // Text(
                  //   bazaar.salesEnd.toString(),
                  // ),
                  // Text(
                  //   bazaar.eventFrom.toString(),
                  // ),
                  // Text(
                  //   bazaar.eventTo.toString(),
                  // ),
                  // Text(
                  //   bazaar.place.toString(),
                  // ),
                  // Text(
                  //   bazaar.pictureName.toString(),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // ElevatedButton(
                  //     //   child: const Text('複写'),
                  //     //   onPressed: () {
                  //     //     appRoute.push(const BazaarAddRoute());
                  //     //   },
                  //     // ),
                  //     // const Padding(
                  //     //   padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //     // ),
                  //     ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: theme.appColors.primary,
                  //         onPrimary: theme.appColors.onPrimary,
                  //       ),
                  //       child: const Text('削除'),
                  //       onPressed: () async {
                  //         // appRoute.pop();
                  //         var result = await customShowDialog(
                  //           context,
                  //           'delete',
                  //           'Do you want to delete it?',
                  //         );
                  //         if (result) {
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             SnackBar(
                  //               backgroundColor: theme.appColors.error,
                  //               content: const Text('Processing Data'),
                  //             ),
                  //           );
                  //           viewModel.deleteBazaar(
                  //             bazaarId: bazaar.id.toString(),
                  //           );
                  //           appRoute.popUntilRoot();
                  //         } else {
                  //           // appRoute
                  //           //     .popAndPush(BazaarDetailsRouter(index: index));
                  //         }
                  //       },
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //     ),
                  //     ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: theme.appColors.primary,
                  //         onPrimary: theme.appColors.onPrimary,
                  //       ),
                  //       child: const Text('更新'),
                  //       onPressed: () async {
                  //         appRoute.push(BazaarEditRoute(index: index));
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: staff,
            child: FloatingActionButton(
              // backgroundColor: theme.appColors.primary,
              // foregroundColor: theme.appColors.onPrimary,
              onPressed: () {
                // context.navigateTo(ProductRouter(children:ProductAddPage(bazaar: bazaar,)));
                appRoute.push(ProductDetailsRoute(bazaarEvent: bazaar));
              },
              child: const Icon(
                Icons.add_sharp,
                // color: theme.appColors.onPrimary,
              ),
            ),
          ),
        );
      },
      error: (e, msg) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              e.toString(),
              style: theme.textTheme.h30,
            ),
          ),
        ),
      ),
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
