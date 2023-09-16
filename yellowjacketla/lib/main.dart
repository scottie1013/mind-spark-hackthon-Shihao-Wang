import 'package:flutter/material.dart';
import 'package:yellowjacketla/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[700],
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.yellow[700]),
          displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red[700]),
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.yellow[700]),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.yellow[700],
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[800],
          titleTextStyle: TextStyle(color: Colors.yellow[700], fontSize: 22.0, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.yellow[700]),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[800]!, width: 2.0),
          ),
          hintStyle: TextStyle(color: Colors.yellow[200]),
        ),
        useMaterial3: true,
      ),
      home: Home()
    );
  }
}