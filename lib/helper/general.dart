//this class is basically the repository of the variables that are declared for gloabal use
// throughout the app,

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class General {
  final buttontextStyle = GoogleFonts.roboto(
      fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold);
  final backgroundColor = LinearGradient(colors: [
    Colors.blue.shade300.withAlpha(30).withGreen(50).withOpacity(0.6),
    Colors.pink.shade200.withGreen(30).withRed(10).withOpacity(0.7),
    Colors.indigo.shade300.withGreen(30).withOpacity(0.9)
  ], begin: Alignment.bottomRight, end: Alignment.topRight);
}
