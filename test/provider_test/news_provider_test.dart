import 'dart:io';

import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){

  test('Top headlines response is correct', ()async{

  });

}

NewProvider _getProvider(String filePath)=> NewProvider(httpClient: _getMockProvider(filePath));
MockClient _getMockProvider(String filePath) => MockClient((_) async =>
  Response(await File(filePath).readAsString(), 200, headers: {HttpHeaders.contentTypeHeader: 'aplication/json: charset=utf-8'}));
