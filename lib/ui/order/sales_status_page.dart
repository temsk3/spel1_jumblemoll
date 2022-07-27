import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../data/model/transaction/purchase/order_model.dart';
import '../../data/repository/transaction/purchase/order_repository_impal.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'order_view_model.dart';
import 'widget/sales_datatable.dart';

final logger = Logger();

class SalesStatusPage extends HookConsumerWidget {
  const SalesStatusPage({Key? key, required this.bazaar}) : super(key: key);
  final bazaar;

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
        data.sort((a, b) => a.name.toString().compareTo(b.name.toString()));

        //
        var list = [];
        for (var order in data) {
          list.add(order.name);
        }
        list = list.toSet().toList();
        logger.d(list);

        var listMap = [];
        for (var n in list) {
          final groupByName =
              data.where((element) => element.name == n).toList();
          int groupBySum = 0;
          int groupByQuantity = 0;
          for (var i in groupByName) {
            groupByQuantity = groupByQuantity + i.quantity!;
            groupBySum = groupBySum + i.sum!;
          }
          final groupByMap = {
            'name': n,
            'quantity': groupByQuantity,
            'sum': groupBySum
          };
          final groupByMapEntry = [
            MapEntry('name', n),
            MapEntry('quantity', groupByQuantity),
            MapEntry('sum', groupBySum)
          ];
          listMap.add(groupByMap);
        }
        logger.d(listMap);
        // data.reduce((result, current) {
        //   const element = result.name == current.name;
        // });

        //
        // Map<String, List<Order>> groupByNameMap = _makeGroupByNameMap(data);
        // logger.d(groupByNameMap);

        //
        int sum = 0;
        for (var e in data) {
          sum = (sum + e.sum!);
        }
        // const groupBy = data.reduce((result, current) => {
        //   const element = result.find(value=>value.name===current.name);
        //   if(element){
        //     element.sum+=current.sum;
        //   }else{
        //     result.push({name:current.name,sum:current.sum})
        //   }
        //   return result;
        // }[]);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Text('sum:${numFormatter.format(sum)}',
                    style: theme.textTheme.h50
                    // .copyWith(color: theme.appColors.onPrimary),
                    ),
                // Flexible(child: salesDataTable(data: data))
                Flexible(child: salesDataTable(data: listMap))
              ],
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

//
Map<String, List<Order>> _makeGroupByNameMap(List<Order> orderModelList) {
  Map<String, List<Order>> groupByNameMap = {};

  for (Order orderModel in orderModelList) {
    //ループしてきたuserModelのnameでまだグループ化してない場合は先に空配列を代入する。
    groupByNameMap[orderModel.name!] ??= [];
    groupByNameMap[orderModel.name]!.add(orderModel);
  }
  return groupByNameMap;
}

List<MapEntry<String, List<Order>>> _makeMapEntryListPerName(
    Map<String, List<Order>> groupByNameMap) {
  List<MapEntry<String, List<Order>>> listPerAge = [];

  groupByNameMap.forEach((key, value) {
    listPerAge.add(MapEntry(key, value));
  });

  return listPerAge;
}
