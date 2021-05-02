import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cat_and_dog_classifier/classifierHome.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: ClassifierHome(),
      title: Text(
        'Image Classifier',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.black,
        ),
      ),
      image: Image.asset(
       'assets/objects.png',
      ),
      backgroundColor: Color(0xF5F8FD),
      /*gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          end: AlignmentDirectional.bottomCenter,
          stops: [0.004, 1],
          colors: [Color(0xFFFFFF), Color(0xF5F8FD)])*/
      photoSize: 50,
      loaderColor: Colors.black,
    );
  }
}
