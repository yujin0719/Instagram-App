import 'package:flutter/material.dart';
import 'package:instagram_yujin/constant/material_white_color.dart';
import 'package:instagram_yujin/main_page.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(primarySwatch: white),
    );
  }
}
