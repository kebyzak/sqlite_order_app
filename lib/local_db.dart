import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database? _db;

class LocalDatabase {
  Future get db async {
    if (_db != null) return _db;
    _db = await _initDB('local.db');
    return _db;
  }
}

Future _initDB(String filepath) async {
  final dbpath = await getDatabasesPath();
  final path = join(dbpath, filepath);
  return await openDatabase(path, version: 1, onCreate: _createDB);
}

Future _createDB(Database db, int version) async {
  await db.execute('''
  CREATE TABLE ProductGroups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
  )
  ''');

  await db.execute('''
      CREATE TABLE Products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        groupId INTEGER,
        name TEXT,
        stockAmount INTEGER,
        price REAL,
        FOREIGN KEY (groupId) REFERENCES ProductGroups (id)
      )
    ''');
}
