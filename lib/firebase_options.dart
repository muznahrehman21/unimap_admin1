
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
    apiKey: 'AIzaSyAE5tb9KQ4fK6CBxm_wkvfuTvg92zf_u0w',
    appId: '1:1002784892773:web:b20dac007d20208c57638c',
    messagingSenderId: '1002784892773',
    projectId: 'unimap-a603b',
    authDomain: 'unimap-a603b.firebaseapp.com',
    storageBucket: 'unimap-a603b.appspot.com',
    measurementId: 'G-J3W6VF36PL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCz2pAh5i8NwxNBAh3UQslrCmVzjRvTl84',
    appId: '1:1002784892773:android:7523f13fc501bd8557638c',
    messagingSenderId: '1002784892773',
    projectId: 'unimap-a603b',
    storageBucket: 'unimap-a603b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDIYaYGx3Bv64nwQIfHpuWNrO4Rh_rhG8',
    appId: '1:1002784892773:ios:4f7854c8a2a1596a57638c',
    messagingSenderId: '1002784892773',
    projectId: 'unimap-a603b',
    storageBucket: 'unimap-a603b.appspot.com',
    iosBundleId: 'com.digital.unimap.admin.unimapAdmin',
  );
}
