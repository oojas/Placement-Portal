// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: override_on_non_overriding_member, unnecessary_new
  General general = new General();
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photo = user?.photoURL;
    final name = user?.displayName;
    final email = user?.email;
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
                  const SizedBox(
                    height: 50,
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
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.3,
                      image: AssetImage('Assets/images/decoration.jpg'))),
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 30,
          left: 150,
          // ignore: deprecated_member_use
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
                // ignore: prefer_const_constructors
                child: Center(
                    child: Text(
                  'Logout',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )),
              )))
    ])));
  }
}
