import 'package:flutter/material.dart';

Future<void> showTextDialog(BuildContext context, String message) async {
  await showDialog<void>(
    context: context,
    builder: (context) {
      final localizations = MaterialLocalizations.of(context);
      return AlertDialog(
        title: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(localizations.okButtonLabel),
          ),
        ],
      );
    },
  );
}

/// 確認用ダイアログ（bool を返す）
Future<bool> showConfirmDialog(
  BuildContext context,
  String title,
) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          final localizations = MaterialLocalizations.of(context);
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            actions: [
              TextButton(
                child: Text(localizations.cancelButtonLabel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(localizations.okButtonLabel),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      ) ??
      false;
}

/// 確認用ダイアログ（ を返す）
Future<int> showQuantityConfirmDialog(
  BuildContext context,
  int quantity,
  String title,
) async {
  // final numberOfUse = useState<int>(1);
  int numberOfUse = 1;
  return await showDialog(
    context: context,
    builder: (context) {
      final localizations = MaterialLocalizations.of(context);
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            content: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(message),
                  DropdownButton<String>(
                    items: List.generate(quantity, (index) => 1 + index)
                        .map(
                          (data) => DropdownMenuItem<String>(
                            value: data.toString(),
                            child: Text(data.toString()),
                          ),
                        )
                        .toList(),
                    value: numberOfUse.toString(),
                    onChanged: (data) => {
                      setState(() {
                        numberOfUse = int.parse(data.toString());
                      }),
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(localizations.cancelButtonLabel),
                onPressed: () {
                  Navigator.pop<int>(context, 0);
                },
              ),
              TextButton(
                child: Text(localizations.okButtonLabel),
                onPressed: () {
                  Navigator.pop<int>(context, numberOfUse);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
