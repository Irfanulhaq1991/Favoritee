import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class DogsAPI{

  Future<void> getDogsBreeds() async{

    http.Response  response = await http.get(Uri.parse("https://dog.ceo/api/breeds/list"));
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['message'];
      print('Number of books about http: $itemCount.');
    }else{
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}