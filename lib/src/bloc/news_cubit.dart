import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';

import '../model/article.dart';

class NewsCubit extends Cubit<NewsState> {
  
  final NewsRepositoryBase _repository;

  NewsCubit(this._repository) : super(NewsInitialState());

  Future<void> loadTopName({String country='us'})async{
    try {
      emit(NewsLoadingState());

      final news = await _repository.topHeadlines(country);

      emit(NewsLoadCompletedState(news));
    } on Exception catch (e){
      if(e is MissingApiKeyException){
        emit(NewsErrorState('Please check the API key'));
      }else if(e is ApiKeyInvalidException){
        emit(NewsErrorState('The Api key is invalid'));
      }else{
        emit(NewsErrorState('Unknown error'));
      }
    }
  }
}

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadCompletedState extends NewsState {
  final List<Article> news;

  NewsLoadCompletedState(this.news);

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState(this.message);
  @override
  List<Object> get props => [message];
}
