// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:find_trashcan/screen_page/login/login.dart';

class LoginHome extends StatelessWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff4B9B77),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Trash Fresh',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }
}


// StreamBuilder(
//                 stream: FirebaseAuth.instance.authStateChanges(),
//                 builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Login();
//                   } else {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => MapHome()));
//                     return MapHome();
                   
//                     // return Center(
//                     //   child: Column(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [
//                     //       Text("${snapshot.data!.displayName}님 반갑습니다."),
//                     //       TextButton(
//                     //         child: Text("로그아웃"),
//                     //         onPressed: () {
//                     //           FirebaseAuth.instance.signOut();
//                     //         },
//                     //       ),
//                     //     ],
//                     //   ),
//                     // );

//                   }
//                 },
//               ),