import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  List list;
  int index;
  SubjectPage({this.index, this.list});

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Color(0xfffa8170),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
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
                child: Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(children: [
                      new Expanded(
                        child: new Container(
                            padding: EdgeInsets.all(15),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.list[widget.index]['id_subject']}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xfffa8170),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.list[widget.index]['name_subject']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xfffa8170),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Detail",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.list[widget.index]['detail']}",
                                  style: TextStyle(
                                    fontFamily: 'circe',
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Deadline",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.list[widget.index]['deadline']}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Link sent work",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${widget.list[widget.index]['link']}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )),
                      )
                    ])),
              )
            ]),
      ),
      backgroundColor: Color(0xffeeeeee),
    );
  }
}
