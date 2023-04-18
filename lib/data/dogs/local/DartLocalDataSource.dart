import 'dart:ui';

import 'package:favoritee/data/dogs/local/BreedDao.dart';
import 'package:favoritee/data/dogs/local/BreedLocalApi.dart';

class BreedsLocalDataSource {
  final BreedLocalApi _breedDao;

  BreedsLocalDataSource(this._breedDao);

  Future<List<BreedDbEntity>> getAllFavorites() async {
    return await _breedDao.getAll();
  }

  Future<void> saveAllFavorites(List<BreedDbEntity> breedDbEntity) async {
    return await _breedDao.insertAll(breedDbEntity);
  }

  Future<void> deleteAllFavorites(List<BreedDbEntity> breedDbEntity) async {
    return await _breedDao.deleteAll(breedDbEntity);
  }
}
