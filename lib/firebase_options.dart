// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyA94V3-NbCUxfCxa4rVArGf38cAm9YWkg0',
    appId: '1:10654150328:web:86f984f19ed68b7dfc0e4d',
    messagingSenderId: '10654150328',
    projectId: 'read-pdf-649e3',
    authDomain: 'read-pdf-649e3.firebaseapp.com',
    databaseURL: 'https://read-pdf-649e3-default-rtdb.firebaseio.com',
    storageBucket: 'read-pdf-649e3.appspot.com',
    measurementId: 'G-J4MBE0HK4K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMMAMIi27RwbLsjI5f9DwNAgDWLaOp9HU',
    appId: '1:10654150328:android:8ea802f3eba6fe51fc0e4d',
    messagingSenderId: '10654150328',
    projectId: 'read-pdf-649e3',
    databaseURL: 'https://read-pdf-649e3-default-rtdb.firebaseio.com',
    storageBucket: 'read-pdf-649e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSlnA28bSPwOKwga0-Y8MkV6wndQfPyiE',
    appId: '1:10654150328:ios:faa7bef2bee3042ffc0e4d',
    messagingSenderId: '10654150328',
    projectId: 'read-pdf-649e3',
    databaseURL: 'https://read-pdf-649e3-default-rtdb.firebaseio.com',
    storageBucket: 'read-pdf-649e3.appspot.com',
    iosBundleId: 'com.example.readPdf',
  );
}
