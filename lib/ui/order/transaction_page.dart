import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/order/widget/ticket_list.dart';
import '../common/drawer.dart';
import '../common/header_top.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';

class TransactionPage extends HookConsumerWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    return Scaffold(
      appBar: TopHeader(title: 'List'),
      drawer: CustomDrawer(),
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
      //     'Tickets',
      //     style: theme.textTheme.h50,
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Center(
          // child: ListView(children: const []),
          child: Column(children: [TicketList()]),
        ),
      ),
    );
  }
}
