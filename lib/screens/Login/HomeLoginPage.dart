import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_b/bottomNavigation.dart';
import 'package:flutter_b/model/UserModel.dart';
import 'package:flutter_b/screens/Login/dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

//String id = '';
//String name = '';

class HomeLoginPage extends StatefulWidget {
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLoginPage> {
  TextEditingController id = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future<List> _login() async {
    var url = Uri.http('172.20.10.7:80', '/db/login.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "id_student": id.text,
      "password": pass.text,
    });

    print(response.body);

    List datauser = json.decode(response.body);
    if (datauser.length > 0) {
      for (var map in datauser) {
        UserModel userModel = UserModel.fromJson(map);
        if (pass.text == userModel.password) {
          print(userModel.password);
          routePage(BottomNavigationState(), userModel);
        }
      }
    } else {
      print('User or Passwork incorrect');
      normalDialog(context, 'User or Passwork incorrect');
    }

    return datauser;
  }

  void routePage(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id_student', userModel.idStudent);
    preferences.setString('name_student', userModel.nameStudent);
    preferences.setString('img', userModel.img);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(children: <Widget>[
        Positioned(
          child: Container(
            color: Color(0xff468189),
          ),
        ),
        Positioned(
          top: 100,
          left: 32,
          child: Text(
            'Student',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Positioned(
          top: 190,
          child: Container(
              padding: EdgeInsets.all(32),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(62),
                      topRight: Radius.circular(62))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                      controller: id,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          hintText: 'Username')),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 62),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.security,
                            color: Colors.grey,
                          ),
                          hintText: 'Password'),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    color: Color(0xff468189),
                    onPressed: () {
                      _login();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )),
        ),
      ]),
    ));
  }
}
