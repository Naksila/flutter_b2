import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b/model/AttendClassModel.dart';
import 'package:flutter_b/screens/StatisticsPage/Table.dart';
import 'package:flutter_b/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List> getData() async {
    var url = Uri.http('172.20.10.7:80', '/db/getData.php', {'q': '{http}'});
    final response = await http.get(url);
    //print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff468189),
      body: Column(
        children: [
          Header(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xffFFFFFe)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "History Attendance Class ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'product'),
                      )
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
            ),
          ),
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 170,
                width: MediaQuery.of(context).size.width - 50,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(3, 3),
                      )
                    ]),
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${list[i]['id_subject']}',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 180,
                            height: 40,
                            child: Text(
                              '${list[i]['name_subject']}',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TableStatistics(list[i]["id_subject"]);
                            })),
                            color: Color(0xff73bca0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                        //height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 20),
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/statistic.png')),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
