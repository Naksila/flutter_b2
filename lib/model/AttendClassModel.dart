// To parse this JSON data, do
//
//     final attendClassModel = attendClassModelFromJson(jsonString);

import 'dart:convert';

String attendClassModelToJson(List<AttendClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendClassModel {
  AttendClassModel(
    this.id,
    this.idStudent,
    this.idSubject,
    this.date,
    this.time,
  );

  String id;
  String idStudent;
  String idSubject;
  String date;
  String time;



  Map<String, dynamic> toJson() => {
    "id": id,
    "id_student": idStudent,
    "id_subject": idSubject,
    "date": date,
    "time": time,
  };
}
