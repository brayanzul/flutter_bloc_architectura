import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architectura/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_cubit_test.mocks.dart';

@GenerateMocks([NewsRepositoryBase])
void main() {
  
  group('Cubit test', () {

    final article = Article(title: 'Text', author: 'Yayo');
    final mockRepo = MockNewsRepositoryBase();

    blocTest<NewsCubit, NewsState>(
      'News will be loaded correctly', 
      build: (){

        when(mockRepo.topHeadlines(any)).thenAnswer((_) async=> [article]);
        return NewsCubit(mockRepo);

      },
      act: (cubit) async => cubit.loadTopName(),
      expect: () => [
        NewsLoadingState(),
        NewsLoadCompletedState([article])
      ],
    );

    blocTest<NewsCubit, NewsState>(
      'ApiKey exception is handles', 
      build: (){

        when(mockRepo.topHeadlines(any)).thenAnswer((_) async => throw ApiKeyInvalidException());
        return NewsCubit(mockRepo);

      },
      act: (cubit) async => cubit.loadTopName(),
      expect: () => [
        NewsLoadingState(),
        NewsErrorState('The Api key is invalid')
      ],
    );

  });

}