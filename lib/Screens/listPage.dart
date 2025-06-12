import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Models/articlesModel.dart';
import 'package:news_api/Models/categoryTile.dart';
import 'package:news_api/Models/sliderModel.dart';
import 'package:news_api/Screens/showCategoryNews.dart';
import 'package:news_api/Screens/webPage.dart';
import 'package:news_api/services/ArticlesData.dart';
import 'package:news_api/services/CategoryData.dart';
import 'package:news_api/services/SlidersData.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../services/SlidersData.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  List<CategoryModel> categories = [];
  List<Slidermodel> sliderss = [];
  int activeIndex = 0;
  List<ArticleModel> articles = [];
  bool _isLoading = true;

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _isLoading = false;
    });
  }
  getSliders() async {
    sliders slider = sliders();
    await slider.getSliders();
    sliderss = slider.slider;
  }

  @override
  void initState() {
    // TODO: implement initState
    getSliders();
    getNews();
    categories = getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 75,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                          name: categories[index].name.toString(),
                          image: categories[index].image.toString());
                    }),
              ),
              SizedBox(
                height: 33,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breaking News',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading?Center(child: CircularProgressIndicator()):CarouselSlider.builder(
                  itemCount: 7,
                  itemBuilder: (context, index, realIndex) {
                    return buildImage(
                        sliderss[index].urlToImage, index, sliderss[index].title,sliderss[index].url);
                  },
                  options: CarouselOptions(
                      height: 200,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      // viewportFraction: 1,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.height)),
              SizedBox(
                height: 20,
              ),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 7,
                effect: SlideEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 15,
                    dotWidth: 15),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending News',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                return Blogtile(
                    title: articles[index].title!,
                    description: articles[index].description!,
                    imageUrl: articles[index].urlToImage!,
                  url: articles[index].url!,
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(image, index, name,url) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Webpage(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5, left: 5),
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(imageUrl: image,
                  fit: BoxFit.cover, width: MediaQuery.of(context).size.width,height: 200,)),
          Container(
            height: 200,
            margin: EdgeInsets.only(
              top: 120,
            ),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class Blogtile extends StatelessWidget {
  String title, description, imageUrl,url;

  Blogtile(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Webpage(blogUrl: url)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(imageUrl:
                         imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            description,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String name;
  String image;

  CategoryTile({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>showCategoryNews(name: name.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 75,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 75,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.black26),
              child: Center(
                  child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
