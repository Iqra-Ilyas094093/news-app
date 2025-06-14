import 'dart:convert';

import 'package:news_api/Models/articlesModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2025-01-02&sortBy=publishedAt&apiKey=22cfb8acd514439caab7e562eada6ea1';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if (data['status'] == 'ok') {
      data["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
