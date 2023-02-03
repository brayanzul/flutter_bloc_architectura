import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:flutter_bloc_architectura/src/navigation/routes.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';
import 'package:flutter_bloc_architectura/src/ui/news_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../bloc_test/news_cubit_test.mocks.dart';

void main() {
  final article1 = Article(title: 'Tutorial 1', author: 'Zeus');
  final article2 = Article(title: 'Tutorial 2', author: 'Lucas');

  final mockRepo = MockNewsRepositoryBase();

  setUp(() {
    when(mockRepo.topHeadlines(any))
      .thenAnswer((_) async => [article1, article2]);
  });

  testWidgets('News screen loads correctly', (WidgetTester tester) async {

    await tester.pumpWidget(
      RepositoryProvider<NewsRepositoryBase>(
        create: (context) => mockRepo,
        child: MaterialApp(
          home: Builder(
            builder: (context){
              return NewsScreen.create(context);
            }
          ),
        ),
      )
    );
    await tester.pumpAndSettle();
    expect(find.text("Top news"), findsOneWidget);
    expect(find.text('Tutorial 1'), findsOneWidget);
    expect(find.text('Tutorial 2'), findsOneWidget);
  });

  testWidgets('Navigato to details correctly', (WidgetTester tester) async {

    await tester.pumpWidget(
      RepositoryProvider<NewsRepositoryBase>(
        create: (context) => mockRepo,
        child: MaterialApp(
          onGenerateRoute: (settings) => Routes.routes(settings),
        ),
      )
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tutorial 1'));
    await tester.pumpAndSettle();

    expect(find.text("News details"), findsOneWidget);
    expect(find.text('Tutorial 1'), findsOneWidget);
    expect(find.text('More details'), findsOneWidget);
  });

}