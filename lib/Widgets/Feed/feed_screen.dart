// ignore_for_file: deprecated_member_use, unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:placementcracker/Widgets/Drawer/drawer.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/modals/articles.dart';
import 'package:placementcracker/modals/jobs.dart';
import 'package:placementcracker/providers/article_provider.dart';
import 'package:placementcracker/providers/job_provider.dart';
import 'package:placementcracker/services/articles_services.dart';
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

  launchURLForArticleLink(String url) async {
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

  _getJobs({bool refresh = false}) async {
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
      }
    } else {
      _showSnackbar(jobsResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsJobPageProcessing(false);
    _hideSnackbar();
  }

  /// FOr Articles.

  _getArticles({bool refresh = false}) async {
    var provider = Provider.of<ArticleProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var articlesResponse = await ArticleAPI.getArticles();
    var articleData = articlesResponse.data;
    bool? responseArticle = articlesResponse.isSuccessful;
    if (responseArticle!) {
      if (articlesResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergeArticlesList(articleData!, notify: false);
        } else {
          provider.setArticlesList(articleData!, notify: false);
        }
      }
    } else {
      _showSnackbar(articlesResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsArticlePageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getJobs();
          _getArticles();
        }
      }
    });
    _getJobs(refresh: false);
    _getArticles(refresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    General general = new General();
    return Scaffold(
      drawer: drawer(),
      key: _globalKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(children: [
                    Container(width: width, height: height / 1.65),
                    Column(
                      children: [
                        buildbottomCard(context),
                      ],
                    ),
                    buildCard(height, width, general, context),
                    buildDrawer(context),
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'Tech blogs and articles',
                          style: GoogleFonts.roboto(fontSize: 25),
                        ),
                      )),
                  buildArticleList(height, width),
                ],
              ),
            )),
      ),
    );
  }

  SizedBox buildArticleList(double height, double width) {
    return SizedBox(
      height: height / 2,
      child: Consumer<ArticleProvider>(
        builder: (_, provider, __) => provider.isArticlePageProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.articlesListLength > 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: provider.articlesListLength,
                    itemBuilder: ((context, index) {
                      Articles articles = provider.getArticleByIndex(index);
                      return InkWell(
                        onTap: () {
                          launchURLForArticleLink(articles.link.toString());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                          child: SizedBox(
                            width: width,
                            child: Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height / 3,
                                  child: Image.memory(
                                      base64Decode(articles.image.toString()),
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        articles.description.toString(),
                                        style: GoogleFonts.roboto(fontSize: 20),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
                : Center(
                    child: Text('Nothing to show here!'),
                  ),
      ),
    );
  }

  Positioned buildCard(
      double height, double width, General general, BuildContext context) {
    double acceptanceValue(int index) {
      double val = index.toDouble() / 10 + 0.1;
      if (val > 0.9) {
        val = 0.1;
        return val;
      }
      return val;
    }

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
                            width: width / 2,
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
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Consumer<JobProvider>(
                    builder: (_, provider, __) => provider.isJobPageProcessing
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.jobsListLength > 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                controller: _scrollController,
                                itemBuilder: (_, index) {
                                  Jobs jobs = provider.getJobByIndex(index);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        launchURLForJobLink(
                                            jobs.link.toString());
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 10,
                                        child: SizedBox(
                                          width: width / 2.5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Container(
                                                        width: width / 5,
                                                        height: height / 10,
                                                        child: Image.memory(
                                                          base64Decode(jobs
                                                              .image
                                                              .toString()),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: width / 3.5,
                                                          child: Text(
                                                            jobs.name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        FittedBox(
                                                          child: Container(
                                                            width: width / 6,
                                                            child: Text(
                                                              jobs.role
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Chances of\nacceptance',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 12),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        LinearPercentIndicator(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3 -
                                                              50,
                                                          animation: true,
                                                          lineHeight: 20.0,
                                                          animationDuration:
                                                              2500,
                                                          percent:
                                                              acceptanceValue(
                                                                  index),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .round,
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
                                itemCount: provider.jobsListLength,
                              )
                            : Center(
                                child: Text('Nothing to show here!'),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            _globalKey.currentState!.openDrawer();
          },
        ));
  }
}
