import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jumblemoll/data/model/user/user_model.dart';
import 'package:logger/logger.dart';

import '../../data/repository/auth/auth_repository.dart';
import '../../data/repository/transaction/purchase/order_repository_impal.dart';
import '../../data/repository/user/user_repository.dart';
import '../../ui/theme/app_text_theme.dart';
import '../common/drawer.dart';
import '../common/show_dialog.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_media_query.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';

final logger = Logger();

class PurchasePage extends HookConsumerWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMQ = useMediaQuery();
    final state = ref.watch(orderViewModelProvider);
    final viewModel = ref.watch(orderViewModelProvider.notifier);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final NumberFormat numFormatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final DateFormat dateFormatter =
        DateFormat.yMMMEd(Localizations.localeOf(context).toString());
    final scrollController = ScrollController();
    var verticalScrollController = ScrollController();
    var horizontalScrollController = ScrollController();
    final localizations = MaterialLocalizations.of(context);
    final authState = ref.watch(authStateProvider);
    //
    // authState.when(
    //     data: (data) {
    //       if (data != null) {
    //         logger.d(data.uid);
    //       }
    //     },
    //     loading: () => const LoadingScreen(),
    //     error: (e, trace) => ErrorScreen(e, trace),);
    final userStream = ref.watch(userStreamProvider);
    String uid = '';
    String name = 'non';
    User? user;
    userStream.whenData((value) => user = value);
    if (user != null) {
      uid = user!.id.toString();
      name = user!.displayName.toString();
    }
    logger.d(uid);
    logger.d(name);

    final id = auth.FirebaseAuth.instance.currentUser?.uid;
    logger.d(uid);

    if (id != null) {
      final asyncValue = ref.watch(orderStreamProvider(id));

      return asyncValue.when(
        data: (order) {
          final data = order.where((data) => data.userId == uid).toList();
          data.sort((a, b) {
            int result1 =
                a.createdAt.toString().compareTo(b.createdAt.toString());
            if (result1 != 0) return result1;
            int result2 =
                b.quantity.toString().compareTo(a.quantity.toString());
            return result2;
          });
          int sum = 0;
          for (var e in data) {
            sum = (sum + (e.sum! * e.quantity!));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('$name:${formatter.format(sum)}'),
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
              child: Row(
                children: [
                  appMQ.size.width > 768 ? const CustomDrawer() : Container(),
                  Expanded(
                      child: Center(
                    child: SizedBox(
                      width: appMQ.size.width >= 768 ? 400 : null,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          final ticket = data[index];
                          // numberOfUse.value = ticket.numberOfUse as int;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Card(
                                color: ticket.numberOfUse == 0
                                    ? Colors.black.withOpacity(0.7)
                                    : null,
                                // theme.appColors.background,
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(15)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: const EdgeInsets.all(8.0),
                                elevation: 10.0,
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      leading: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: ticket.numberOfUse == 0
                                              ? Colors.black.withOpacity(0.7)
                                              : Colors.grey.withOpacity(.5),
                                          // borderRadius: BorderRadius.circular(10),
                                          image: ticket.picture1URL != null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(ticket
                                                      .picture1URL as String),
                                                )
                                              : null,
                                        ),
                                        child: ticket.picture1URL == null
                                            ? Center(
                                                child: Text('NoImage',
                                                    style: theme.textTheme.h20
                                                    // .copyWith(
                                                    //     color: theme.appColors.onPrimary),
                                                    ),
                                              )
                                            : null,
                                      ),
                                      title: Column(
                                        children: [
                                          Text(
                                            ticket.bazaarName.toString(),
                                            // style: theme.textTheme.h30.bold().copyWith(
                                            //     color: theme.appColors.onBackground),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(ticket.code.toString(),
                                                      style: theme.textTheme.h30
                                                          .bold()
                                                      //     .copyWith(
                                                      //         color:
                                                      //             theme.appColors.onBackground),
                                                      ),
                                                  const Text(''),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(ticket.name.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme.textTheme.h30
                                                          .bold()
                                                      //     .copyWith(
                                                      //         color:
                                                      //             theme.appColors.onBackground),
                                                      ),
                                                  Text(
                                                      formatter
                                                          .format(ticket.price),
                                                      style: theme.textTheme.h30
                                                          .bold()
                                                      //     .copyWith(
                                                      //         color:
                                                      //             theme.appColors.onBackground),
                                                      ),
                                                ],
                                              ),
                                              // const Padding(
                                              //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                                              // ),
                                              Text(
                                                  '${ticket.numberOfUse.toString()}/${ticket.quantity.toString()}',
                                                  style:
                                                      theme.textTheme.h30.bold()
                                                  // .copyWith(
                                                  //     color:
                                                  //         theme.appColors.onBackground),
                                                  ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                          '有効期限：${dateFormatter.format(ticket.expirationFrom as DateTime)}〜${dateFormatter.format(ticket.expirationTo as DateTime)}',
                                          style: theme.textTheme.h10
                                          // .copyWith(
                                          //     color: theme.appColors.onBackground),
                                          ),
                                      // trailing: const Icon(Icons.navigate_next),
                                      //利用処理
                                      onTap: (ticket.numberOfUse! <= 0)
                                          ? null
                                          : (ticket.numberOfUse! == 1)
                                              ? () async {
                                                  final isConfirmed =
                                                      await showConfirmDialog(
                                                          context,
                                                          '「${ticket.name.toString()}」チケットを${ticket.numberOfUse.toString()}枚使用します');
                                                  if (isConfirmed) {
                                                    try {
                                                      // 使用処理
                                                      viewModel.updateOrder(
                                                        updateOrder:
                                                            ticket.copyWith(
                                                          numberOfUse: 0,
                                                          isActive: false,
                                                        ),
                                                      );
                                                      await showTextDialog(
                                                          context,
                                                          '引換え処理を完了しました');
                                                    } catch (e) {
                                                      await showTextDialog(
                                                          context,
                                                          e.toString());
                                                    }
                                                  }
                                                }
                                              : () async {
                                                  final isConfirmed =
                                                      await showQuantityConfirmDialog(
                                                          context,
                                                          ticket.numberOfUse
                                                              as int,
                                                          ticket.name
                                                              .toString());

                                                  if (isConfirmed != 0) {
                                                    try {
                                                      final result =
                                                          (ticket.numberOfUse! -
                                                              isConfirmed);
                                                      result == 0
                                                          ? viewModel
                                                              .updateOrder(
                                                              updateOrder:
                                                                  ticket
                                                                      .copyWith(
                                                                numberOfUse:
                                                                    (result),
                                                              ),
                                                            )
                                                          : viewModel
                                                              .updateOrder(
                                                              updateOrder:
                                                                  ticket
                                                                      .copyWith(
                                                                numberOfUse:
                                                                    (result),
                                                                isActive: false,
                                                              ),
                                                            );
                                                      // 使用処理
                                                      await showTextDialog(
                                                          context,
                                                          '引換え処理を完了しました');
                                                    } catch (e) {
                                                      await showTextDialog(
                                                          context,
                                                          e.toString());
                                                    }
                                                  }
                                                },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
          // : const Scaffold();
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
    } else {
      return const Scaffold();
    }
  }
}
