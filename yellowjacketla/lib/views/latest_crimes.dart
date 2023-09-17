import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yellowjacketla/views/horizontal_list.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  String apiUrl="https://newsapi.org/v2/everything?q=crimes in Los Angeles in September 2023&apiKey=0b245cb67ac6431f91437244f7311411";

  List<dynamic> articles = [];

  void getNews() async {
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var apiResponse = json.decode(response.body);

    var filteredArticles = apiResponse["articles"].where((article) {
      return article["urlToImage"] != null && article["urlToImage"].isNotEmpty &&
             article["title"] != null && article["title"].isNotEmpty;
    }).toList();

    setState(() {
      articles = filteredArticles;
    });
    } else {
      print("Error fetching data: ${response.statusCode}");
    }
    print(articles[0]);
    print(articles[0]["title"]);
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: articles.length ==0?
      Container():
      ListView(
        children: [
          HorizontalUSCList(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.5,
              child: BannerStoryWidget(
                title: articles[2]["title"],
                imageUrl: articles[2]["urlToImage"],
                description: articles[2]["description"],
              ),
            ),
          ),
          SizedBox(height: 10), // some space between banner and grid
          // This will be your 2xN grid below the banner
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true, // This will ensure that GridView wraps its content
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7 / 2, // Aspect ratio for each grid item
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                 // Skip the banner article in grid
                return NewsStoryWidget(
                  title: articles[index]["title"],
                  imageUrl: articles[index]["urlToImage"],
                  description: articles[index]["description"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BannerStoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  BannerStoryWidget({required this.title, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container();
    }
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(imageUrl, fit: BoxFit.cover, height: 180, width: double.infinity)
 // Adjust height as needed
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Poppins'
                ),
                maxLines:5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsStoryWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  NewsStoryWidget({required this.title, required this.imageUrl, this.description = ""});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Placeholder();
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(imageUrl, fit: BoxFit.cover, height: 120, width: double.infinity)
, // Adjust height as needed
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

