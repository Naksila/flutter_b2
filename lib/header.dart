import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_b/screens/Login/HomeLoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String id;
  String name;
  String im;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUser();
  }

  Future<Null> readUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id_student');
      name = preferences.getString('name_student');
      im = preferences.getString('img');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 8,
                      )
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage('http://172.20.10.7/db/${im}.jpg')),
                    //AssetImage('assets/images/profile_pic.jpg')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${id}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${name}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Engineering and Industrial Technology ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "ELECTRONICS AND COMPUTER SYSTEM ",
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: IconButton(
                      icon: Icon(Icons.exit_to_app_outlined),
                      onPressed: widget.signOut),
                ),
                */
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
