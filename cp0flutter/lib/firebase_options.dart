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
        return macos;
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
    apiKey: 'AIzaSyA0UnhXf9Ovj13vI62LBul_lwOlwzd3Go8',
    appId: '1:770491777027:web:b8abd83dbc87343fb7ce36',
    messagingSenderId: '770491777027',
    projectId: 'cp-0-fcae3',
    authDomain: 'cp-0-fcae3.firebaseapp.com',
    storageBucket: 'cp-0-fcae3.appspot.com',
    measurementId: 'G-M5XFJ3K6HJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADaEsc61GqxmB5ODn0GqWb3gZtnAOfQ7Q',
    appId: '1:770491777027:android:496592998a66379eb7ce36',
    messagingSenderId: '770491777027',
    projectId: 'cp-0-fcae3',
    storageBucket: 'cp-0-fcae3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbD6MvgbsmU-OvSXk0V6Zf9mFWZFyj5MQ',
    appId: '1:770491777027:ios:c3e9b04e9939f1cdb7ce36',
    messagingSenderId: '770491777027',
    projectId: 'cp-0-fcae3',
    storageBucket: 'cp-0-fcae3.appspot.com',
    iosBundleId: 'com.example.cp0flutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbD6MvgbsmU-OvSXk0V6Zf9mFWZFyj5MQ',
    appId: '1:770491777027:ios:553690ed1373c1bdb7ce36',
    messagingSenderId: '770491777027',
    projectId: 'cp-0-fcae3',
    storageBucket: 'cp-0-fcae3.appspot.com',
    iosBundleId: 'com.example.cp0flutter.RunnerTests',
  );
}
