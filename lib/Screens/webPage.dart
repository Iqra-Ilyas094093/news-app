import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webpage extends StatefulWidget {
  String blogUrl;
  Webpage({super.key,required this.blogUrl});

  @override
  State<Webpage> createState() => _WebpageState();
}

class _WebpageState extends State<Webpage> {
 late WebViewController controller;
var loadingPercentage = 0;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url){setState(() {
          loadingPercentage = 0;
        });},
        onProgress: (progress){setState(() {
          loadingPercentage = progress;
        });},
        onPageFinished: (url){setState(() {
          loadingPercentage = 100;
        });}
      ))
      ..loadRequest(Uri.parse(widget.blogUrl));
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
      body: Stack(
        children:[
          Container(
              child:WebViewWidget(controller: controller)
          ),
          loadingPercentage <100 ? LinearProgressIndicator(value: loadingPercentage/100,color: Colors.blue,):Container(),
        ]
      ),
    );
  }
}
