import 'package:flutter/material.dart';
import 'package:yellowjacketla/views/latest_crimes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'Top Stories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body: LatestNews(),
    );
  }
}