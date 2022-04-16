// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Courses/MachineLearning.dart';

class MachineProvider extends ChangeNotifier {
  bool _isMachinePageProcessing = true;
  int _currentPage = 1;
  List<Machine> _machineList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isMachinePageProcessing => _isMachinePageProcessing;

  setIsMachinePageProcessing(bool value) {
    _isMachinePageProcessing = value;
    notifyListeners();
  }

  List<Machine> get machineList => _machineList;

  setmachineList(List<Machine> list, {bool notify = true}) {
    _machineList = list;
    if (notify) notifyListeners();
  }

  mergemachineList(List<Machine> list, {bool notify = true}) {
    _machineList.addAll(list);
    if (notify) notifyListeners();
  }

  addMachine(Machine machine, {bool notify = true}) {
    _machineList.add(machine);
    if (notify) notifyListeners();
  }

  Machine getMachineByIndex(int index) => _machineList[index];

  int get machineListLength => _machineList.length;
}