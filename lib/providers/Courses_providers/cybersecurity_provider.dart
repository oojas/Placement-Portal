// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/CyberSecurity.dart';
class CyberProvider extends ChangeNotifier {
  bool _isCyberPageProcessing = true;
  int _currentPage = 1;
  List<Cyber> _cyberList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isCyberPageProcessing => _isCyberPageProcessing;

  setIsCyberPageProcessing(bool value) {
    _isCyberPageProcessing = value;
    notifyListeners();
  }

  List<Cyber> get cyberList => _cyberList;

  setcyberList(List<Cyber> list, {bool notify = true}) {
    _cyberList = list;
    if (notify) notifyListeners();
  }

  mergecyberList(List<Cyber> list, {bool notify = true}) {
    _cyberList.addAll(list);
    if (notify) notifyListeners();
  }

  addCyber(Cyber cyber, {bool notify = true}) {
    _cyberList.add(cyber);
    if (notify) notifyListeners();
  }

  Cyber getCyberByIndex(int index) => _cyberList[index];

  int get cyberListLength => _cyberList.length;
}