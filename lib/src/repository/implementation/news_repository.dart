import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';

class NewsRepository extends NewsRepositoryBase {

  final NewProvider _provider;

  NewsRepository(this._provider);

  @override
  Future<List<Article>> topHeadlines(String country) => _provider.topHeadlines(country);
}