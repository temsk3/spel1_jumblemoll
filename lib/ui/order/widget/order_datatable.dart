import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

import '../../theme/app_theme.dart';

class orderDataTable extends HookConsumerWidget {
  orderDataTable({Key? key, required this.data}) : super(key: key);
  final data;

  var verticalScrollController = ScrollController();
  var horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: 700,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(context),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: data.length,
      rowSeparatorWidget: Divider(
        color: Theme.of(context).colorScheme.onSurface, //
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: Theme.of(context).colorScheme.surface, //
      rightHandSideColBackgroundColor: Theme.of(context).colorScheme.surface, //
      onScrollControllerReady: (vertical, horizontal) {
        verticalScrollController = vertical;
        horizontalScrollController = horizontal;
      },
    );
  }

  List<Widget> _getTitleWidget(BuildContext context) {
    return [
      _getTitleItemWidget('Name', 100, context),
      _getTitleItemWidget('Status', 100, context),
      _getTitleItemWidget('code', 100, context),
      _getTitleItemWidget('product', 200, context),
      _getTitleItemWidget('quantity', 100, context),
      _getTitleItemWidget('Purchase date', 200, context),
    ];
  }

  Widget _getTitleItemWidget(String label, double width, BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.surface), //
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.surface), //
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(data[index].userName.toString()),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final DateFormat dateFormatter =
        DateFormat.yMMMEd(Localizations.localeOf(context).toString()).add_Hm();
    return Row(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface), //
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Icon(
                  data[index].isActive == true
                      ? Icons.circle_outlined
                      : Icons.check_circle,
                  color:
                      data[index].isActive == true ? Colors.red : Colors.green),
              Text(data[index].isActive == true ? 'Not Yat' : 'Done')
            ],
          ),
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface), //
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(data[index].code.toString()),
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface), //
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(data[index].name.toString()),
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface), //
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(data[index].quantity.toString()),
        ),
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface), //
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(dateFormatter.format(data[index].createdAt as DateTime)),
        ),
      ],
    );
  }
}
