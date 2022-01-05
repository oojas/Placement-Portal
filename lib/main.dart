// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:placementcracker/Screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: unnecessary_new
  runApp(new MaterialApp(
    home: splashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
