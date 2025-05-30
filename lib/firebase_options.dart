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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyC_wjynmmQvqJbKtSJ7r5L39ymS3Mc4Ykw',
    appId: '1:785967856643:web:ba432fbf5b50b57a682236',
    messagingSenderId: '785967856643',
    projectId: 'rebio-36f88',
    authDomain: 'rebio-36f88.firebaseapp.com',
    storageBucket: 'rebio-36f88.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3u86qLljef2-LxSYMycGc3iC6-ATGiWo',
    appId: '1:785967856643:android:207bdeea0c24c4fc682236',
    messagingSenderId: '785967856643',
    projectId: 'rebio-36f88',
    storageBucket: 'rebio-36f88.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK5cYWtlUa0m8zsqT3b1csLxV-sBf_cqg',
    appId: '1:785967856643:ios:e26f5f581a8d0a13682236',
    messagingSenderId: '785967856643',
    projectId: 'rebio-36f88',
    storageBucket: 'rebio-36f88.firebasestorage.app',
    iosBundleId: 'com.example.rebio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK5cYWtlUa0m8zsqT3b1csLxV-sBf_cqg',
    appId: '1:785967856643:ios:e26f5f581a8d0a13682236',
    messagingSenderId: '785967856643',
    projectId: 'rebio-36f88',
    storageBucket: 'rebio-36f88.firebasestorage.app',
    iosBundleId: 'com.example.rebio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_wjynmmQvqJbKtSJ7r5L39ymS3Mc4Ykw',
    appId: '1:785967856643:web:413cc41628d0f183682236',
    messagingSenderId: '785967856643',
    projectId: 'rebio-36f88',
    authDomain: 'rebio-36f88.firebaseapp.com',
    storageBucket: 'rebio-36f88.firebasestorage.app',
  );

}