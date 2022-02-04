// ignore_for_file: prefer_const_constructors

import 'package:find_trashcan/screen_page/maphome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget signInButton() {
  return Builder(builder: (context) {
    return ButtonTheme(
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MapHome();
            }));
          });
        },
        style: ElevatedButton.styleFrom(primary: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/glogo.png'),
            Text(
              'Login with Google',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
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
