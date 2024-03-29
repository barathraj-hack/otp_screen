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
    apiKey: 'AIzaSyBX6cMLgPslTdeb3eDcUUVz2QJ5Q3wWIX4',
    appId: '1:931892319405:web:38915a1c09cde6e4092224',
    messagingSenderId: '931892319405',
    projectId: 'authenticationtuto-99e9e',
    authDomain: 'authenticationtuto-99e9e.firebaseapp.com',
    storageBucket: 'authenticationtuto-99e9e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRKTAWzZNFtPTcfwad61hRC8oAJkoSp-w',
    appId: '1:931892319405:android:470d559275642618092224',
    messagingSenderId: '931892319405',
    projectId: 'authenticationtuto-99e9e',
    storageBucket: 'authenticationtuto-99e9e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9FNeNVfc8TPOy2r5FMbw_d6muNAu0zlU',
    appId: '1:931892319405:ios:a4aa1dd17523d95d092224',
    messagingSenderId: '931892319405',
    projectId: 'authenticationtuto-99e9e',
    storageBucket: 'authenticationtuto-99e9e.appspot.com',
    iosBundleId: 'com.example.otpApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9FNeNVfc8TPOy2r5FMbw_d6muNAu0zlU',
    appId: '1:931892319405:ios:e6a23202f91ada49092224',
    messagingSenderId: '931892319405',
    projectId: 'authenticationtuto-99e9e',
    storageBucket: 'authenticationtuto-99e9e.appspot.com',
    iosBundleId: 'com.example.otpApp.RunnerTests',
  );
}
