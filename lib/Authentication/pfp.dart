// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors,prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
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
    final year = 3;
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
                  Text(
                    'Name: ' + name!,
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
                  gradient: general.backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(95),
                      bottomRight: Radius.circular(95))),
            ),
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
                                'Assets/images/resume.jpg',
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text('Year :',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            trailing: Text('3rd',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            title: Text('Year :',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            trailing: Text('3rd',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            title: Text('Year :',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            trailing: Text('3rd',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('Version Number :' + _packageInfo.version),
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage('Assets/images/sign-up_deco.jpg'))),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 1,
        right: 50,
        left: 50,
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
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )),
              )),
        ),
      )
    ])));
  }
}
