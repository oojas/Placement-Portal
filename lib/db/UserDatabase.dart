import 'package:path/path.dart';
import 'package:placementcracker/modals/UserInfo.dart';
import 'package:sqflite/sqflite.dart';

class DetailsDatabase {
  static final DetailsDatabase instance = DetailsDatabase._init();

  static Database? _database;
  DetailsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('details.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _oncreateDB);
  }

  Future _oncreateDB(Database db, int version) async {
    // ignore: prefer_const_declarations, unused_local_variable
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // ignore: unused_local_variable, prefer_const_declarations
    final intType = 'INTEGER NOT NULL';
    // ignore: prefer_const_declarations, unused_local_variable
    final textType = 'TEXT NOT NULL';
    await db.execute('''
       CREATE TABLE $tableDetails (
        ${detailFields.id} $idType,
        ${detailFields.collegeName} $textType,
        ${detailFields.year} $intType,
        ${detailFields.language} $textType
       )
       ''');
  }

  Future<Details> create(Details details) async {
    final db = await instance.database;
    final id = await db.insert(tableDetails, details.toJson());
    return details.copy(id: id);
  }

  Future<Details> readDetails(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableDetails,
        columns: detailFields.values,
        where: '$detailFields.id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Details.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Details>> readAllDetails() async {
    final db = await instance.database;
    final result = await db.query(tableDetails);
    return result.map((json) => Details.fromJson(json)).toList();
  }

  Future<int> update(Details details) async {
    final db = await instance.database;
    return db.update(tableDetails, details.toJson(),
        where: '$detailFields.id = ?', whereArgs: [details.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableDetails,
      where: '$detailFields.id = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
