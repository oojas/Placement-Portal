// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/Authentication/pfp.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // ignore: unnecessary_new
    _animation1 = new Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ignore: unnecessary_new
  General general = new General();
  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.amber);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              return Profile();
            } else
              // ignore: curly_braces_in_flow_control_structures
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
                            FadeTransition(
                              opacity: _animation1,
                              child: Container(
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
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
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
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "It's not as hard as you think!",
                                            style: GoogleFonts.roboto(
                                                fontSize: 25,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text('Trust the process!',
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              9.5,
                                        ),
                                        // ignore: avoid_unnecessary_containers
                                        GestureDetector(
                                          onTap: () {
                                            final provider = Provider.of<
                                                    GoogleSignInProvider>(
                                                context,
                                                listen: false);
                                            provider.googleLogin();
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 45,
                                            child: Center(
                                                child: Text(
                                              'Sign in with Google',
                                              style: general.buttontextStyle,
                                            )),
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        )
                                      ],
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height: 250,
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        FadeTransition(
                          opacity: _animation1,
                          child: Image.asset(
                            'Assets/images/decoration.jpg',
                            height: 280,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
          },
        );
      },
    );
  }
}
