// ignore_for_file: camel_case_types

import 'package:mongo_dart/mongo_dart.dart';

class User_model {
  ObjectId id;
  String fName;
  String lName;
  String email;
  String phone;
  String about;
  User_model({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.about,
  });

  factory User_model.fromMap(Map<String, dynamic> map) => User_model(
        id: map["_id"],
        fName: map["f_name"],
        lName: map["l_name"],
        email: map["email"],
        phone: map["phone"],
        about: map["about"],
      );

  Map<String, dynamic> tomap() => {
        "_id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "phone": phone,
        "about": about,
      };
}
