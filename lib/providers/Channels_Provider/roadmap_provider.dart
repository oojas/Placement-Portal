// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/YoutubeChannels/roadMaps.dart';
class RoadMapProvider extends ChangeNotifier {
  bool _isRoadMapPageProcessing = true;
  int _currentPage = 1;
  List<RoadMaps> _roadmapList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isRoadMapPageProcessing => _isRoadMapPageProcessing;

  setIsRoadMapPageProcessing(bool value) {
    _isRoadMapPageProcessing = value;
    notifyListeners();
  }

  List<RoadMaps> get roadmapList => _roadmapList;

  setroadmapList(List<RoadMaps> list, {bool notify = true}) {
    _roadmapList = list;
    if (notify) notifyListeners();
  }

  mergeroadmapList(List<RoadMaps> list, {bool notify = true}) {
    _roadmapList.addAll(list);
    if (notify) notifyListeners();
  }

  addroadmap(RoadMaps roadMaps, {bool notify = true}) {
    _roadmapList.add(roadMaps);
    if (notify) notifyListeners();
  }

  RoadMaps getroadmapByIndex(int index) => _roadmapList[index];

  int get roadmapListLength => _roadmapList.length;
}