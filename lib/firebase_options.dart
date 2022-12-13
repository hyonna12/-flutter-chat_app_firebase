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
    apiKey: 'AIzaSyA-6GFCSVYUQEcnY6-oJmFekvW9gxTZ4Os',
    appId: '1:1096667392707:web:bbb23bf84b9a54190fd076',
    messagingSenderId: '1096667392707',
    projectId: 'chatting-a52b4',
    authDomain: 'chatting-a52b4.firebaseapp.com',
    storageBucket: 'chatting-a52b4.appspot.com',
    measurementId: 'G-X02DW42G7W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQuGQLrI-SZ3zs9t3UyxvYBLWsHhFXNKQ',
    appId: '1:1096667392707:android:538f13c2adc9673d0fd076',
    messagingSenderId: '1096667392707',
    projectId: 'chatting-a52b4',
    storageBucket: 'chatting-a52b4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyiCCfJ0urQH9IfCdVxsgBJuvUMjfin8Y',
    appId: '1:1096667392707:ios:76619291649e0af70fd076',
    messagingSenderId: '1096667392707',
    projectId: 'chatting-a52b4',
    storageBucket: 'chatting-a52b4.appspot.com',
    iosClientId: '1096667392707-89j2unq6m1bo4ea78c4i4a2eb4aiban1.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatting',
  );
}
