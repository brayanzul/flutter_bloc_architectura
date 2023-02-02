import 'dart:io';

import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){

  test('Top headlines response is correct', () async {
    final provider = _getProvider('test/provider_test/top_headlines.json');
    final articles = await provider.topHeadlines('US');

    expect(articles.length, 2);
    expect(articles[0].author, 'Eileen Falkenberg-Hull');
    expect(articles[1].author, 'Allum Bokhari, Allum Bokhari');

  });

  test('ApiKey missing exception', () async {
    final provider = _getProvider('test/provider_test/api_key_missing.json');

    expect(provider.topHeadlines('US'), throwsA(predicate((exception) => exception is MissingApiKeyException)));
  });

  test('ApiKey invalid exception', () async {
    final provider = _getProvider('test/provider_test/api_key_invalid.json');

    expect(provider.topHeadlines('US'), throwsA(predicate((exception) => exception is ApiKeyInvalidException)));
  });

}

NewProvider _getProvider(String filePath)=> NewProvider(httpClient: _getMockProvider(filePath));
MockClient _getMockProvider(String filePath) => MockClient((_) async =>
  Response(await File(filePath).readAsString(), 200, headers: {HttpHeaders.contentTypeHeader: 'aplication/json; charset=utf-8'}));
