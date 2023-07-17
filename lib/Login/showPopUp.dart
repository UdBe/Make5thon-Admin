// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

showPopUp(context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Unauthorised Access!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image(image: AssetImage('Assets/golibeta.gif')),
                Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  "Please ask your closest Technical Coordinator for Access 🥷🧘‍♂️",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
          ),
        );
      });
}
