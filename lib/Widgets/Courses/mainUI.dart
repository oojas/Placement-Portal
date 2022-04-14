import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';

class EnteringScreenCourse extends StatelessWidget {
  const EnteringScreenCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    General general = new General();
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: general.backgroundColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 1.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Choose your desirable specialization',
                              style: GoogleFonts.roboto(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView(children: [
                            ListTile(
                              title: Text(
                                'Web/App Development',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/web.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Cyber Security',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/cyber.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Artificial Intelligence/ Machine Learning',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/ai.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Cloud Computing',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/cloud.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Big Data',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/bigdata.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text(
                                'Automation/Testing',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Image.asset(
                                'Assets/images/testing.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
