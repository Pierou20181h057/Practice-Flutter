import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  List<String> restaurants = [
    "McDonald\'s",
    "Roscoe\'s Chicken & Waffles",
    "Olive Garden",
    "Pizza Hut",
    "Panda Express",
    "Subway"
  ];
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('What do you want to eat?'),
                  if(currentIndex != -1)
                    Text(
                      restaurants[currentIndex],
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                  Padding(padding: EdgeInsets.only(top:30),),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple
                    ),

                    onPressed:(){
                      updateIndex();
                    },
                    child: Text('Pick Restaurant',
                      style: TextStyle(color: Colors.white),),

                  ),


                ],
              ))),
    );

  }


  void updateIndex(){
    currentIndex = 0;
    final random = Random();
    final index =random.nextInt(restaurants.length);
    setState(() {
      currentIndex = index;
    });
  }
}
