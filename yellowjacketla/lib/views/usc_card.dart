import 'package:flutter/material.dart';


class USCCardWidget extends StatelessWidget {
  final String date;
  final String lastUpdated;
  final String title;
  final String content;

  USCCardWidget({
    required this.date,
    required this.lastUpdated,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, 
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
              ),
              SizedBox(height: 4),
              Text(
                'Last Updated: $lastUpdated',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey,fontFamily: 'Poppins'),
              ),
              SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'Poppins'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6),
              Expanded(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16,fontFamily: 'Poppins'),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
