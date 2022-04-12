// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementcracker/helper/general.dart';
import 'package:placementcracker/modals/Programs.dart';
import 'package:placementcracker/providers/program_provider.dart';
import 'package:placementcracker/services/programs_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class campusProgram extends StatefulWidget {
  const campusProgram({Key? key}) : super(key: key);

  @override
  State<campusProgram> createState() => _campusProgramState();
}

class _campusProgramState extends State<campusProgram> {
  launchURLForProgramLink(String url) async {
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

  _getPrograms({bool refresh = false}) async {
    var provider = Provider.of<ProgramProvider>(context, listen: false);
    if (!provider.shouldRefresh) {
      _showSnackbar('That\'s it for now!', bgColor: Colors.red);
      return;
    }
    if (refresh) _showSnackbar('Loading more...', bgColor: Colors.green);

    var programResponse = await ProgramAPI.getPrograms();
    var programData = programResponse.data;
    bool? responseProgram = programResponse.isSuccessful;
    if (responseProgram!) {
      if (programResponse.data!.isNotEmpty) {
        if (refresh) {
          provider.mergeProgramList(programData!, notify: false);
        } else {
          provider.setProgramList(programData!, notify: false);
        }
      }
    } else {
      _showSnackbar(programResponse.message.toString(), bgColor: Colors.red);
    }
    provider.setIsProgramPageProcessing(false);
    _hideSnackbar();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getPrograms();
        }
      }
    });
    _getPrograms(refresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    General general = new General();
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus ambassador programs'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade300,
      ),
      body: buildCampusList(width, general, height),
    );
  }

  Consumer<ProgramProvider> buildCampusList(double width, General general, double height) {
    return Consumer<ProgramProvider>(
      builder: (_, provider, __) => provider.isProgramPageProcessing
          ? Center(
              child: CircularProgressIndicator(),
            )
          : provider.programListLength > 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.programListLength,
                  itemBuilder: ((context, index) {
                    Program program = provider.getProgramByIndex(index);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: general.backgroundColor),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 10,
                                    child: Container(
                                      width: width / 1.2,
                                      height: height / 5,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        child: Image.memory(
                                          base64Decode(
                                              program.image.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: width,
                                    child: Text(
                                      program.name.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.indigo.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          program.description.toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.indigo
                                                            .shade300)),
                                        onPressed: () {
                                          launchURLForProgramLink(
                                              program.link.toString());
                                        },
                                        child: Text('Link to apply')),
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
    );
  }
}
