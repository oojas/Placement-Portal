// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/YoutubeChannels/FreeCourse.dart';
class FreeCourseProvider extends ChangeNotifier {
  bool _isCoursePageProcessing = true;
  int _currentPage = 1;
  List<FreeCourse> _courseList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isCoursePageProcessing => _isCoursePageProcessing;

  setIsCoursePageProcessing(bool value) {
    _isCoursePageProcessing = value;
    notifyListeners();
  }

  List<FreeCourse> get courseList => _courseList;

  setcourseList(List<FreeCourse> list, {bool notify = true}) {
    _courseList = list;
    if (notify) notifyListeners();
  }

  mergecourseList(List<FreeCourse> list, {bool notify = true}) {
    _courseList.addAll(list);
    if (notify) notifyListeners();
  }

  addcourse(FreeCourse course, {bool notify = true}) {
  _courseList.add(course);
    if (notify) notifyListeners();
  }

  FreeCourse getcourseByIndex(int index) => _courseList[index];

  int get courseListLength => _courseList.length;
}