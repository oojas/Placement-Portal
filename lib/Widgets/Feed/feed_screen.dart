// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:placementcracker/Widgets/Drawer/drawer.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/modals/jobs.dart';
import 'package:placementcracker/providers/job_provider.dart';
import 'package:placementcracker/services/jobs_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  launchURLForJobLink(String url) async {
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

  _getJobs({bool refresh = true}) async {
    var provider = Provider.of<JobProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var jobsResponse = await JobAPI.getJobs();
    var jobData = jobsResponse.data;
    bool? responseJob = jobsResponse.isSuccessful;
    if (responseJob!) {
      if (jobsResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergeJobsList(jobData!, notify: false);
        } else {
          provider.setJobsList(jobData!, notify: false);
        }
        provider.setCurrentPage(provider.currentPage + 1);
      } else {
        provider.setShouldRefresh(false);
      }
    } else {
      _showSnackbar(jobsResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsJobPageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getJobs();
        }
      }
    });
    _getJobs(refresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    General general = new General();
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Stack(children: [
                  Container(width: width, height: height / 1.65),
                  Column(
                    children: [
                      buildbottomCard(context),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 50,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          height: height / 2,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                              gradient: general.backgroundColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: width / 3,
                                      height: height / 5,
                                      child: Image.asset(
                                        'Assets/images/needJobs.png',
                                        fit: BoxFit.cover,
                                      )),
                                  Column(
                                    children: [
                                      SizedBox(
                                          child: Text(
                                              'Everyday 10% of all the\njobs in the world are created')),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      LinearPercentIndicator(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2.5 -
                                                50,
                                        animation: true,
                                        lineHeight: 20.0,
                                        animationDuration: 2500,
                                        percent: 0.1,
                                        linearStrokeCap: LinearStrokeCap.round,
                                        progressColor: Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'New Jobs/internships available',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Consumer<JobProvider>(
                                  builder: (_, provider, __) =>
                                      provider.isJobPageProcessing
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : provider.jobsListLength > 0
                                              ? ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller: _scrollController,
                                                  itemBuilder: (_, index) {
                                                    Jobs jobs = provider
                                                        .getJobByIndex(index);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          launchURLForJobLink(
                                                              jobs.link
                                                                  .toString());
                                                        },
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          elevation: 10,
                                                          child: Container(
                                                            width: width / 2.5,
                                                            height: height / 7,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            width /
                                                                                5,
                                                                        height:
                                                                            height /
                                                                                10,
                                                                        child: Image
                                                                            .memory(
                                                                          base64Decode(jobs
                                                                              .image
                                                                              .toString()),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          FittedBox(
                                                                            child:
                                                                                Text(
                                                                              jobs.name.toString(),
                                                                              style: GoogleFonts.roboto(fontSize: 22),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          FittedBox(
                                                                            child:
                                                                                Container(
                                                                              width: width / 6,
                                                                              child: Text(
                                                                                jobs.role.toString(),
                                                                                style: GoogleFonts.roboto(fontSize: 15),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                            'Chances of\nacceptance',
                                                                            style:
                                                                                GoogleFonts.roboto(fontSize: 12),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          LinearPercentIndicator(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 3 - 50,
                                                                            animation:
                                                                                true,
                                                                            lineHeight:
                                                                                20.0,
                                                                            animationDuration:
                                                                                2500,
                                                                            percent:
                                                                                index.toDouble() / 10 + 0.1,
                                                                            linearStrokeCap:
                                                                                LinearStrokeCap.round,
                                                                            progressColor:
                                                                                Colors.green,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemCount:
                                                      provider.jobsListLength,
                                                )
                                              : Center(
                                                  child: Text(
                                                      'Nothing to show here!'),
                                                ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  buildDrawer(context)
                ])
              ],
            )),
      ),
    );
  }

  Widget buildbottomCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'Discover',
            style: GoogleFonts.roboto(fontSize: 25, color: Colors.white),
          ),
        ),
        height: height / 2,
        width: width / 1.2,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.shade300.withAlpha(30).withGreen(50).withOpacity(0.6),
              Colors.pink.shade200.withGreen(30).withRed(10).withOpacity(0.7),
              Colors.indigo.shade200.withGreen(30).withOpacity(0.9)
            ], begin: Alignment.topRight, end: Alignment.bottomCenter),
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(500),
                bottomRight: Radius.circular(500))));
  }

  Widget buildCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    General general = new General();
    return Positioned(
      bottom: 10,
      left: 50,
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: height / 2,
            width: width / 1.2,
            decoration: BoxDecoration(
                gradient: general.backgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: width / 3,
                        height: height / 5,
                        child: Image.asset(
                          'Assets/images/needJobs.png',
                          fit: BoxFit.cover,
                        )),
                    Column(
                      children: [
                        SizedBox(
                            child: Text(
                                'Everyday 10% of all the\njobs in the world are created')),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width / 2.5 - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2500,
                          percent: 0.1,
                          linearStrokeCap: LinearStrokeCap.round,
                          progressColor: Colors.green,
                        ),
                      ],
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'New Jobs/internships available',
                        style: GoogleFonts.roboto(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 10,
                                child: Container(
                                  width: width / 2.5,
                                  height: height / 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: width / 4,
                                              height: height / 10,
                                              child: Image.asset(
                                                'Assets/images/needJobs.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  child: Text(
                                                    'Ojas',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 22),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    'Gupta',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Chances of\nacceptance',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                LinearPercentIndicator(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3 -
                                                      50,
                                                  animation: true,
                                                  lineHeight: 20.0,
                                                  animationDuration: 2500,
                                                  percent:
                                                      index.toDouble() / 10 +
                                                          0.1,
                                                  linearStrokeCap:
                                                      LinearStrokeCap.round,
                                                  progressColor: Colors.green,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Positioned(
        top: 50,
        bottom: 50,
        child: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ));
  }
}
