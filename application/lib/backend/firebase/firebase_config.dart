import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAXAUfLPGrjUY6TaHHbVNXasNNT9FNBHl0",
            authDomain: "placespotter-4ce5f.firebaseapp.com",
            projectId: "placespotter-4ce5f",
            storageBucket: "placespotter-4ce5f.firebasestorage.app",
            messagingSenderId: "799418688921",
            appId: "1:799418688921:web:7a5c3c412c77e522f51f08"));
  } else {
    await Firebase.initializeApp();
  }
}
