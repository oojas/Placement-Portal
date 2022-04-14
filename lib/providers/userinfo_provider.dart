// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:placementcracker/modals/user.dart';

class UserInformationProvider extends ChangeNotifier {
  List<User> list = [];
  addDetails(String collegeName, String rollNumber, int collegeYear) async {
    // ignore: unused_local_variable
    User _userInfo =
        new User(collegeName, rollNumber,collegeYear);
    list.add(_userInfo);
    notifyListeners();
  }
}
