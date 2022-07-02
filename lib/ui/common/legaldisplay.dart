import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/drawer.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_media_query.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';

class LegalDisplayPage extends HookConsumerWidget {
  const LegalDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMQ = useMediaQuery();

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            appMQ.size.width > 768 ? const CustomDrawer() : Container(),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: appMQ.size.width >= 768 ? 400 : null,
                  // child: ListView(children: const []),
                  child: DataTable(
                    columns: const [],
                    rows: const [
                      DataRow(
                        cells: [
                          DataCell(Text('販売業者の正式名称')),
                          DataCell(Text('布目悠祐')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('所在地')),
                          DataCell(Text('〒939-8136 富山県富山市月見町4丁目70')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('電話番号')),
                          DataCell(Text('０９０－２８３５－４２８８')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('メールアドレス')),
                          DataCell(Text('yusuke.spel1@gmail.com')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('運営統括責任者')),
                          DataCell(Text('布目悠祐')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('商品代金以外の必要料金')),
                          DataCell(Text('なし')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('返品・交換の方法')),
                          DataCell(Text('返品不可')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('引渡し時期')),
                          DataCell(Text('事前に登録された開催日の所定の場所にて引き渡し')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('支払い方法')),
                          DataCell(Text('クレジットカード')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('支払い時期')),
                          DataCell(Text('各カード会社引き落とし日')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('販売価格')),
                          DataCell(Text('円表記')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
