// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:makeathon5_admin/Login/login.dart';
import 'package:makeathon5_admin/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(238, 233, 218, 1.0),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Center(
              child: Image(
                image: AssetImage('Assets/admingif.gif'),
                width: MediaQuery.of(context).size.width / 1.2,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 65,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 17,
                      ),
                      Image(
                        image: AssetImage('Assets/MLSClogo.png'),
                        height: MediaQuery.of(context).size.height / 9,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Makeathon-5",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Acme'),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 100,
                      // ),
                      Text(
                        textAlign: TextAlign.center,
                        "Admin Console",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height / 19,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: SignInButton()
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => MyApp()));
                          //   },
                          //   child: Text(
                          //     "Sign In",
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor:
                          //           Color.fromRGBO(96, 150, 180, 1.0)),
                          // ),
                          )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
