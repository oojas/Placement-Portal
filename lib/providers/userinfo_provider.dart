// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:placementcracker/model/userinfo.dart';

class UserInformationProvider extends ChangeNotifier {
  List<UserInformation> list = [];
  addDetails(String collegeName, String rollNumber, int collegeYear) async {
    // ignore: unused_local_variable
    UserInformation _userInfo =
        new UserInformation(collegeName, rollNumber,collegeYear);
    list.add(_userInfo);
    notifyListeners();
  }
}
