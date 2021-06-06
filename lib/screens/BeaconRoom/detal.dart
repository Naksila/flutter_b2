import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_b/model/modeldetal.dart';
import 'package:flutter_b/screens/BeaconRoom/CheckIn.dart';
import 'package:flutter_b/header.dart';
import 'package:http/http.dart' as http;

class NoteDetail extends StatefulWidget {
  String str;
  NoteDetail(this.str);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.str);
  }
}

class NoteDetailState extends State<NoteDetail> {

  _buildBackButton() {
    return new FloatingActionButton(
      backgroundColor: Color(0xff73bca0),
        child: new Icon(Icons.arrow_back),
        onPressed:() {
          Navigator.pop(context);
        });
  }


  List<Modealldatal> _dataApidetal = [];
  @override
  void initState() {
    super.initState();
    GetApiDetel(str);
  }

  String str;
  NoteDetailState(this.str);
  GetApiDetel(String room) async {
    Uri apiUrl = Uri.parse("http://172.20.10.7/db/getBeacon.php");
    final res = await http.post(apiUrl, body: {"room": room});
    var responseList = json.decode(res.body);
    print(responseList);
    for (var data in responseList) {
      _dataApidetal.add(new Modealldatal(
          data['id_subject'],
          data['name_subject'],
          data['room'],
          data['start_class'],
          data['quit_class'],
          data['detail'],
          data['deadline'],
          data['link']));
    }
    setState(() {});
    print("i ${_dataApidetal.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff468189),
      floatingActionButton: _buildBackButton(),
      body: Container(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Color(0xffFFFFFe)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ListView.builder(
                            itemCount: _dataApidetal == null ? 0 : _dataApidetal.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, i) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    width: 330,
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5),
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
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CheckInPage(
                                                      _dataApidetal[i].idSubject))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 180,
                                            width: 310,
                                            margin: EdgeInsets.symmetric(vertical: 15),
                                            padding: EdgeInsets.all(5),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              'assets/images/study.png')),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 14,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.all(6),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            '${_dataApidetal[i].idSubject}',
                                                            style: TextStyle(
                                                                color:
                                                                Color(0xff241E4E),
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            '${_dataApidetal[i].nameSubject}',
                                                            style: TextStyle(
                                                                color:
                                                                Color(0xff241e4e),
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            height: 0.5,
                                                            width: 190,
                                                            color: Colors.black87,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Attendance Time',
                                                            style: TextStyle(
                                                                color: Colors.black87,
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons.timer,
                                                                color: Colors.black87,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${_dataApidetal[i].startClass} - ${_dataApidetal[i].quitClass}",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff4448a0),
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

