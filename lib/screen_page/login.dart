// ignore_for_file: prefer_const_constructors

import 'package:find_trashcan/screen_page/maphome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:find_trashcan/my_button.dart';

Widget signInButton() {
  return Builder(builder: (context) {
    return ButtonTheme(
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MapHome();
            }));
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/glogo.png'),
            Text(
              'Login with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
            // 투명도를 조절해주는 위젯
            Opacity(
              opacity: 0.0,
              child: Image.asset('assets/glogo.png'),
            ),
          ],
        ),
      ),
    );
  });
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}



// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// Future<String> signInWithGoogle() async {
//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount!.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );

//   final AuthResult authResult = await _auth.signInWithCredential(credential);
//   final FirebaseUser user = authResult.user;

//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final FirebaseUser currentUser = await _auth.currentUser();
//   assert(user.uid == currentUser.uid);

//   return 'signInWithGoogle succeeded: $user';
// }

// void signOutGoogle() async{
//   await googleSignIn.signOut();

//   print("User Sign Out");
// }






// class Login extends StatelessWidget {
//   const Login({Key? key}) : super(key: key);

//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser!.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ButtonTheme(
//             height: 50.0,
//             child: ElevatedButton(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset('assets/glogo.png'),
//                   Text(
//                     'Login with Google',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontSize: 15.0,
//                     ),
//                   ),
//                   // 투명도를 조절해주는 위젯
//                   Opacity(
//                     opacity: 0.0,
//                     child: Image.asset('assets/glogo.png'),
//                   ),
//                 ],
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white,
//               ),
//               onPressed: signInWithGoogle,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(4.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
