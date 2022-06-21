// AlertDialog
import 'package:flutter/material.dart';

Future<bool> customShowDialog(
    BuildContext context, String title, String message) async {
  var result = await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  return result;
}
