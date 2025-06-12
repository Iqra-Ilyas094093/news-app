import 'package:flutter/material.dart';
import 'package:news_api/Models/showCategoryModel.dart';
import 'package:news_api/Screens/webPage.dart';

import '../services/showCategoryNews.dart';

class showCategoryNews extends StatefulWidget {
  String name;
  showCategoryNews({super.key,required this.name});

  @override
  State<showCategoryNews> createState() => _showCategoryNewsState();
}

class _showCategoryNewsState extends State<showCategoryNews> {
  @override
  Widget build(BuildContext context) {
    List<showCategoryModel> categories = [];
    bool _isLoading = true;

    getData()async{
      ShowCategoryNews showNews = ShowCategoryNews();
      await showNews.getCategoryNews(widget.name.toLowerCase());
      categories = showNews.category;
      setState(() {
        _isLoading = false;
      });
    }

    @override
    void initState() {
      // TODO: implement initState
      getData();
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Flutter',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'News',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: _isLoading?Center(child: CircularProgressIndicator()):Container(
        child: Column(
          children: [
            ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Showcategorytile(
                    title: categories[index].title!,
                    description: categories[index].description!,
                    url: categories[index].url!,
                    image: categories[index].urlToImage!,
                  );
                })
          ],
        ),
      ),
    );
  }
}

class Showcategorytile extends StatelessWidget {
  String image;
  String title;
  String description;
  String url;
  Showcategorytile({super.key,required this.image,required this.title,required this.url,required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Webpage(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            Image.network(image,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
            Text(title),
            Text(description),
          ],
        ),
      ),
    );
  }
}

