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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCm7yDvYGnOVk1LJtRK1DKHP2LbppwLKY0',
    appId: '1:689462541957:android:82728fbf0d7dfe908e73ec',
    messagingSenderId: '689462541957',
    projectId: 'lets-connect-7a023',
    databaseURL: 'https://lets-connect-7a023-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'lets-connect-7a023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC93j6EB9B5APQEKdpQ70zOKm5iqET5Bc',
    appId: '1:689462541957:ios:f475b7f2680f08d68e73ec',
    messagingSenderId: '689462541957',
    projectId: 'lets-connect-7a023',
    databaseURL: 'https://lets-connect-7a023-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'lets-connect-7a023.appspot.com',
    iosBundleId: 'com.letsconnect.app.development',
  );
}