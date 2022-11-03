// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:Mini_Project_Reading_Novel/models/novelModeldata.dart';

import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class mongoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var db, listNovel;
  static connect() async {
    db = await Db.create(Link_mongodb);
    await db.open();
    inspect(db);
    listNovel = db.collection(novel_collection);
  }

  static Future<List<IsiNovel>> getNovel() async {
    if (listNovel != null) {
      final result = await listNovel.find().toList();
      return List<IsiNovel>.from(result.map((novel) => IsiNovel.fromMap(novel)))
          .toList();
    }
    return [];
  }

  static update(IsiNovel novels) async {
    var n = await listNovel.findOne({"_id": novels.id});
    n["favorite"] = novels.favorite;
    await listNovel.save(n);
  }
}
