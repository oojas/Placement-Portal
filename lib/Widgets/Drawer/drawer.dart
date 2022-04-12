// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/Authentication/pfp.dart';
import 'package:placementcracker/Widgets/about.dart';
import 'package:placementcracker/Widgets/feedback.dart';
import 'package:placementcracker/Widgets/resumeUI.dart';
import 'package:placementcracker/helper/general.dart';

class drawer extends StatelessWidget {
  drawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  late var photo = user?.photoURL;
  late var name = user?.displayName;
  General general = new General();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.indigo.shade200,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Profile();
                  }));
                },
                child: CircleAvatar(
                    radius: 70, backgroundImage: NetworkImage(photo!)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name!,
                    style: GoogleFonts.roboto(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: FaIcon(
                      FontAwesomeIcons.book,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Courses',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.chalkboardTeacher,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Campus ambassador programms',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return resume();
                      }));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.file,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Resume building tips',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.code,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Data structure notes',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.youtube,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Youtube channels to follow',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return About();
                      }));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.male,
                      color: Colors.black,
                    ),
                    title: Text(
                      'About',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FeedbackApp();
                      }));
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.pen,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Feedback',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
