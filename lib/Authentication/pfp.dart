// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors,prefer_const_literals_to_create_immutables, deprecated_member_use, curly_braces_in_flow_control_structures, non_constant_identifier_names, avoid_types_as_parameter_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';

import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:placementcracker/providers/userinfo_provider.dart';

import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: override_on_non_overriding_member, unnecessary_new
  General general = new General();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photo = user?.photoURL;
    final name = user?.displayName;
    final email = user?.email;
    final height = MediaQuery.of(context).size.height;

    // ignore: prefer_const_declarations

    // ignore: unused_local_variable

    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(photo!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Name: ' + name!,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Email: ' + email!,
                    style:
                        GoogleFonts.roboto(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    height: height / 8,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.shade300
                        .withAlpha(30)
                        .withGreen(50)
                        .withOpacity(0.6),
                    Colors.pink.shade200
                        .withGreen(30)
                        .withRed(10)
                        .withOpacity(0.7),
                    Colors.indigo.shade200.withGreen(30).withOpacity(0.9)
                  ], begin: Alignment.topRight, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(95),
                      bottomRight: Radius.circular(95))),
            )
          ],
        ),
      ),
      Positioned(
        bottom: 100,
        left: 50,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 15,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 15,
                          child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Image.asset(
                                'Assets/images/resume.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 15,
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'Assets/images/courses.jpg')),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 15,
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('Assets/images/DSA.jpg')),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<UserInformationProvider>(
                          builder: (context, UserInformationProvider, _) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: UserInformationProvider.list.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    'College Name :',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: SizedBox(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          UserInformationProvider
                                              .list[index].collegeName
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Roll Number :',
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        UserInformationProvider
                                            .list[index].rollNumber
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.0, left: 15, right: 15),
                                    child: Text(
                                      'College Year :',
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    UserInformationProvider
                                        .list[index].collegeYear
                                        .toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              );
                            });
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('Version Number :' + _packageInfo.version),
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: height / 1.9,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.2,
                      image: AssetImage('Assets/images/sign-up_deco.jpg'))),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 1,
        right: 100,
        left: 100,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: RaisedButton(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.amber,
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Container(
                width: 100,
                height: 50,
                child: Center(
                    child: Text(
                  'Logout',
                  style: GoogleFonts.hind(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )),
              )),
        ),
      )
    ])));
  }
}
