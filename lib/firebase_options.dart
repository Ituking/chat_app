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
    apiKey: 'AIzaSyBGumBBr3x4C0uecvppt_YB-2623JSCyV0',
    appId: '1:1037450979133:web:20b9e513f59d8cfe60c754',
    messagingSenderId: '1037450979133',
    projectId: 'fir-sample-app-9a228',
    authDomain: 'fir-sample-app-9a228.firebaseapp.com',
    storageBucket: 'fir-sample-app-9a228.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl_JFSA_MZ9gkGg0s6gozCOzGtf-4T87Q',
    appId: '1:1037450979133:android:9a8ad20a025b6a8760c754',
    messagingSenderId: '1037450979133',
    projectId: 'fir-sample-app-9a228',
    storageBucket: 'fir-sample-app-9a228.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3V-5CtUNYusfOxxh8LSxQF706d2XI5mE',
    appId: '1:1037450979133:ios:dc4ec5ceda84bf1360c754',
    messagingSenderId: '1037450979133',
    projectId: 'fir-sample-app-9a228',
    storageBucket: 'fir-sample-app-9a228.appspot.com',
    iosClientId: '1037450979133-2q95gvubml2gc3cgfgev9m4ll03lvk8p.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3V-5CtUNYusfOxxh8LSxQF706d2XI5mE',
    appId: '1:1037450979133:ios:dc4ec5ceda84bf1360c754',
    messagingSenderId: '1037450979133',
    projectId: 'fir-sample-app-9a228',
    storageBucket: 'fir-sample-app-9a228.appspot.com',
    iosClientId: '1037450979133-2q95gvubml2gc3cgfgev9m4ll03lvk8p.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
