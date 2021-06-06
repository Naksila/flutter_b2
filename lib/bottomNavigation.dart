import 'package:flutter/material.dart';
import 'package:flutter_b/screens/BeaconRoom/ScanBeacon.dart';
import 'package:flutter_b/screens/HomeWorkPage/home_work.dart';
import 'package:flutter_b/screens/NewsPage/news.dart';
import 'package:flutter_b/screens/StatisticsPage/statistics.dart';

class BottomNavigationState extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationState> {
  int _selectedItemIndex = 0;
  final List pages = [
    Scanbeacon(),
    HomeWorkPage(),
    NewsPage(),
    HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xff468189),
          //Color(0xffc5f2ed),
          selectedIconTheme: IconThemeData(color:Color(0xff468189),),
          //color: Color(0xffc5f2ed)
          currentIndex: _selectedItemIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedItemIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("Beacon Check"),
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("Home Work"),
              icon: Icon(Icons.sticky_note_2_outlined),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("News"),
              icon: Icon(Icons.mail_outline),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Text("History"),
              icon: Icon(Icons.insert_chart_outlined),
            ),
          ],
        ),
        body:pages[_selectedItemIndex],
      ),
    );
  }
}
