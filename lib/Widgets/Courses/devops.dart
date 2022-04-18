// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/modals/Courses/devops.dart';
import 'package:placementcracker/providers/Courses_providers/devops_provider.dart';
import 'package:placementcracker/services/Courses_Services/devops_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Devops extends StatefulWidget {
  const Devops({Key? key}) : super(key: key);

  @override
  State<Devops> createState() => _DevopsState();
}

class _DevopsState extends State<Devops> {
  launchURLForCourse(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ScrollController _scrollController = ScrollController();
  _showSnackbar(String message, {required Color bgColor}) {
    _globalKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  _hideSnackbar() {
    _globalKey.currentState?.hideCurrentSnackBar();
  }

  _getDev({bool refresh = false}) async {
    var provider = Provider.of<DevProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var dataResponse = await DevAPI.getDev();
    var dataData = dataResponse.data;
    bool? responseData = dataResponse.isSuccessful;
    if (responseData!) {
      if (dataResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergedevList(dataData!, notify: false);
        } else {
          provider.setdevList(dataData!, notify: false);
        }
      }
    } else {
      _showSnackbar(dataResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsDevPageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getDev();
        }
      }
    });
    _getDev(refresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    General general = new General();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Devops',
            style: GoogleFonts.roboto(),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade300,
        ),
        body: Consumer<DevProvider>(
          builder: (_, provider, __) => provider.isDevPageProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.devListLength > 0
                  ? ListView.builder(
                      itemCount: provider.devListLength,
                      itemBuilder: ((context, index) {
                        Dev dev = provider.getDevByIndex(index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(90))),
                            elevation: 5,
                            child: Container(
                              width: width / 1.2,
                              decoration: BoxDecoration(
                                  gradient: general.backgroundColor,
                                  border:
                                      Border.all(color: Colors.indigo.shade200),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(90))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            width: width / 1.8,
                                            height: height / 5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.memory(
                                                base64Decode(
                                                    dev.coursePic.toString()),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 20),
                                          child: Container(
                                            width: width / 7,
                                            height: 60,
                                            child: Image.memory(
                                              base64Decode(
                                                  dev.thumbnail.toString()),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dev.name.toString(),
                                        style: GoogleFonts.roboto(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      elevation: 4,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            dev.description.toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 18),
                                          ),
                                        ),
                                        width: width,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              launchURLForCourse(
                                                  dev.link.toString());
                                            },
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        7),
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.indigo
                                                                .shade300)),
                                            child: Text('Go to course')),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                  : Center(
                      child: Text('Nothing to show here!'),
                    ),
        ),
      ),
    );
  }
}
