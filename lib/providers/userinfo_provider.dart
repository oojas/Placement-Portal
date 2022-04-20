// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:placementcracker/Sqflite/handler.dart';
import 'package:placementcracker/Sqflite/repo.dart';
import 'package:placementcracker/modals/user.dart';

import 'package:sqflite/sqflite.dart';

class UserInformationProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? userInfo;
  Database? _database;
  Future<Database?> openDb() async {
    _database = await DatabaseHandler().openDB();
    return _database;
  }

  Future<void> getFromUser() async {
    _database = await openDb();
    UserRepo userRepo = new UserRepo();
    userInfo = await userRepo.getUsers(_database);
    notifyListeners();
    await _database?.close();
    print('called');
    
  }
  Future<void> insertDB(String collegeName, String rollNumber, String collegeYear) async {
    _database = await openDb();
    UserRepo userRepo = new UserRepo();
    userRepo.createTable(_database);

    User user = new User(
        collegeName.toString(),
        rollNumber.toString(),
        int.tryParse(collegeYear.toString()));

    await _database?.insert('User', user.toMap());
    userInfo = await userRepo.getUsers(_database);
    await _database?.close();
   
  }
}
