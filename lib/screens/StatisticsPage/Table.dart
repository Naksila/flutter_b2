import 'package:flutter/material.dart';
import 'package:flutter_b/model/AttendClassModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TableStatistics extends StatefulWidget {
  String id_sb;
  TableStatistics(this.id_sb);

  @override
  _TableStatisticsState createState() => _TableStatisticsState(this.id_sb);
}

class _TableStatisticsState extends State<TableStatistics> {
  List<AttendClassModel> _dataApiAttendClass = [];
  var id_sb;
  _TableStatisticsState(this.id_sb);

  @override
  void initState() {
    super.initState();
    GetApiDetel(id_sb);
  }

  String str;

  GetApiDetel(String id_subject) async {
    Uri apiUrl = Uri.parse("http://172.20.10.7/db/getAttendClass.php");
    final res = await http.post(apiUrl, body: {"id_subject": id_subject});
    var responseList = json.decode(res.body);
    print(responseList);
    for (var data in responseList) {
      _dataApiAttendClass.add(new AttendClassModel(data['id'],
          data['id_student'], data['id_subject'], data['date'], data['time']));
    }
    setState(() {});
    print("i ${_dataApiAttendClass.length}");
  }

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "No.ID",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text(
            "Date",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          tooltip: "To display last name of the Name",
        ),
        DataColumn(
          label: Text(
            "Time",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: _dataApiAttendClass
          .map(
            (name) => DataRow(
              cells: [
                DataCell(
                  Text(name.idStudent),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.date),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.time),
                  showEditIcon: false,
                  placeholder: false,
                )
              ],
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff6ebca0),
        leading: Container(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height - 60.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 25.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.black)),
                child: Container(
                  width: 400,
                  alignment: Alignment.topCenter,
                  child: bodyData(),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
