// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController edt1 = new TextEditingController();
TextEditingController edt2 = new TextEditingController();
TextEditingController edt3 = new TextEditingController();
TextEditingController edtremarks = new TextEditingController();
String Updated = '';
bool Eliminated = false;
bool TeamOutside = false;

UpdateElimintation() {
  Eliminated = !Eliminated;
}

UpdateTeamOutside() {
  TeamOutside = !TeamOutside;
}

ValuesUpdated(context, teamName) async {
  bool valuelessthan10 = int.parse(edt1.text) <= 10 &&
      int.parse(edt2.text) <= 10 &&
      int.parse(edt3.text) <= 10;

  bool positivevalue = int.parse(edt1.text) >= 0 &&
      int.parse(edt2.text) >= 0 &&
      int.parse(edt3.text) >= 0;

  if (valuelessthan10 && positivevalue) {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection('teams').doc(teamName);
    doc.set({
      "Points1": int.parse(edt1.text),
      "Points2": int.parse(edt2.text),
      "Points3": int.parse(edt3.text),
      "Remarks": edtremarks.text,
      "Eliminate": Eliminated,
      "TeamOutside": TeamOutside,
      "Updated": FirebaseAuth.instance.currentUser!.displayName,
    }, SetOptions(merge: true));
    Fluttertoast.showToast(msg: "Values Updated");
    Navigator.pop(context);
  } else {
    Fluttertoast.showToast(msg: "Please Enter Values Between 0-10");
  }
}

openPopUp(context, data) {
  edt1.text = data['Points1'].toString();
  edt2.text = data['Points2'].toString();
  edt3.text = data['Points3'].toString();
  edtremarks.text = data['Remarks'].toString();
  Eliminated = data['Eliminate'];
  TeamOutside = data['TeamOutside'] ?? false;
  Updated = data['Updated'] ?? "Admin";

  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(content: Builder(builder: (context) {
          Scrollable:
          true;
          return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width / 1.2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    data['Name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Check Point 1: "),
                      Container(
                          width: MediaQuery.of(context).size.width / 8,
                          child: TextFormField(
                            controller: edt1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Check Point 2: "),
                      Container(
                          width: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: edt2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Check Point 3: "),
                      Container(
                          width: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: edt3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Eliminate"),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            Checkbox(
                          activeColor: Colors.indigo[700],
                          value: Eliminated,
                          onChanged: (value) {
                            setState(() {
                              Eliminated = !Eliminated;
                            });
                          },
                        ),
                      ),
                      Spacer(),
                      Text("Team Outside"),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            Switch(
                          activeColor: Colors.indigo[700],
                          value: TeamOutside,
                          onChanged: (value) {
                            setState(() {
                              TeamOutside = !TeamOutside;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextField(
                      controller: edtremarks,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "Remarks",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text("Last Updated by: $Updated"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[700]),
                          onPressed: () {
                            ValuesUpdated(context, data['Name']);
                          },
                          child: Text("Update")))
                ],
              ),
            ),
          );
        }));
      });
}
