// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makeathon5_admin/Login/CheckLoggedIn.dart';
import 'package:makeathon5_admin/ScanQR.dart';
import 'alertDialog.dart';
import 'firebase_options.dart';

Query showTeamsOutside = FirebaseFirestore.instance
    .collection('teams')
    .where("TeamOutside", isEqualTo: true);
Query normalstream = FirebaseFirestore.instance.collection('teams').where("");
Query mystream = normalstream;

String calculateTotalScrore(data) {
  int totalsum = data['Points1'] + data['Points2'] + data['Points3'];
  int markScored = ((totalsum * 100) ~/ 30);
  String returnvalue = '$markScored';
  return returnvalue;
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(CheckLoggedIn()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";
  TextEditingController edtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () async {
                  setState(() {
                    name = "";
                    edtSearch.text = "";
                  });
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () async {
                  String scanResult = await scanCode();
                  setState(() {
                    if (scanResult == "-1") {
                      Fluttertoast.showToast(msg: "Not Found");
                    } else {
                      name = scanResult;
                      edtSearch.text = name;
                    }
                  });
                },
                icon: Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.indigo[900],
          title: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: edtSearch,
              decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Team'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: mystream.snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (name.isEmpty) {
                      return ListTile(
                          onTap: () {
                            openPopUp(context, data);
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          title: Text(
                            data['Name'] ?? " Default",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Total Score: ${calculateTotalScrore(data)} ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ));
                    }
                    if (data['Name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return ListTile(
                        onTap: () {
                          openPopUp(context, data);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        title: Text(
                          data['Name'] ?? "Deafult Name_",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Total Score: ${calculateTotalScrore(data)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Container();
                  });
        },
      ),
      floatingActionButton: Container(
        // margin: EdgeInsets.only(
        //     right: MediaQuery.of(context).size.width / 17,
        //     bottom: MediaQuery.of(context).size.height / 45),
        height: MediaQuery.of(context).size.height / 13,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.indigo[900],
            child: Icon(Icons.location_disabled),
            onPressed: () {
              if (mystream == normalstream) {
                mystream = showTeamsOutside;
              } else {
                mystream = normalstream;
              }
              setState(() {
                // name = "";
                // edtSearch.text = "";
              });
            },
          ),
        ),
      ),
    );
  }
}
