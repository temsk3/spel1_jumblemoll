// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBPYG6KbIsHS5hkdIftKP5jQgFu2kcgyYs',
    appId: '1:174910327776:web:2441ac8d19986ea8c4f985',
    messagingSenderId: '174910327776',
    projectId: 'jumblemoll',
    authDomain: 'jumblemoll.firebaseapp.com',
    storageBucket: 'jumblemoll.appspot.com',
    measurementId: 'G-LVKLTVBBQT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDr-mfKcep2zZ-DDsvCp9He-83AQWxWc50',
    appId: '1:174910327776:android:48108a05e8ef13e2c4f985',
    messagingSenderId: '174910327776',
    projectId: 'jumblemoll',
    storageBucket: 'jumblemoll.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAadU-TMX1UFv6ixdaFHiS601gV-oOO890',
    appId: '1:174910327776:ios:9fa3d14ae2fd02e0c4f985',
    messagingSenderId: '174910327776',
    projectId: 'jumblemoll',
    storageBucket: 'jumblemoll.appspot.com',
    iosClientId: '174910327776-bfojcqpftt17g3epfiif2sh7oj012d2n.apps.googleusercontent.com',
    iosBundleId: 'com.example.jumblemoll',
  );
}
