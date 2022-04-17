// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/bigdata.dart';
class DataProvider extends ChangeNotifier {
  bool _isDataPageProcessing = true;
  int _currentPage = 1;
  List<Data> _dataList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isDataPageProcessing => _isDataPageProcessing;

  setIsDataPageProcessing(bool value) {
    _isDataPageProcessing = value;
    notifyListeners();
  }

  List<Data> get dataList => _dataList;

  setdataList(List<Data> list, {bool notify = true}) {
    _dataList = list;
    if (notify) notifyListeners();
  }

  mergedataList(List<Data> list, {bool notify = true}) {
    _dataList.addAll(list);
    if (notify) notifyListeners();
  }

  addData(Data data, {bool notify = true}) {
    _dataList.add(data);
    if (notify) notifyListeners();
  }

  Data getDataByIndex(int index) => _dataList[index];

  int get dataListLength => _dataList.length;
}