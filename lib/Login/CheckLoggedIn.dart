import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeathon5_admin/Login/loginpage.dart';

import '../main.dart';


class CheckLoggedIn extends StatelessWidget {
  const CheckLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FirebaseAuth.instance.currentUser == null ? LoginPage() : MyApp(),
      ),
    );
  }
}


