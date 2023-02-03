import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architectura/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:flutter_bloc_architectura/src/navigation/routes.dart';
import 'package:flutter_bloc_architectura/src/repository/news_repository.dart';

class NewsScreen extends StatelessWidget{

  static Widget create(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (_) {
        final repository = context.read<NewsRepositoryBase>();
        return NewsCubit(repository)..loadTopName();
      },
      child: NewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top news'),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if(state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is NewsErrorState){
            return Text(state.message);
          }

          final news = (state as NewsLoadCompletedState).news;

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (_, int index){
              return _ListItem(article: news[index]);
            },
          );

        },
      ),
    );
  }

}

class _ListItem extends StatelessWidget {
  final Article article;

  const _ListItem({super.key, required this.article});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to next screen
        Navigator.pushNamed(context, Routes.topNewsDetails, arguments: article);
      },
      child: Card(
        child: Column(
          children: [
            article.urlToImage == null ? Container(
            color: Colors.red, height: 250) : Image.network(article.urlToImage!),
            Text(article.title, maxLines: 1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox( height: 8 ),
            Text(article.description ?? '', maxLines: 3),
            const SizedBox( height: 16 )
          ],
        ),
      ),
    );
  }



}
