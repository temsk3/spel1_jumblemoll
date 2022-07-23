import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../theme/app_theme.dart';

class productDataTable extends HookConsumerWidget {
  productDataTable({Key? key, required this.data}) : super(key: key);
  final data;
  var verticalScrollController = ScrollController();
  var horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: 400,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: data.length,
      rowSeparatorWidget: const Divider(
        // color: theme.appColors.onBackground,
        height: 1.0,
        thickness: 0.0,
      ),
      // leftHandSideColBackgroundColor: theme.appColors.background,
      // rightHandSideColBackgroundColor: theme.appColors.background,
      onScrollControllerReady: (vertical, horizontal) {
        verticalScrollController = vertical;
        horizontalScrollController = horizontal;
      },
    );
  }

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

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(data[index].code.toString()),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(data[index].name.toString()),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(data[index].stock.toString()),
        ),
      ],
    );
  }
}
