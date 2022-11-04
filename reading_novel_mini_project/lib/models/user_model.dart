// ignore_for_file: camel_case_types

import 'package:mongo_dart/mongo_dart.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.about,
  });

  ObjectId id;
  String fName;
  String lName;
  String email;
  String phone;
  String about;

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map["_id"],
        fName: map["f_name"],
        lName: map["l_name"],
        email: map["email"],
        phone: map["phone"],
        about: map["about"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "about": about,
      };
}
