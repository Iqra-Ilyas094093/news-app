import 'dart:convert';
import 'package:flutter/material.dart';

import '../Models/sliderModel.dart';
import 'package:http/http.dart' as http;

class sliders{
  List<Slidermodel> slider = [];
  Future<void> getSliders ()async{
    String url = 'https://newsapi.org/v2/everything?q=tesla&from=2025-01-02&sortBy=publishedAt&apiKey=22cfb8acd514439caab7e562eada6ea1';
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if(data['status'] == 'ok'){
      data['articles'].forEach((element){
        if(element['urlToImage']!=null&&element['description']!=null){
          Slidermodel slidermodel = Slidermodel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          slider.add(slidermodel);
        }
      });
    }
  }
}