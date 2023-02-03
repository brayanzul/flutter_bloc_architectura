import 'package:flutter/material.dart';
import 'package:flutter_bloc_architectura/src/model/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {

  static Widget create(Object article) => 
    NewsDetailsScreen(article: article as Article);

  final Article article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News details'),
      ),
      body: Column(
        children: [
          article.urlToImage == null ? Container(
          color: Colors.red, height: 250) : Image.network(article.urlToImage!),
          const SizedBox(
            height: 9,
          ),
          Text(article.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox( 
            height: 8 
          ),
          Text(article.description ?? ''),
          const SizedBox( 
            height: 16 
          ),
          ElevatedButton(onPressed: (){
            launch(article.url!);
          }, child: const Text('More details'))
        ],
      ),
    );
  }

}