import 'package:flutter/material.dart';
import 'package:usbank/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:usbank/widget/reponsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        home: Responsiveness()), // Wrap your app
  );
}
