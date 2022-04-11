// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors,prefer_const_literals_to_create_immutables, deprecated_member_use,prefer_final_fields, unused_field,

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/Authentication/pfp.dart';

import 'package:placementcracker/Widgets/Drawer/drawer.dart';
import 'package:placementcracker/Widgets/Feed/feed_screen.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/providers/userinfo_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
// ignore: camel_case_types
class userInfo extends StatefulWidget {
  const userInfo({Key? key}) : super(key: key);

  @override
  _userInfoState createState() => _userInfoState();
}

// ignore: camel_case_types
class _userInfoState extends State<userInfo>
    with  AfterLayoutMixin<userInfo>,SingleTickerProviderStateMixin{
  General general = General();
  // ignore:
  TextEditingController _collegeYear = TextEditingController();
  TextEditingController _collegeName = TextEditingController();
  TextEditingController _rollNumber = TextEditingController();
  late AnimationController _controller;
  late Animation _animation;
  FocusNode _focusNode = FocusNode();
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new FeedScreen()));
    } else {
      await prefs.setBool('seen', true);
    }
  }
  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController( duration: Duration(milliseconds: 300), vsync: this );
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
    
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(gradient: general.backgroundColor),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('Assets/images/formFill.png'))),
                ),
                Positioned(
                  bottom: 1,
                  right: 5,
                  left: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      width: 120,
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        'Fill Details',
                                        style: GoogleFonts.roboto(fontSize: 20),
                                      )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _collegeName,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  labelText: 'College Name',
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                                  focusColor: Colors.black,
                                                  labelStyle:
                                                      GoogleFonts.roboto(
                                                          color: Colors.black),
                                                  contentPadding:
                                                      EdgeInsets.all(10)),
                                              //cursorWidth: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            focusNode: _focusNode,
                                            controller: _collegeYear,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black)),
                                                focusColor: Colors.black,
                                                labelText: 'College Year',
                                                labelStyle: GoogleFonts.roboto(
                                                    color: Colors.black),
                                                contentPadding:
                                                    EdgeInsets.all(10)),
                                            //cursorWidth: 10,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _rollNumber,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black)),
                                                focusColor: Colors.black,
                                                labelText: 'Roll Number',
                                                labelStyle: GoogleFonts.roboto(
                                                    color: Colors.black),
                                                contentPadding:
                                                    EdgeInsets.all(10)),
                                            //cursorWidth: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        left: 100,
                        right: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(
                            child: Container(
                              width: 120,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                'Submit',
                                style: GoogleFonts.roboto(fontSize: 20),
                              )),
                            ),
                            minWidth: 120,
                            onPressed: () {
                              if (_collegeName.text.isEmpty &&
                                  _collegeYear.text.isEmpty &&
                                  _rollNumber.text.isEmpty) {
                                return;
                              } else {
                                Provider.of<UserInformationProvider>(context,listen: false)
                                    .addDetails(
                                        _collegeName.text,
                                        _rollNumber.text,
                                        int.parse(_collegeYear.text));
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (context) {
                                  return FeedScreen();
                                }));
                              }
                            },
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
