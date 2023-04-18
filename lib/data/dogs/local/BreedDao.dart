import 'package:favoritee/data/DatabaseHelper.dart';
import 'package:favoritee/data/dogs/local/BreedLocalApi.dart';
import 'package:sqflite/sqflite.dart';

class BreedDao implements BreedLocalApi {
  static const _nameColumn = "name_";
  static const _imageUrlColumn = "imageUrl_";
  static const _favoriteColumn = "isFavorite_";
  static const _tableName = "Breed";
  late Database _db;

  BreedDao(Function initCallback) {
    _init(initCallback);
  }

  _init(Function initCallback) async {
    _db = await SQlitDatabaseHelper.instance.database;
    bool isCreated = await _isTableCreate(_db);
    if (!isCreated) {
      _create(_db);
    }
    initCallback();
  }

  Future<bool> _isTableCreate(Database db) async {
    var tables = await db
        .rawQuery('SELECT * FROM sqlite_master WHERE name="$_tableName";');
    return tables.isNotEmpty;
  }

  Future<void> _create(Database db) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            $_nameColumn TEXT PRIMARY KEY,
            $_imageUrlColumn TEXT NOT NULL,
            $_favoriteColumn BOOLEAN NOT NULL CHECK ($_favoriteColumn IN (0, 1))
            )
          ''');
  }

  @override
  Future<void> insert(BreedDbEntity dogDbEntity) async {
    Map<String, dynamic> values = {
      _nameColumn: dogDbEntity.name_,
      _imageUrlColumn: dogDbEntity.imageUrl_,
      _favoriteColumn: dogDbEntity.isFavorite_ ? 1 : 0,
    };

    await _db.insert(
      _tableName,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> insertAll(List<BreedDbEntity> dogDbEntities) async {
    await _db.transaction((txn) async {
      var bach = txn.batch();
      for (var value in dogDbEntities) {
        Map<String, dynamic> values = {
          _nameColumn: value.name_,
          _imageUrlColumn: value.imageUrl_,
          _favoriteColumn: value.isFavorite_ ? 1 : 0,
        };
        bach.insert(
          _tableName,
          values,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await bach.commit();
    });
  }

  @override
  Future<void> delete(BreedDbEntity dogDbEntity) async {
    await _db.delete(_tableName,
        where: '$_nameColumn = ?', whereArgs: [dogDbEntity.name_]);
  }

  @override
  Future<void> deleteAll(List<BreedDbEntity> dogDbEntities) async {
    await _db.transaction((txn) async {
      var bach = txn.batch();
      for (var value in dogDbEntities) {
        bach.delete(_tableName,
            where: '$_nameColumn = ?', whereArgs: [value.name_]);
      }
      await bach.commit();
    });
  }

  @override
  Future<List<BreedDbEntity>> getAll() async {
    final List<Map<String, dynamic>> result = await _db.query(_tableName);
    return List.generate(
        result.length,
        (index) => BreedDbEntity(
            result[index][_nameColumn],
            result[index][_imageUrlColumn],
            result[index][_favoriteColumn] == 0 ? false : true));
  }
}

class BreedDbEntity {
  final String name_;
  final String imageUrl_;
  late bool isFavorite_ = false;

  BreedDbEntity(this.name_, this.imageUrl_, this.isFavorite_);
}
