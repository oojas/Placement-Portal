// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/YoutubeChannels/core_subjects.dart';

class CoreProvider extends ChangeNotifier {
  bool _isCorePageProcessing = true;
  int _currentPage = 1;
  List<Core> _coreList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isCorePageProcessing => _isCorePageProcessing;

  setIsCorePageProcessing(bool value) {
    _isCorePageProcessing = value;
    notifyListeners();
  }

  List<Core> get coreList => _coreList;

  setcoreList(List<Core> list, {bool notify = true}) {
    _coreList = list;
    if (notify) notifyListeners();
  }

  mergecoreList(List<Core> list, {bool notify = true}) {
    _coreList.addAll(list);
    if (notify) notifyListeners();
  }

  addCore(Core core, {bool notify = true}) {
    _coreList.add(core);
    if (notify) notifyListeners();
  }

  Core getCoreByIndex(int index) => _coreList[index];

  int get coreListLength => _coreList.length;
}