// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/YoutubeChannels/Dsa.dart';

class DSAProvider extends ChangeNotifier {
  bool _isDSAPageProcessing = true;
  int _currentPage = 1;
  List<DSA> _dsaList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isDSAPageProcessing => _isDSAPageProcessing;

  setIsDSAPageProcessing(bool value) {
    _isDSAPageProcessing = value;
    notifyListeners();
  }

  List<DSA> get dsaList => _dsaList;

  setdsaList(List<DSA> list, {bool notify = true}) {
    _dsaList = list;
    if (notify) notifyListeners();
  }

  mergedsaList(List<DSA> list, {bool notify = true}) {
    _dsaList.addAll(list);
    if (notify) notifyListeners();
  }

  addDSA(DSA dsa, {bool notify = true}) {
    _dsaList.add(dsa);
    if (notify) notifyListeners();
  }

  DSA getDSAByIndex(int index) => _dsaList[index];

  int get dsaListLength => _dsaList.length;
}