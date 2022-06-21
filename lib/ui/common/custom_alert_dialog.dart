import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.contentWidget,
    this.cancelActionText,
    this.cancelAction,
    required this.defaultActionText,
    this.action,
  }) : super(key: key);

  final String title;
  final Widget contentWidget;
  final String? cancelActionText;
  final Function? cancelAction;
  final String defaultActionText;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: contentWidget,
      actions: [
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText!),
            onPressed: () {
              if (cancelAction != null) cancelAction!();
              Navigator.of(context).pop(false);
            },
          ),
        TextButton(
          child: Text(defaultActionText),
          onPressed: () {
            if (action != null) action!();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
