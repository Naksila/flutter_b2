import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckInPage extends StatefulWidget {
  String x;
  CheckInPage(this.x);

  @override
  _CheckInPageState createState() => _CheckInPageState(this.x);
}

class _CheckInPageState extends State<CheckInPage> {
  String id_stu;
  String x;
  var now = DateTime.now();
  var formatter = DateFormat.yMMMMd();

  TextEditingController id_student = TextEditingController();
  TextEditingController id_subject = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  DateTime _data = new DateTime.now();
  _CheckInPageState(this.x);
  @override
  void initState() {
    super.initState();
    readUser();
  }

  Future<Null> readUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_stu = preferences.getString('id_student');
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> addData() {
    var url = Uri.http('192.168.0.27:80', '/db/addData.php', {'q': '{http}'});
    http.post(url, body: {
      "id_student": id_student.text,
      "id_subject": id_subject.text,
      "date": date.text,
      "time": time.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    id_student.text = "${id_stu}";
    id_subject.text = x;
    date.text = "${formatDate(_data, [
          dd,
          '/',
          mm,
          '/',
          yyyy,
        ])}";
    time.text = "${now.hour}:${now.minute}:${now.second}";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        backgroundColor: Color(0xffeeeeee),
        elevation: 0,
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff468189),
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(3, 3),
                    )
                  ]),
              alignment: Alignment.center,
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/Illustration.png')),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: id_student,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.perm_identity_rounded,
                          color: Color(0xff162C9a),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: id_subject,
                      decoration: InputDecoration(
                          icon: Icon(
                        Icons.collections_bookmark_outlined,
                        color: Color(0xff162C9a),
                      )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: date,
                      decoration: InputDecoration(
                          icon: Icon(
                        Icons.today,
                        color: Color(0xff162C9a),
                      )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: time,
                      decoration: InputDecoration(
                          icon: Icon(
                        Icons.more_time_outlined,
                        color: Color(0xff162C9a),
                      )),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      //ปุ่ม
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: InkWell(
                            onTap: () {
                              addData();
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 150.0,
                              height: 50.0,
                              // padding: EdgeInsets.only(left: 40.0),
                              margin: EdgeInsets.all(8),
                              // padding: EdgeInsets.only(left: 40.0),
                              decoration: BoxDecoration(
                                color: Color(0xff73bca0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Center(
                                child: Text(
                                  "CHECK IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
