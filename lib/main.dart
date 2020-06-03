import 'package:delhimetro/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.black87,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
    );
  }
}
