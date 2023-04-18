import 'BreedApi.dart';

class DogsRemoteDataSource {
  final BreedApi _api;

  DogsRemoteDataSource(this._api);

  Future<List<Breed>> get() async {
    var breedsResult = (await _api.getBreeds()).breeds;
    return await Future.wait(breedsResult.map((breedName) async {
      return Breed(
          breedName, (await _api.getBreedRandImage(breedName)).imageUrl);
    }));
  }
}

class Breed {
  final String name;
  final String imageUrl;
  var isFave = false;

  Breed(this.name, this.imageUrl);
  void setFave(bool isFave){
    this.isFave = isFave;
  }
}
