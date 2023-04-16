import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQlitDatabaseHelper {
  static const _databaseName = "persons.db";
  static const _databaseVersion = 1;

  SQlitDatabaseHelper._privateConstructor();

  static final instance = SQlitDatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion);
  }
}
