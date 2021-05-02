import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class ClassifierHome extends StatefulWidget {
  @override
  _ClassifierHomeState createState() => _ClassifierHomeState();
}

class _ClassifierHomeState extends State<ClassifierHome> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {

      var output = await Tflite.runModelOnImage(
          path: image.path,
          numResults: 1000,
          threshold: 0.5,
          imageMean: 127.5,
          imageStd: 127.5);


      setState(() {
          _output = output;
          _loading = false;
      });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/mobilenet.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFF),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Classify Images',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 28),
              ),
              SizedBox(height: 80),
              Column(
                children: [
                  Container(
                    child: Center(
                      child: _loading
                          ? Container(
                              width: 200,
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.asset(
                                    'assets/objects.png',
                                 ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(_image),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _output != null
                                      ? Text(
                                          'Prediction is ${_output[0]['label']}', style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),)
                                      : Container(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 180,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(9)),
                            child: Text(
                              'Take a photo',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: pickGalleryImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 180,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(9)),
                            child: Text(
                              'Camera Roll',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
