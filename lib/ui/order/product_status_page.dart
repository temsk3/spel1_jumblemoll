import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/repository/product/product_repository_impal.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';
import 'widget/product_datatable.dart';
// import 'widget/product_datatable.dart';

class ProductStatusPage extends HookConsumerWidget {
  const ProductStatusPage({Key? key, required this.bazaar}) : super(key: key);
  final bazaar;

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('code', 100),
      _getTitleItemWidget('name', 200),
      _getTitleItemWidget('stock', 100),
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
    final asyncValue = ref.watch(productListStreamProvider);
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
        // Widget _generateFirstColumnRow(BuildContext context, int index) {
        //   return Container(
        //     width: 100,
        //     height: 52,
        //     padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //     alignment: Alignment.centerLeft,
        //     child: Text(data[index].code.toString()),
        //   );
        // }

        // Widget _generateRightHandSideColumnRow(
        //     BuildContext context, int index) {
        //   return Row(
        //     children: <Widget>[
        //       // Container(
        //       //   width: 100,
        //       //   height: 52,
        //       //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //       //   alignment: Alignment.centerLeft,
        //       //   child: Row(
        //       //     children: <Widget>[
        //       //       Icon(
        //       //           data[index].isActive == true
        //       //               ? Icons.circle_outlined
        //       //               : Icons.check_circle,
        //       //           color: data[index].isActive == true
        //       //               ? Colors.red
        //       //               : Colors.green),
        //       //       Text(data[index].isActive == true ? 'Not Yat' : 'Done')
        //       //     ],
        //       //   ),
        //       // ),
        //       Container(
        //         width: 200,
        //         height: 52,
        //         padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //         alignment: Alignment.centerLeft,
        //         child: Text(data[index].name.toString()),
        //       ),
        //       Container(
        //         width: 100,
        //         height: 52,
        //         padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //         alignment: Alignment.centerLeft,
        //         child: Text(data[index].stock.toString()),
        //       ),
        //     ],
        //   );
        // }

        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: theme.appColors.primary,
          //   foregroundColor: theme.appColors.onPrimary,
          //   leading: const AutoLeadingButton(),
          //   title: Text(
          //     'Sales status',
          //     style: theme.textTheme.h50,
          //   ),
          //   centerTitle: true,
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
            child: Center(
              child: productDataTable(data: data),
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
