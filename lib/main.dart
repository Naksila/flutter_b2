import 'package:flutter/material.dart';
import 'package:flutter_b/screens/Login/HomeLoginPage.dart';

void main() {
  runApp(MyBeacon());
}

class MyBeacon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Circular',
      ),
      debugShowCheckedModeBanner: false,
      home: HomeLoginPage(),
    );
  }
}
