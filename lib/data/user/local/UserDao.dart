import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../DatabaseHelper.dart';

class UserDao {
  static const _databaseTableName = "users_table";
  static const _idColumn = "_id";
  static const _firstNameColumn = "first_name";
  static const _lastNameColumn = "last_name";
  static const _dobColumn = "date_of_birth";
  static const _emailColumn = "email_address";
  static const _passwordColumn = "password";
  static const _imagePathColumn = "image_path";
  static const _educationColumn = "education";
  late Database _db;

  UserDao(Function initCallback) {
    _init(initCallback);
  }

  _init(Function initCallback) async {
    _db = await SQlitDatabaseHelper.instance.database;
    bool isCreated = await _isTableCreate(_db);
    if (!isCreated) {
      _onCreate(_db);
    }
    initCallback();
  }

  Future<bool> _isTableCreate(Database db) async {
    var tables = await db.rawQuery(
        'SELECT * FROM sqlite_master WHERE name="$_databaseTableName";');
    return tables.isNotEmpty;
  }

  FutureOr<void> _onCreate(Database db) async {
    await db.execute('''
          CREATE TABLE $_databaseTableName (
            $_idColumn INTEGER PRIMARY KEY,
            $_firstNameColumn TEXT NOT NULL,
            $_lastNameColumn  Text NOT NULL,
            $_dobColumn  Text NOT NULL,
            $_emailColumn  Text NOT NULL,
            $_passwordColumn  Text NOT NULL,
            $_educationColumn  Text NOT NULL,
            $_imagePathColumn Text NOT NULL,q
          )
          ''');
  }

  Future<int> saveToDb(UserDomainModel userDomainModel) async {
    Map<String, dynamic> map = {
      _idColumn: userDomainModel.id,
      _firstNameColumn: userDomainModel.firstName,
      _lastNameColumn: userDomainModel.lastName,
      _dobColumn: userDomainModel.dob,
      _emailColumn: userDomainModel.email,
      _passwordColumn: userDomainModel.password,
      _educationColumn: userDomainModel.education,
      _imagePathColumn: userDomainModel.imagePath,
    };

    return _db.insert(
      _databaseTableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserDomainModel>> getFromDb() async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await _db.query(_databaseTableName);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return UserDomainModel(
        id: maps[i][_idColumn],
        firstName: maps[i][_firstNameColumn],
        lastName: maps[i][_lastNameColumn],
        dob: maps[i][_dobColumn],
        email: maps[i][_emailColumn],
        password: maps[i][_passwordColumn],
        education: maps[i][_educationColumn],
        imagePath: maps[i][_imagePathColumn],
      );
    });
  }
}
// refactor it to entity
class UserDomainModel {
  final int id;
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String password;
  final String education;
  final String imagePath;

  const UserDomainModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.password,
    required this.education,
    required this.imagePath,
  });
}
