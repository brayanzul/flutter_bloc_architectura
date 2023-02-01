import 'dart:convert';

import 'package:flutter_bloc_architectura/src/model/api_response.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:http/http.dart' as http;

class MissingApiKeyException implements Exception{}

class ApiKeyInvalidException implements Exception{}

class NewProvider {
  static const String _apiKey = 'xxxxxx';
  static const String _baseUrl = 'newsapi.org';
  static const String _topHeadlines = 'v2/everything';

  final http.Client _httpClient;

  NewProvider({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<List<Article>> topHeadlines(String country) async {
    final result = await _callGetAPI(
      endpoint: _topHeadlines, 
      params: {
        'country': country,
        'apikey': _apiKey,
      },
    );
    return result.articles!;
  }

  Future<ApiResponse> _callGetAPI({
    required String endpoint,
    required Map<String, String> params,
  }) async {
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if(result.status == 'error') {
      if(result.code == 'apikeyMissing') throw MissingApiKeyException();
      if(result.code == 'apikeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }
    return result;
  }

}
