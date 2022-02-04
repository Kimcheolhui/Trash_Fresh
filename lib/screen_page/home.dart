// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:find_trashcan/screen_page/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
              Column(
                children: [
                  Text(
                    '쓰레기통 찾기!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.black,
                        )),
                    child: TextButton(
                      onPressed: () {
                        // 대충 네이게이터 사용해서 페이지 이동하면 될 듯
                        // 왜 만들었는지, 어떤 기능이 있는지...
                      },
                      child: Text(
                        '이용안내 및 주의사항',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: TextButton.styleFrom(),
                    ),
                    buttonColor: Colors.transparent,
                  ),
                ],
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