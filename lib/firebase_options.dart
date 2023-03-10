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
    apiKey: 'AIzaSyBd9_2u9vy0cwLhL0B_WkJHov83bwQY0LA',
    appId: '1:236241967766:web:f96a4abebe34d601d6c0b7',
    messagingSenderId: '236241967766',
    projectId: 'todo-app-961e1',
    authDomain: 'todo-app-961e1.firebaseapp.com',
    storageBucket: 'todo-app-961e1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAucv5vAerNPAKafwMW2fah5h-vfd38NMY',
    appId: '1:236241967766:android:4ac0a4fa5f2c5929d6c0b7',
    messagingSenderId: '236241967766',
    projectId: 'todo-app-961e1',
    storageBucket: 'todo-app-961e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtna9yahMrIGNUK1RSYCRqemy7HbtA8Xw',
    appId: '1:236241967766:ios:d126bcd04d17beced6c0b7',
    messagingSenderId: '236241967766',
    projectId: 'todo-app-961e1',
    storageBucket: 'todo-app-961e1.appspot.com',
    iosClientId: '236241967766-3trgfdro9kmfqa27l5gmn2o69ml2j0ce.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtna9yahMrIGNUK1RSYCRqemy7HbtA8Xw',
    appId: '1:236241967766:ios:d126bcd04d17beced6c0b7',
    messagingSenderId: '236241967766',
    projectId: 'todo-app-961e1',
    storageBucket: 'todo-app-961e1.appspot.com',
    iosClientId: '236241967766-3trgfdro9kmfqa27l5gmn2o69ml2j0ce.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}
