import 'package:flutter/material.dart';
import 'package:flutter_bloc_architectura/src/ui/news_screen.dart';
import 'package:flutter_bloc_architectura/src/ui/news_screen_details.dart';

class Routes {
  static const topNews = '/';
  static const topNewsDetails = '/details';

  static Route routes(RouteSettings settings){

    final args = settings.arguments;

    switch (settings.name){
      case topNews:
        return MaterialPageRoute(builder: (context) => NewsScreen.create(context));
      case topNewsDetails:
        return MaterialPageRoute(builder: (context) => NewsDetailsScreen.create(args!));
    }
    throw Exception('This route does not exists');
  }

}