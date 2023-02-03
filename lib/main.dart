import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architectura/src/navigation/routes.dart';

import 'package:flutter_bloc_architectura/src/provider/news_provider.dart';
import 'package:flutter_bloc_architectura/src/repository/implementation/news_repository.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';
//import 'package:flutter_bloc_architectura/src/ui/news_screen.dart';

void main() {
  final newProvider = NewProvider();
  final newsRepository = NewsRepository(newProvider);

  runApp(RepositoryProvider<NewsRepositoryBase>(
    create: (_) => newsRepository,
    child: const MyApp()
  ));

} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      onGenerateRoute: (settings) => Routes.routes(settings),
      //home: NewsScreen.create(context),
    );
  }
}