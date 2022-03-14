
// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class formData extends ChangeNotifier {
  late final int year;
  late final String collegeName;
  late final String language;

  saveNames(int year, String collegeName, String language) {
    this.year = year;
    this.collegeName = collegeName;
    this.language = language;
    notifyListeners();
  }
}
