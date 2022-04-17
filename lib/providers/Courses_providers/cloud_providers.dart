// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/cloudcomputing.dart';

class CloudProvider extends ChangeNotifier {
  bool _isCloudPageProcessing = true;
  int _currentPage = 1;
  List<CloudComputing> _cloudList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isCloudPageProcessing => _isCloudPageProcessing;

  setIsCloudPageProcessing(bool value) {
    _isCloudPageProcessing = value;
    notifyListeners();
  }

  List<CloudComputing> get cloudList => _cloudList;

  setcloudList(List<CloudComputing> list, {bool notify = true}) {
    _cloudList = list;
    if (notify) notifyListeners();
  }

  mergecloudList(List<CloudComputing> list, {bool notify = true}) {
    _cloudList.addAll(list);
    if (notify) notifyListeners();
  }

  addCloud(CloudComputing cloud, {bool notify = true}) {
    _cloudList.add(cloud);
    if (notify) notifyListeners();
  }

  CloudComputing getCloudByIndex(int index) => _cloudList[index];

  int get cloudListLength => _cloudList.length;
}