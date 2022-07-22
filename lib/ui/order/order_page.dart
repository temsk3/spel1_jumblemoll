import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/repository/transaction/purchase/order_repository_impal.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';
import 'widget/order_datatable.dart';
// import 'widget/order_datatable.dart';

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
          // appBar: AppBar(
          //   backgroundColor: theme.appColors.primary,
          //   foregroundColor: theme.appColors.onPrimary,
          //   title: Text(
          //     'status',
          //     style: theme.textTheme.h50,
          //   ),
          //   centerTitle: true,
          //   automaticallyImplyLeading: false,
          //   // leading: const AutoLeadingButton(),
          // ),
          // drawer: const CustomDrawer(),
          //   body: SafeArea(
          //     child: Center(
          //       child: RefreshIndicator(
          //         onRefresh: () async {
          //           // ref.refresh(bazzarViewModelProvider);
          //           viewModel.readOrder();
          //         },
          //         child: Scrollbar(
          //           controller: scrollController,
          //           child: SingleChildScrollView(
          //             controller: scrollController,
          //             scrollDirection: Axis.horizontal,
          //             child: DataTable(
          //               columns: const [
          //                 DataColumn(label: Text('name')),
          //                 DataColumn(label: Text('product')),
          //                 DataColumn(label: Text('quantity')),
          //                 DataColumn(label: Text('price')),
          //                 DataColumn(label: Text('total')),
          //                 DataColumn(label: Text('Purchase date')),
          //                 DataColumn(label: Text('status')),
          //                 DataColumn(label: Text('Date of use')),
          //               ],
          //               rows: List.generate(
          //                 data.length,
          //                 ((index) => (DataRow(
          //                       cells: [
          //                         DataCell(Text(data[index].userName.toString())),
          //                         DataCell(Text(data[index].name.toString())),
          //                         DataCell(Text(data[index].quantity.toString())),
          //                         DataCell(Text(
          //                             numFormatter.format(data[index].price))),
          //                         DataCell(Text(numFormatter.format(
          //                             (data[index].quantity! *
          //                                 data[index].price!)))),
          //                         DataCell(Text(dateFormatter.format(
          //                             data[index].createdAt as DateTime))),
          //                         data[index].isActive == true
          //                             ? const DataCell(Text('Not Yet'))
          //                             : const DataCell(Text('Done')),
          //                         data[index].updatedAt != null
          //                             ? DataCell(Text(dateFormatter.format(
          //                                 data[index].updatedAt as DateTime)))
          //                             : const DataCell(Text('')),
          //                       ],
          //                     ))),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          body: SafeArea(
            // child: Row(
            //   children: [
            // MediaQuery.of(context).size.width > 768
            //     ? const CustomDrawer()
            //     : Container(),
            // Expanded(
            // child: orderDataTable(data: data),
            // ),
            //   ],
            // ),
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
