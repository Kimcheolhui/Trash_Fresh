// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:find_trashcan/screen_page/maphome.dart';
import 'package:find_trashcan/screen_page/classify/classify_main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screenList = [ClassifyTrash(), MapHome(), Text('마이페이지')];
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenList[screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '쓰레기 분류',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '길찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '마이페이지',
            )
          ],
          onTap: (value) {
            setState(() {
              screenIndex = value;
            });
          },
        ));
  }
}
