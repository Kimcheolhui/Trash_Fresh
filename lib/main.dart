import 'package:flutter/material.dart';
import 'package:find_trashcan/theme.dart';
import 'package:find_trashcan/screen_page/mainpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Trash Can',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: MainHome(),
    );
  }
}
