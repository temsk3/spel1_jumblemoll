import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'foundation/constants.dart';

void main() async {
  //Fimber
  if (!kReleaseMode) {
    Fimber.plantTree(DebugTree());
  } else {
    debugPrint = (message, {wrapWidget}) {} as DebugPrintCallback;
  }
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runZonedGuarded(
    () => runApp(
      ProviderScope(
        child: DevicePreview(
          enabled: !kReleaseMode && Constants.enablePreview,
          builder: (context) => MyApp(),
        ),
      ),
    ),
    (error, stackTrace) {
      Fimber.e(error.toString());
    },
  );
}
