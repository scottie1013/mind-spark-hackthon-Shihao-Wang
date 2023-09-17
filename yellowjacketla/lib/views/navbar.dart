import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellowjacketla/views/form.dart';
import 'package:yellowjacketla/views/home_view.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int pageIndex = 0;

  final pages = [
    Home(),
    CrimePredictionForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Theme(
    data: ThemeData(
      primaryColor: Colors.yellow[700],
      iconTheme: IconThemeData(color: Color(0xFFD32F2F)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: Colors.red[700]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFFBC02D),
        titleTextStyle: TextStyle(color: Colors.red[700]),
        iconTheme: IconThemeData(color: Colors.red[700]),
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.yellow[700]!,
        secondary: Colors.red[700]!,
        onPrimary: Colors.red[700]!,
        onSecondary: Colors.yellow[700]!,
      ).copyWith(secondary: Colors.red[700]),
    ),
    child: Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    ),);
  }

  Container buildMyNavBar(BuildContext context) {        
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? Icon(
                    Icons.home,
                    size: MediaQuery.of(context).size.height / 24,
                  )
                : Icon(
                    Icons.home_outlined,
                    size: MediaQuery.of(context).size.height / 24,
                  ),
          ),
          
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? Icon(
                    Icons.fact_check_rounded,
                    size: MediaQuery.of(context).size.height / 24,
                  )
                : Icon(
                    Icons.fact_check_outlined,
                    size: MediaQuery.of(context).size.height / 24,
                  ),
          ),
        ],
      ),
    );
  }
}