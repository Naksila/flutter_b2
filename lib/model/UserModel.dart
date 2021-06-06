class UserModel {
  String idStudent;
  String password;
  String nameStudent;
  String img;

  UserModel({this.idStudent, this.password, this.nameStudent, this.img});

  UserModel.fromJson(Map<String, dynamic> json) {
    idStudent = json['id_student'];
    password = json['password'];
    nameStudent = json['name_student'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_student'] = this.idStudent;
    data['password'] = this.password;
    data['name_student'] = this.nameStudent;
    data['img'] = this.img;
    return data;
  }
}