import 'package:flutter_b/screens/HomeWorkPage/subject_page.dart';
import 'package:flutter_b/header.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomeWorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWorkPage(),
      routes: {
        '/subjectpage': (context) => SubjectPage(),
      },
    );
  }
}

class homeWorkPage extends StatefulWidget {
  @override
  _homeWorkPageState createState() => _homeWorkPageState();
}

class _homeWorkPageState extends State<homeWorkPage> {
  Future<List> getData() async {
    var url = Uri.http('172.20.10.7:80', '/db/getData.php', {'q': '{http}'});
    final response = await http.get(url);
    //print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff468189),
      body: Column(children: [
        Header(),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xffFFFFFe),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Work",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: new FutureBuilder<List>(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);

                          return snapshot.hasData
                              ? new ItemList(
                            list: snapshot.data,
                          )
                              : new Center(
                            child: new CircularProgressIndicator(),
                          );
                        },
                      ))
                ],
              ),
            )),
      ]),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              height: 175.0,
              width: 15.0,
              decoration: BoxDecoration(
                  color: Color(0xff6ebca0),
                  border: Border.all(width: 0.1),
                  //Color(0xffc5f2ed),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(3, 3),
                    )
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(10),
              height: 175.0,
              width: 330.0,
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(3, 3),
                    )
                  ]),
              child: new Container(
                padding: EdgeInsets.all(15),
                child: new GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => new SubjectPage(list: list,index: i))),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '${list[i]['id_subject']}',
                        style: TextStyle(
                            color: Color(0xff241E4E),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      new Text(
                        '${list[i]['name_subject']}',
                        style: TextStyle(
                            color: Color(0xff241E4E),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new Text(
                        'Deadline',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          new Text(
                            "${list[i]['deadline']}",
                            style: TextStyle(
                                color: Color(0xff4448a0),
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
