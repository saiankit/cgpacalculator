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
    apiKey: 'AIzaSyDa7ObNABB-_vC6nIS2VCW4FsVVvVbK0s0',
    appId: '1:397107940686:android:d086de696743022eff621f',
    messagingSenderId: '397107940686',
    projectId: 'cgpacalculator-d9ce6',
    databaseURL: 'https://cgpacalculator-d9ce6.firebaseio.com',
    storageBucket: 'cgpacalculator-d9ce6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTCmz2It1dJUJMuN-osRfWFWqo10Bm2lU',
    appId: '1:397107940686:ios:753953532051e421ff621f',
    messagingSenderId: '397107940686',
    projectId: 'cgpacalculator-d9ce6',
    databaseURL: 'https://cgpacalculator-d9ce6.firebaseio.com',
    storageBucket: 'cgpacalculator-d9ce6.appspot.com',
    androidClientId: '397107940686-ch3sciroll9hk26knoorftka5nkjdljn.apps.googleusercontent.com',
    iosClientId: '397107940686-1l7qjg9dmfnpo2gvumv6gvbq6u6fvgm9.apps.googleusercontent.com',
    iosBundleId: 'com.saiankit.cgpacalculator',
  );
}
