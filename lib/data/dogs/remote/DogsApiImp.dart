import '../../Http.dart';
import 'BreedApi.dart';
import 'dart:convert' as convert;

class DogsApiImp extends Http implements BreedApi {
  @override
  Future<BreedRandImageResponse> getBreedRandImage(String breed) async {
    var url = "breed/$breed/images/random";
    var response = await get(url);
    if (response.statusCode != 200) {
      throw buildHttpException(response.statusCode, url);
    }
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    return BreedRandImageResponse.fromJson(jsonResponse);
  }

  @override
  Future<BreedResponse> getBreeds() async {
    var url = "breeds/list";
    var response = await get(url);
    if (response.statusCode != 200) {
      throw buildHttpException(response.statusCode, url);
    }
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    return BreedResponse.fromJson(jsonResponse);
  }
}