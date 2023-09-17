import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_carousel/infinite_carousel.dart';


class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  String apiUrl="http://eventregistry.org/api/v1/article/getArticles";
  late InfiniteScrollController controller;
  
  void getNews() async {
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
      "apiKey": "c283636a-2b6b-4d18-b6b6-56721c00a796",
      "forceMaxDataTimeWindow": 31
    };
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body
    );

    if (response.statusCode == 200) {
      setState(() {
        apiResponse = json.decode(response.body);
      });
      print(apiResponse);
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:InfiniteCarousel.builder(
        itemCount: 10,
        itemExtent: 120,
        center: true,
        anchor: 0.0,
        velocityFactor: 0.2,
        onIndexChanged: (index) {},
        controller: controller,
        axisDirection: Axis.horizontal,
        loop: true,
        itemBuilder: (context, itemIndex, realIndex) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: kElevationToShadow[2],
                ),
              ),
            );
        },
      )
    );
  }
}