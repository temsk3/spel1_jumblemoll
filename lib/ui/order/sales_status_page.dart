import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/repository/transaction/purchase/order_repository_impal.dart';
// import '../../ui/order/widget/sales_datatable.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';

class SalesStatusPage extends HookConsumerWidget {
  const SalesStatusPage({Key? key, required this.bazaar}) : super(key: key);
  final bazaar;
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('code', 100),
      _getTitleItemWidget('product', 200),
      _getTitleItemWidget('sum', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

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
    final scrollController = ScrollController();
    var verticalScrollController = ScrollController();
    var horizontalScrollController = ScrollController();
    return asyncValue.when(
      data: (order) {
        final data = order.where((data) => data.bazaarId == bazaar).toList();
        data.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
        int sum = 0;
        for (var e in data) {
          sum = (sum + e.sum!);
        }

        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: theme.appColors.primary,
          //   foregroundColor: theme.appColors.onPrimary,
          //   leading: const AutoLeadingButton(),
          //   title: Text('sum:${numFormatter.format(sum)}'),
          //   centerTitle: true,
          // ),
          body: SafeArea(
            child: Column(children: [
              Text('sum:${numFormatter.format(sum)}', style: theme.textTheme.h50
                  // .copyWith(color: theme.appColors.onPrimary),
                  ),
              // Flexible(child: salesDataTable(data: data))
            ]),
          ),
          // ),
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
