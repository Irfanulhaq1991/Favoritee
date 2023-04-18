
import 'package:favoritee/data/dogs/local/BreedDao.dart';

abstract class BreedLocalApi{
  Future<void> insert(BreedDbEntity dogDbEntity);
  Future<void> insertAll(List<BreedDbEntity> dogDbEntities);
  Future<void> delete(BreedDbEntity dogDbEntity) ;
  Future<void> deleteAll(List<BreedDbEntity> dogDbEntities);
  Future<List<BreedDbEntity>> getAll();
}