// import 'package:flutter/material.dart';
// import 'package:find_trashcan/screen_page/classify/classify_main.dart';

// Widget BottomBar() {
//   return Builder(builder: (context) {
//     return Positioned(
//       bottom: 0,
//       child: Container(
//         height: 70,
//         width: MediaQuery.of(context).size.width,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: InkWell(
//                   onTap: () {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) {
//                     //   return ClassifyTrash();
//                     // }));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(color: Color(0xff4B9B77)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/camera.png",
//                           height: 30,
//                         ),
//                         Text(
//                           '쓰레기 분류',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 70,
//                 width: 1,
//                 color: Colors.white,
//               ),
//               Expanded(
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                     decoration: BoxDecoration(color: Color(0xff4B9B77)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/location.png",
//                           height: 30,
//                         ),
//                         Text(
//                           '길 찾기',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 70,
//                 width: 1,
//                 color: Colors.white,
//               ),
//               Expanded(
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                     decoration: BoxDecoration(color: Color(0xff4B9B77)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/mypage.png",
//                           height: 30,
//                         ),
//                         Text(
//                           '마이페이지',
//                           style: TextStyle(color: Colors.white),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   });
// }
