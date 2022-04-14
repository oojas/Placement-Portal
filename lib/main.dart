// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:placementcracker/Authentication/login.dart';
import 'package:placementcracker/Widgets/Feed/feed_screen.dart';
import 'package:placementcracker/Widgets/UserInfo.dart';
import 'package:placementcracker/Widgets/ambassadorProgram.dart';
import 'package:placementcracker/Widgets/splash.dart';
import 'package:placementcracker/Widgets/youtubeChannels.dart';
import 'package:placementcracker/providers/Channels_Provider/core_subjects_provider.dart';
import 'package:placementcracker/providers/Channels_Provider/freecourse_provider.dart';
import 'package:placementcracker/providers/Channels_Provider/roadmap_provider.dart';
import 'package:placementcracker/providers/article_provider.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:placementcracker/providers/job_provider.dart';
import 'package:placementcracker/providers/program_provider.dart';
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
        ChangeNotifierProvider(create: (context) => JobProvider()),
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        ChangeNotifierProvider(create: ((context) => ProgramProvider())),
        ChangeNotifierProvider(create: (context)=>FreeCourseProvider()),
        ChangeNotifierProvider(create: (context)=>RoadMapProvider()),
        ChangeNotifierProvider(create: (context)=>CoreProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:splashScreen(),
      ),
    );
  }
}
