// ignore_for_file: camel_case_types

import 'dart:developer';
import '../../models/user_model.dart';
import 'package:mini_Project_Reading_Novel/models/novelModeldata.dart';

import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class mongoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var db, listNovel, datauser;
  static connect() async {
    db = await Db.create(Link_mongodb);
    await db.open();
    inspect(db);
    listNovel = db.collection(novel_collection);
    datauser = db.collection(user);
  }

  static Future<List<IsiNovel>> getNovel() async {
    if (listNovel != null) {
      final result = await listNovel.find().toList();
      return List<IsiNovel>.from(result.map((novel) => IsiNovel.fromMap(novel)))
          .toList();
    }
    return [];
  }

  static Future<List<User_model>> getuser() async {
    if (datauser != null) {
      final result = await datauser.find().toList();
      return List<User_model>.from(
          result.map((duser) => datauser.fromMap(duser))).toList();
    }
    return [];
  }
}
