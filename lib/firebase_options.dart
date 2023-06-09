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
    apiKey: 'AIzaSyDVfiWh63bBk2kLIuhZgOC1vttxfKFL3kI',
    appId: '1:1019847927838:web:58c5a6617c4f7e4c05e60f',
    messagingSenderId: '1019847927838',
    projectId: 'eazymed-eb55f',
    authDomain: 'eazymed-eb55f.firebaseapp.com',
    databaseURL: 'https://eazymed-eb55f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'eazymed-eb55f.appspot.com',
    measurementId: 'G-8H6GK709LD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBU8z7cyVuH4LpxApprsJYXmxgkGHPz08k',
    appId: '1:1019847927838:android:5ca1619b84eae53005e60f',
    messagingSenderId: '1019847927838',
    projectId: 'eazymed-eb55f',
    databaseURL: 'https://eazymed-eb55f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'eazymed-eb55f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYJj-JQVAiswwfDAUNjvxTrdgKyjuLj0Y',
    appId: '1:1019847927838:ios:5bfbe93f9c1ff1b105e60f',
    messagingSenderId: '1019847927838',
    projectId: 'eazymed-eb55f',
    databaseURL: 'https://eazymed-eb55f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'eazymed-eb55f.appspot.com',
    iosClientId: '1019847927838-f6s4v9htjbd4latnsc97u8kchs4m6e4o.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicalstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYJj-JQVAiswwfDAUNjvxTrdgKyjuLj0Y',
    appId: '1:1019847927838:ios:5bfbe93f9c1ff1b105e60f',
    messagingSenderId: '1019847927838',
    projectId: 'eazymed-eb55f',
    databaseURL: 'https://eazymed-eb55f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'eazymed-eb55f.appspot.com',
    iosClientId: '1019847927838-f6s4v9htjbd4latnsc97u8kchs4m6e4o.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicalstore',
  );
}
