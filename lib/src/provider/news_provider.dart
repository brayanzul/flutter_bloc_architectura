import 'dart:convert';

import 'package:flutter_bloc_architectura/src/model/api_response.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:http/http.dart' as http;

class MissingApiKeyException implements Exception{}

class ApiKeyInvalidException implements Exception{}

class NewProvider {
  static const String _apiKey = '1abc9d39619b4d0ea4cc9877d5525e4c';
  static const String _baseUrl = 'newsapi.org';
  static const String _topHeadlines = '/v2/top-headlines';

  final http.Client _httpClient;

  NewProvider({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<List<Article>> topHeadlines(String country) async {
    final result = await _callGetAPi(
      endpoint: _topHeadlines, 
      params: {
        'country': country,
        'apikey': _apiKey,
      },
    );
    return result.articles!;
  }

  Future<ApiResponse> _callGetAPi({
    required String endpoint,
    required Map<String, String> params,
  }) async {
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }

    return result;
  }

}
