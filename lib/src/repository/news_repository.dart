import 'package:flutter_bloc_architectura/src/model/article.dart';

abstract class NewsRepositoryBase{
  Future <List<Article>> topHeadlines(String country);
}