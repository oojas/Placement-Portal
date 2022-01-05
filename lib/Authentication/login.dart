// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 200.0),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.heebo(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(700),
                        ),
                        gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade300
                                  .withAlpha(30)
                                  .withGreen(50)
                                  .withOpacity(0.6),
                              Colors.pink.shade200
                                  .withGreen(30)
                                  .withRed(10)
                                  .withOpacity(0.7),
                              Colors.indigo.shade300
                                  .withGreen(30)
                                  .withOpacity(0.9)
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topRight)),
                  ),
                  Positioned(
                    bottom: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 15,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 300,
                          decoration: BoxDecoration(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Image.asset(
                'Assets/images/decoration.jpg',
                height: 280,
              )
            ],
          ),
        ),
      ),
    );
  }
}
