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
    apiKey: 'AIzaSyAMv5zIGVcA7fvh5Abv55IYkuAaP_n6Rac',
    appId: '1:456818678056:web:994f7c3ae8386c0214581d',
    messagingSenderId: '456818678056',
    projectId: 'buzzhub-de163',
    authDomain: 'buzzhub-de163.firebaseapp.com',
    storageBucket: 'buzzhub-de163.appspot.com',
    measurementId: 'G-ZP4MDCXHD9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAC0GNsGBq7owQxsPw4egM1c1elN3m0Y2o',
    appId: '1:456818678056:android:224bd514fface73a14581d',
    messagingSenderId: '456818678056',
    projectId: 'buzzhub-de163',
    storageBucket: 'buzzhub-de163.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxq1yqayXTfKskKoJ_Q3AekpUJhbEAC3g',
    appId: '1:456818678056:ios:a2eea2309d0df0b414581d',
    messagingSenderId: '456818678056',
    projectId: 'buzzhub-de163',
    storageBucket: 'buzzhub-de163.appspot.com',
    iosClientId: '456818678056-jb8qdja9q7n21bb9gckqr5k65730bm71.apps.googleusercontent.com',
    iosBundleId: 'com.example.buzzhub',
  );
}