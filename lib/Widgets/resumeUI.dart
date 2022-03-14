// ignore_for_file: camel_case_types,prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/url/UrlLinks.dart';

class resume extends StatefulWidget {
  const resume({Key? key}) : super(key: key);

  @override
  State<resume> createState() => _resumeState();
}

class _resumeState extends State<resume> {
  // ignore: unnecessary_new
  General general = new General();
  // ignore: unnecessary_new
  URL url = new URL();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(gradient: general.backgroundColor),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "How to make an outstanding resume that stands out.",
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Image.asset(
                'Assets/images/resume.png',
                height: 200,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '1. Only add useful links at the top.',
                style: GoogleFonts.roboto(fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'Assets/images/arrow.png',
                height: 170,
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'Assets/images/links.png',
                  height: 150,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '2. Try keeping resume without your\npicture.',
                style: GoogleFonts.roboto(fontSize: 22),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'Assets/images/arrow.png',
                height: 170,
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'Assets/images/cv.png',
                  height: 220,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '3. Do not leave whitespaces.',
                style: GoogleFonts.roboto(fontSize: 22),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'Assets/images/arrow.png',
                height: 170,
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'Assets/images/lineresume.png',
                  height: 220,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '4. Do not use a fancy font or design.',
                style: GoogleFonts.roboto(fontSize: 22),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'Assets/images/arrow.png',
                height: 170,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'Assets/images/mistakes.png',
                  height: 200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Other resources to follow for resume tips.",
                          style: GoogleFonts.roboto(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        InkWell(
                          onTap: () {
                            url.launchURLForThumbnail1();
                          },
                          child: Container(
                            width: width / 2.5,
                            height: height * 0.25,
                            child: Image.asset(
                              'Assets/images/thumbnail1.png',
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                            left: 50,
                            top: 50,
                            bottom: 50,
                            right: 50,
                            child: InkWell(
                              onTap: () {
                                url.launchURLForThumbnail1();
                              },
                              child: Icon(
                                Icons.play_arrow_outlined,
                                size: 100,
                                color: Colors.red,
                              ),
                            ))
                      ]),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(children: [
                        InkWell(
                          onTap: () {
                            url.launchURLForThumbnail2();
                          },
                          child: Container(
                            width: width / 2.5,
                            height: height * 0.25,
                            child: Image.asset(
                              'Assets/images/thumbnail2.png',
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                            left: 50,
                            top: 50,
                            bottom: 50,
                            right: 50,
                            child: InkWell(
                              onTap: () {
                                url.launchURLForThumbnail2();
                              },
                              child: Icon(
                                Icons.play_arrow_outlined,
                                size: 100,
                                color: Colors.red,
                              ),
                            ))
                      ]),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(children: [
                        InkWell(
                          onTap: () {
                            url.launchURLForThumbnail3();
                          },
                          child: Container(
                            width: width / 2.5,
                            height: height * 0.25,
                            child: Image.asset(
                              'Assets/images/thumbnail3.png',
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Positioned(
                            left: 50,
                            top: 50,
                            bottom: 50,
                            right: 50,
                            child: InkWell(
                              onTap: () {
                                url.launchURLForThumbnail3();
                              },
                              child: Icon(
                                Icons.play_arrow_outlined,
                                size: 100,
                                color: Colors.red,
                              ),
                            ))
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      )),
    );
  }
}
