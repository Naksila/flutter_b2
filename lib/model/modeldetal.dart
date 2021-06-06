// To parse this JSON data, do
//
//     final modealldatal = modealldatalFromJson(jsonString);

import 'dart:convert';

String modealldatalToJson(List<Modealldatal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Modealldatal {
  Modealldatal(
    this.idSubject,
    this.nameSubject,
    this.room,
    this.startClass,
    this.quitClass,
    this.detail,
    this.deadline,
    this.link,
  );

  String idSubject;
  String nameSubject;
  String room;
  String startClass;
  String quitClass;
  String detail;
  String deadline;
  String link;

  Map<String, dynamic> toJson() => {
        "id_subject": idSubject,
        "name_subject": nameSubject,
        "room": room,
        "start_class": startClass,
        "quit_class": quitClass,
        "detail": detail,
        "deadline": deadline,
        "link": link,
      };
}
