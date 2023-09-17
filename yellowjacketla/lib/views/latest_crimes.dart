import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:infinite_carousel/infinite_carousel.dart';


class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  String apiUrl="http://eventregistry.org/api/v1/article/getArticles";
  late InfiniteScrollController controller;
  List<dynamic> articles = [];
  int selectedIndex = 0;
  
  void getNews() async {
    print("fnfn");
    var apiResponse= {};
    var body =  {
      "action": "getArticles",
      "keyword": "Crime in Los Angeles",
      "articlesPage": 1,
      "articlesCount": 10,
      "articlesSortBy": "date",
      "articlesSortByAsc": false,
      "articlesArticleBodyLen": -1,
      "resultType": "articles",
      "dataType": ["news", "pr", "blog"],
      "isDuplicateFilter":"skipDuplicates",
      "apiKey": "e5b2ec7f-92ce-40c4-a785-2d1571ec3e54",
      "forceMaxDataTimeWindow": 31
    };
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body)
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      var apiResponse = json.decode(response.body);
      print(apiResponse);
      setState(() {
        articles = apiResponse["articles"]["results"];
      });
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController(initialItem: selectedIndex);    
    getNews();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.4,
          child: InfiniteCarousel.builder(
            itemCount: articles.length,
            itemExtent: MediaQuery.of(context).size.width -100,
            center: true,
            onIndexChanged: (index) {
              if (selectedIndex != index) {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
             scrollBehavior: kIsWeb
                    ? ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          // Allows to swipe in web browsers
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse
                        },
                      )
                    : null,
            anchor: 0.0,
            velocityFactor: 0.85,
            controller: controller,
            axisDirection: Axis.horizontal,
            loop: true,
              itemBuilder: (context, itemIndex, realIndex) {
                var article = articles[itemIndex];
                
                return SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                  child: Card( // Use the Card widget here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 4.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Check if image is not null or empty before attempting to load it
                        if (article["image"] != null && article["image"] != "")
                          Image.network(article["image"], fit: BoxFit.cover),
              
                        SizedBox(height: 10),
              
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: Text(
                            article["title"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis, // Add this to ensure long titles don't break layout
                          ),
                        ),
              
                        SizedBox(height: 5),
              
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article["body"],
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ));
              }
          ),
        ),
      )
    );
  }
}