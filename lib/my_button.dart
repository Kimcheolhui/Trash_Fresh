// import 'package:flutter/material.dart';
// import 'package:find_trashcan/screen_page/login.dart';

// class MyButton extends StatelessWidget {
//   MyButton({
//     required this.image,
//     required this.text,
//     required this.color,
//     required this.radius,
//     required this.onPressed,
//   });

//   final Widget image;
//   final Widget text;
//   final Color color;
//   final double radius;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ButtonTheme(
//       height: 50.0,
//       child: ElevatedButton(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             image,
//             text,
//             // 투명도를 조절해주는 위젯
//             Opacity(
//               opacity: 0.0,
//               child: image,
//             )
//           ],
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: color,
//         ),
//         onPressed: onPressed,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(radius),
//         ),
//       ),
//     );
//   }
// }
