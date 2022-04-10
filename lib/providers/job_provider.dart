import 'package:flutter/material.dart';
import 'package:placementcracker/modals/jobs.dart';
class JobProvider extends ChangeNotifier {
  bool _isJobPageProcessing = true;
  int _currentPage = 1;
  List<Jobs> _jobsList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isJobPageProcessing => _isJobPageProcessing;

  setIsJobPageProcessing(bool value) {
    _isJobPageProcessing = value;
    notifyListeners();
  }

  List<Jobs> get jobsList => _jobsList;

  setJobsList(List<Jobs> list, {bool notify = true}) {
    _jobsList = list;
    if (notify) notifyListeners();
  }

  mergeJobsList(List<Jobs> list, {bool notify = true}) {
    _jobsList.addAll(list);
    if (notify) notifyListeners();
  }

  addJob(Jobs jobs, {bool notify = true}) {
    _jobsList.add(jobs);
    if (notify) notifyListeners();
  }

  Jobs getJobByIndex(int index) => _jobsList[index];

  int get jobsListLength => _jobsList.length;
}