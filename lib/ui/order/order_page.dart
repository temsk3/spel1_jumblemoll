import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/repository/transaction/purchase/order_repository_impal.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';
import 'widget/order_datatable.dart';

class OrderPage extends HookConsumerWidget {
  const OrderPage({Key? key, required this.bazaar}) : super(key: key);
  final String? bazaar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final state = ref.watch(orderViewModelProvider);
    final viewModel = ref.watch(orderViewModelProvider.notifier);
    final asyncValue = ref.watch(orderListStreamProvider);
    final NumberFormat numFormatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final DateFormat dateFormatter =
        DateFormat.yMMMEd(Localizations.localeOf(context).toString()).add_Hm();

    return asyncValue.when(
      data: (order) {
        final data = order.where((data) => data.bazaarId == bazaar).toList();
        data.sort((a, b) {
          int result1 =
              a.createdAt.toString().compareTo(b.createdAt.toString());
          if (result1 != 0) return result1;
          int result2 = b.quantity.toString().compareTo(a.quantity.toString());
          return result2;
        });

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: orderDataTable(data: data),
            ),
          ),
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
