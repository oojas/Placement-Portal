import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placementcracker/helper/general.dart';

class InfoAtUser extends StatefulWidget {
  const InfoAtUser({Key? key}) : super(key: key);

  @override
  State<InfoAtUser> createState() => _InfoAtUserState();
}

class _InfoAtUserState extends State<InfoAtUser> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  General general = General();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        backgroundColor: Colors.indigo.shade300,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Container(
                        width: width,
                        height: height / 3.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            shape: BoxShape.rectangle,
                            color: Colors.indigo.shade50),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(child: Text("No image selected")),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Icon(
                        Icons.photo,
                        color: Colors.indigo,
                      ))
                ]),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusColor: Colors.black,
                      labelText: 'Name',
                      labelStyle: GoogleFonts.roboto(color: Colors.black),
                      contentPadding: EdgeInsets.all(10)),
                  //cursorWidth: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusColor: Colors.black,
                      labelText: 'Email',
                      labelStyle: GoogleFonts.roboto(color: Colors.black),
                      contentPadding: EdgeInsets.all(10)),
                  //cursorWidth: 10,
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: Center(
                        child: Text(
                          'Save',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      width: width / 3,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          gradient: general.buttonColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
