import 'package:flutter/material.dart';


class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics in your area',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Image.asset('assets/1.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
            Image.asset('assets/2.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
            Image.asset('assets/3.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
            Image.asset('assets/4.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
            Image.asset('assets/5.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
            Image.asset('assets/6.jpeg',height: MediaQuery.of(context).size.height*0.4, width: MediaQuery.of(context).size.width*0.9,),
          ]),
        ),
      ),
    );
  }
}