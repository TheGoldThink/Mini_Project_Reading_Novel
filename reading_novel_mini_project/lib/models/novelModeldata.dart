// ignore_for_file: camel_case_types, file_names

import 'package:mongo_dart/mongo_dart.dart';

class IsiNovel {
  ObjectId id;
  String name;
  String sinopsis;
  String image;
  List<List<String>> ch;
  String genre;

  IsiNovel({
    required this.id,
    required this.name,
    required this.sinopsis,
    required this.image,
    required this.ch,
    required this.genre,
  });

  factory IsiNovel.fromMap(Map<String, dynamic> map) => IsiNovel(
        id: map["_id"],
        name: map["name"],
        sinopsis: map["sinopsis"],
        image: map["image"],
        ch: List<List<String>>.from(
            map["ch"].map((x) => List<String>.from(x.map((x) => x)))),
        genre: map["genre"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "sinopsis": sinopsis,
        "image": image,
        "ch": List<dynamic>.from(
            ch.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "genre": genre,
      };
}
