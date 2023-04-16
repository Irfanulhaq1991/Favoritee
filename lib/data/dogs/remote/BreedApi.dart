
abstract class BreedApi {
  Future<BreedResponse> getBreeds();
  Future<BreedRandImageResponse> getBreedRandImage(String breed);
}



class BreedResponse {
  final List<String> breeds;
  BreedResponse(this.breeds);

  BreedResponse.fromJson(Map<String, dynamic> json) : breeds = List<String>.from(json['message']);
}

class BreedRandImageResponse {
  final String imageUrl;
  BreedRandImageResponse(this.imageUrl);

  BreedRandImageResponse.fromJson(Map<String, dynamic> json)
      : imageUrl = json["message"];
}
