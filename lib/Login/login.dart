// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makeathon5_admin/Login/showPopUp.dart';
import 'package:makeathon5_admin/main.dart';

class Authentication {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        child: Container(
          height: MediaQuery.of(context).size.height / 21,
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 216, 217, 216))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  });
              Authentication().signInWithGoogle().then(
                (value) async {
                  User? user = value.user;
                  String? userEmail =
                      FirebaseAuth.instance.currentUser?.email.toString();

                  DocumentReference docref = await FirebaseFirestore.instance
                      .collection("access")
                      .doc(userEmail);
                  DocumentSnapshot snap = await docref.get();
                  bool userExists = await snap.exists;
                  //print("DEBUGGGG $userExists");

                  if (userExists == true) {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return MyApp();
                        }),
                      ),
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                    _signOut();
                    showPopUp(context);
                  }
                  ;

//
                },
              );
            },
            child: Container(
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 99, 192),
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
    Fluttertoast.showToast(msg: 'You do not have Access!');
  }
}
