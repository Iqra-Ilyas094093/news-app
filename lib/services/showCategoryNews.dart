import 'dart:convert';

import 'package:news_api/Models/showCategoryModel.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews{
  List<showCategoryModel> category = [];
  Future<void> getCategoryNews (String categoryName)async {
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$categoryName&apiKey=22cfb8acd514439caab7e562eada6ea1';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if(data['status'] == 'ok'){
      data['articles'].forEach((element){
        if(element['urlToImage']!=null&&element['description']!=null){
          showCategoryModel showModel = showCategoryModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            author: element['author'],
            content: element['content'],
          );
          category.add(showModel);
        }
      });
    }
  }
}