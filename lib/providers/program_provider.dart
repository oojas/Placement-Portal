// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:placementcracker/modals/Programs.dart';
class ProgramProvider extends ChangeNotifier {
  bool _isProgramPageProcessing = true;
  int _currentPage = 1;
  List<Program> _programList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isProgramPageProcessing => _isProgramPageProcessing;

  setIsProgramPageProcessing(bool value) {
    _isProgramPageProcessing = value;
    notifyListeners();
  }

  List<Program> get programList => _programList;

  setProgramList(List<Program> list, {bool notify = true}) {
    _programList = list;
    if (notify) notifyListeners();
  }

  mergeProgramList(List<Program> list, {bool notify = true}) {
    _programList.addAll(list);
    if (notify) notifyListeners();
  }

  addProgram(Program program, {bool notify = true}) {
    _programList.add(program);
    if (notify) notifyListeners();
  }

  Program getProgramByIndex(int index) => _programList[index];

  int get programListLength => _programList.length;
}