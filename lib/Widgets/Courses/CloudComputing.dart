// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/modals/Courses/cloudcomputing.dart';
import 'package:placementcracker/providers/Courses_providers/cloud_providers.dart';
import 'package:placementcracker/services/Courses_Services/cloud_services.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class CloudUI extends StatefulWidget {
  const CloudUI({Key? key}) : super(key: key);

  @override
  State<CloudUI> createState() => _CloudUIState();
}

class _CloudUIState extends State<CloudUI> {
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

  _getCloud({bool refresh = false}) async {
    var provider = Provider.of<CloudProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var cloudResponse = await CloudAPI.getCloud();
    var cloudData = cloudResponse.data;
    bool? responseCloud = cloudResponse.isSuccessful;
    if (responseCloud!) {
      if (cloudResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergecloudList(cloudData!, notify: false);
        } else {
          provider.setcloudList(cloudData!, notify: false);
        }
      }
    } else {
      _showSnackbar(cloudResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsCloudPageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getCloud();
        }
      }
    });
    _getCloud(refresh: false);
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
            'Cloud Computing',
            style: GoogleFonts.roboto(),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade300,
        ),
        body: Consumer<CloudProvider>(
          builder: (_, provider, __) => provider.isCloudPageProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : provider.cloudListLength > 0
                  ? ListView.builder(
                      itemCount: provider.cloudListLength,
                      itemBuilder: ((context, index) {
                        CloudComputing cl = provider.getCloudByIndex(index);
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
                                                    cl.coursePic.toString()),
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
                                                cl.thumbnail.toString(),
                                              ),
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
                                        cl.name.toString(),
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
                                          child: ReadMoreText(
                                            cl.description.toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 18),
                                            
                                            trimMode: TrimMode.Line,
                                            trimLines: 4,
                                            trimCollapsedText: 'Read More',
                                            trimExpandedText: 'Show less',
                                            lessStyle: TextStyle(
                                              fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            moreStyle: TextStyle(
                                              fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
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
                                                  cl.link.toString());
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
