// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placementcracker/url/UrlLinks.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationMainCard, _animationFollowUp;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationMainCard = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    _animationFollowUp = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    General general = General();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    URL url = URL();
    _controller.forward();
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'About',
                style: GoogleFonts.roboto(),
              ),
              backgroundColor: Colors.indigo.shade300,
            ),
            body: SafeArea(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: general.backgroundColor),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          _animationFollowUp.value * width, 0.0, 0.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: SizedBox(
                            width: width / 2,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Let's connect:)",
                                      style: GoogleFonts.hind(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              url.launchURLForInstagram();
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.pink,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              url.launchURLForWebsite();
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.link,
                                              color: Colors.blue.shade500,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              url.launchURLForLinkedin();
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.linkedin,
                                              color: Colors.blue.shade900,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('Assets/images/about.png'))),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          _animationMainCard.value * width, 0.0, 0.0),
                      child: Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: SizedBox(
                          width: width,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'I am a normal student like you, an average engineering student. My motivation for building up the app is to provide a platform for all the students to have a proper pool of tried and tested resources for building up a good resume and preparing for placements.',
                                style: GoogleFonts.hind(
                                    fontSize: 19, color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }
}
