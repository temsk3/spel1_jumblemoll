import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ErrorScreen extends StatelessWidget {
  final Object e;
  final StackTrace? trace;
  const ErrorScreen(
    this.e,
    this.trace, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.e(e);
    logger.e(trace);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(e.toString()),
          Text(trace.toString()),
        ],
      ),
    );
  }
}
