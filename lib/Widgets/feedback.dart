// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/url/UrlLinks.dart';

class FeedbackApp extends StatelessWidget {
  const FeedbackApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    General general = General();
    URL url = URL();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: general.backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width,
              height: height / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('Assets/images/feedback.png'))),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: width / 1.5,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "You know what's perfect other than Rajma Chawal?",
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100))),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: width / 1.5,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "You telling us your honest suggestions so that we can be more of use to you.",
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                            bottomLeft: Radius.circular(100))),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                url.launchURLForFeedback();
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  child: Center(
                    child: Text(
                      'Submit Feedback',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                      gradient: general.buttonColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
