import 'package:cat_and_dog_classifier/splashscreen.dart';
import 'package:cat_and_dog_classifier/mySplashScreen.dart';
import 'package:cat_and_dog_classifier/splashscreen3.dart';
import 'package:cat_and_dog_classifier/splashscreen4.dart';
import 'package:cat_and_dog_classifier/splashscreen5.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classifier',
      home: MySplashScreen(),
      theme: new ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
    );
  }
}

