import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Example'),
        ),
        body: Center(
          child: Image.asset(
            'assets/images/image1.png',
            width: 100.0, 
            height: 100.0, 
          ),
        ),
      ),
    );
  }
}
