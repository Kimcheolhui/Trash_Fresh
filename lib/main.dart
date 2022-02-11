import 'package:flutter/material.dart';
import 'package:find_trashcan/theme.dart';
import 'package:find_trashcan/screen_page/login/login_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Find Trash Can',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: LoginHome(),
    );
  }
}
