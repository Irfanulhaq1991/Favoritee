import 'dart:io';

import 'package:http/http.dart' as _http;

abstract class Http {
  final String baseUrl = "https://dog.ceo/api/";

  Future<_http.Response> get(String endPoint) {
    return _http.get(Uri.parse(baseUrl + endPoint));
  }

  HttpException buildHttpException(int statusCode, String url) {
    return HttpException("request failed with status code $statusCode",
        uri: Uri.parse(url));
  }
}
