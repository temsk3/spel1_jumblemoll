import 'dart:async';

// import 'package:fimber/fimber.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'firebase_options.dart';

final logger = Logger();

// Future<void> main() async {
void main() async {
  // await dotenv.load(fileName: ".env");
  const isEmulator = bool.fromEnvironment('IS_EMULATOR');
  logger.d('start(isEmulator: $isEmulator)');
  //Fimber
  // if (!kReleaseMode) {
  //   Fimber.plantTree(DebugTree());
  // } else {
  //   debugPrint = (message, {wrapWidget}) {} as DebugPrintCallback;
  // }

  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (isEmulator) {
    const localhost = 'localhost';
    FirebaseFunctions.instance.useFunctionsEmulator(localhost, 5001);
    FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8081);
    await Future.wait(
      [
        FirebaseAuth.instance.useAuthEmulator(localhost, 9099),
        FirebaseStorage.instance.useStorageEmulator(localhost, 9199),
      ],
    );
  } else if (kIsWeb) {
    await FirebaseFirestore.instance.enablePersistence(
      const PersistenceSettings(synchronizeTabs: true),
    );
  }

  runZonedGuarded(
    () => runApp(
      ProviderScope(
        // child: DevicePreview(
        //   enabled: !kReleaseMode && Constants.enablePreview,
        // builder: (context) => MyApp(),
        // ),
        child: MyApp(),
      ),
    ),
    (error, stackTrace) {
      // Fimber.e(error.toString());
      logger.e(error);
      logger.e(stackTrace);
    },
  );
}
