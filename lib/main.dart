// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:placementcracker/Authentication/login.dart';
import 'package:placementcracker/Authentication/pfp.dart';
import 'package:placementcracker/Widgets/Drawer/drawer.dart';
import 'package:placementcracker/Widgets/Feed/feed_screen.dart';
import 'package:placementcracker/Widgets/UserInfo.dart';
import 'package:placementcracker/Widgets/about.dart';
import 'package:placementcracker/Widgets/feedback.dart';
import 'package:placementcracker/Widgets/resumeUI.dart';
import 'package:placementcracker/Widgets/splash.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:placementcracker/providers/job_provider.dart';
import 'package:placementcracker/providers/userinfo_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: unnecessary_new
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => UserInformationProvider()),
        ChangeNotifierProvider(create: (context)=>JobProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: drawer(),
      ),
    );
  }
}
