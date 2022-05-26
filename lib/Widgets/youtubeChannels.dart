// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';

import 'package:placementcracker/modals/YoutubeChannels/FreeCourse.dart';
import 'package:placementcracker/modals/YoutubeChannels/core_subjects.dart';
import 'package:placementcracker/modals/YoutubeChannels/roadMaps.dart';

import 'package:placementcracker/providers/Channels_Provider/core_subjects_provider.dart';
import 'package:placementcracker/providers/Channels_Provider/freecourse_provider.dart';
import 'package:placementcracker/providers/Channels_Provider/roadmap_provider.dart';
import 'package:placementcracker/services/Channels_services.dart/core_subjects_services.dart';

import 'package:placementcracker/services/Channels_services.dart/freecourse_services.dart';
import 'package:placementcracker/services/Channels_services.dart/roadmaps_services.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeChannels extends StatefulWidget {
  const YoutubeChannels({Key? key}) : super(key: key);

  @override
  State<YoutubeChannels> createState() => _YoutubeChannelsState();
}

class _YoutubeChannelsState extends State<YoutubeChannels> {
  launchURLForChannelLink(String url) async {
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

  // For Raod Maps
  _getRoadMap({bool refresh = false}) async {
    var provider = Provider.of<RoadMapProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var roadmapResponse = await RoadMapAPI.getRoadMap();
    var roadmapData = roadmapResponse.data;
    bool? responseroadmap = roadmapResponse.isSuccessful;
    if (responseroadmap!) {
      if (roadmapResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergeroadmapList(roadmapData!, notify: false);
        } else {
          provider.setroadmapList(roadmapData!, notify: false);
        }
      }
    } else {
      _showSnackbar(roadmapResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsRoadMapPageProcessing(false);
    _hideSnackbar();
  }

  //For Free Course
  _getCourse({bool refresh = false}) async {
    var provider = Provider.of<FreeCourseProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var courseResponse = await FreeCourseAPI.getCourse();
    var courseData = courseResponse.data;
    bool? responsecourse = courseResponse.isSuccessful;
    if (responsecourse!) {
      if (courseResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergecourseList(courseData!, notify: false);
        } else {
          provider.setcourseList(courseData!, notify: false);
        }
      }
    } else {
      _showSnackbar(courseResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsCoursePageProcessing(false);
    _hideSnackbar();
  }

  // For Engineering subjects
  _getCoreSubjects({bool refresh = false}) async {
    var provider = Provider.of<CoreProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var coreResponse = await CoreAPI.getCore();
    var coreData = coreResponse.data;
    bool? responsecore = coreResponse.isSuccessful;
    if (responsecore!) {
      if (coreResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergecoreList(coreData!, notify: false);
        } else {
          provider.setcoreList(coreData!, notify: false);
        }
      }
    } else {
      _showSnackbar(coreResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsCorePageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getRoadMap();
          _getCourse();
          _getCoreSubjects();
        }
      }
    });

    _getRoadMap(refresh: false);
    _getCourse(refresh: false);
    _getCoreSubjects(refresh: false);
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
          title: Text('Recommended youtube channels'),
          backgroundColor: Colors.indigo.shade300,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Free Courses',
                      style:
                          GoogleFonts.roboto(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                courseCard(height, width, general),
                
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Roadmaps',
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                roadmapCard(height, width, general),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Engineering Subjects',
                      style:
                          GoogleFonts.roboto(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                coreSubjectCard(height, width, general)
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox roadmapCard(double height, double width, General general) {
    return SizedBox(
      height: height / 1.7,
      child: Consumer<RoadMapProvider>(
        builder: (_, provider, __) => provider.isRoadMapPageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.roadmapListLength > 0
                ? ListView.builder(
                    itemCount: provider.roadmapListLength,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      RoadMaps roadMaps = provider.getroadmapByIndex(index);
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 7,
                        child: Container(
                          width: width / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: general.backgroundColor),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: Container(
                                        width: width / 1.5,
                                        height: height / 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(
                                                roadMaps.image.toString()),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        roadMaps.name.toString(),
                                        style: GoogleFonts.roboto(fontSize: 18),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.indigo.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ReadMoreText(
                                          roadMaps.description.toString(),
                                          style: GoogleFonts.roboto(
                                              wordSpacing: 2,
                                              fontSize: 18,
                                              color: Colors.black),
                                          textAlign: TextAlign.justify,
                                          trimMode: TrimMode.Line,
                                          trimLines: 4,
                                          trimCollapsedText: 'Read More',
                                          trimExpandedText: 'Show less',
                                          lessStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          moreStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(10),
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(30, 40)),
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.red)),
                                        onPressed: () {
                                          launchURLForChannelLink(
                                              roadMaps.link.toString());
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text('Nothing to show here!'),
                  ),
      ),
    );
  }

  SizedBox coreSubjectCard(double height, double width, General general) {
    return SizedBox(
      height: height / 1.7,
      child: Consumer<CoreProvider>(
        builder: (_, provider, __) => provider.isCorePageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.coreListLength > 0
                ? ListView.builder(
                    itemCount: provider.coreListLength,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Core core = provider.getCoreByIndex(index);
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 7,
                        child: Container(
                          width: width / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: general.backgroundColor),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: Container(
                                        width: width / 1.5,
                                        height: height / 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(core.image.toString()),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        core.name.toString(),
                                        style: GoogleFonts.roboto(fontSize: 18),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.indigo.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ReadMoreText(
                                          core.description.toString(),
                                          style: GoogleFonts.roboto(
                                              wordSpacing: 2,
                                              fontSize: 18,
                                              color: Colors.black),
                                          textAlign: TextAlign.justify,
                                          trimMode: TrimMode.Line,
                                          trimLines: 4,
                                          trimCollapsedText: 'Read More',
                                          trimExpandedText: 'Show less',
                                          lessStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          moreStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(10),
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(30, 40)),
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.red)),
                                        onPressed: () {
                                          launchURLForChannelLink(
                                              core.link.toString());
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text('Nothing to show here!'),
                  ),
      ),
    );
  }

  SizedBox courseCard(double height, double width, General general) {
    return SizedBox(
      height: height / 1.7,
      child: Consumer<FreeCourseProvider>(
        builder: (_, provider, __) => provider.isCoursePageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.courseListLength > 0
                ? ListView.builder(
                    itemCount: provider.courseListLength,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      FreeCourse course = provider.getcourseByIndex(index);
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 7,
                        child: Container(
                          width: width / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: general.backgroundColor),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: Container(
                                        width: width / 1.5,
                                        height: height / 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(
                                                course.image.toString()),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        course.name.toString(),
                                        style: GoogleFonts.roboto(fontSize: 18),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.indigo.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ReadMoreText(
                                          course.description.toString(),
                                          style: GoogleFonts.roboto(
                                              wordSpacing: 0,
                                              fontSize: 18,
                                              color: Colors.black),
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
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(10),
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(30, 40)),
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.red)),
                                        onPressed: () {
                                          launchURLForChannelLink(
                                              course.link.toString());
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.youtube,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text('Nothing to show here!'),
                  ),
      ),
    );
  }
}
