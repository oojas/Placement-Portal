// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/web_app.dart';

class WebProvider extends ChangeNotifier {
  bool _isWebPageProcessing = true;
  int _currentPage = 1;
  List<Web> _webList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isWebPageProcessing => _isWebPageProcessing;

  setIsWebPageProcessing(bool value) {
    _isWebPageProcessing = value;
    notifyListeners();
  }

  List<Web> get webList => _webList;

  setwebList(List<Web> list, {bool notify = true}) {
    _webList = list;
    if (notify) notifyListeners();
  }

  mergewebList(List<Web> list, {bool notify = true}) {
    _webList.addAll(list);
    if (notify) notifyListeners();
  }

  addWeb(Web web, {bool notify = true}) {
    _webList.add(web);
    if (notify) notifyListeners();
  }

  Web getwebByIndex(int index) => _webList[index];

  int get webListLength => _webList.length;
}