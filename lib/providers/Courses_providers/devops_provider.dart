// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/devops.dart';

class DevProvider extends ChangeNotifier {
  bool _isDevPageProcessing = true;
  int _currentPage = 1;
  List<Dev> _devList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isDevPageProcessing => _isDevPageProcessing;

  setIsDevPageProcessing(bool value) {
    _isDevPageProcessing = value;
    notifyListeners();
  }

  List<Dev> get devList => _devList;

  setdevList(List<Dev> list, {bool notify = true}) {
    _devList = list;
    if (notify) notifyListeners();
  }

  mergedevList(List<Dev> list, {bool notify = true}) {
    _devList.addAll(list);
    if (notify) notifyListeners();
  }

  addDev(Dev dev, {bool notify = true}) {
    _devList.add(dev);
    if (notify) notifyListeners();
  }

  Dev getDevByIndex(int index) => _devList[index];

  int get devListLength => _devList.length;
}