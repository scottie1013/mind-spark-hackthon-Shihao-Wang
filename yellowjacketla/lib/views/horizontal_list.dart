import 'package:flutter/material.dart';
import 'package:yellowjacketla/views/data.dart';
import 'package:yellowjacketla/views/usc_card.dart';


class HorizontalUSCList extends StatelessWidget {
  final List<Map<String, String>> articles = data().uscData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.3,// Or any desired width
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: USCCardWidget(
                date: articles[index]['date'] ?? "",
                lastUpdated: articles[index]['link'] ?? "",
                title: articles[index]['title'] ?? "",
                content: articles[index]['content'] ?? "",
              ),
            );
          },
        ),
      ),
    );
  }
}
