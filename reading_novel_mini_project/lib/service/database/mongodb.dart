// ignore_for_file: camel_case_types

import 'dart:developer';
import '../../models/user_model.dart';
import 'package:reading_novel_mini_project/models/novelModeldata.dart';

import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class mongoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var db, listNovel, datauser;
  static connect() async {
    db = Db(Link_mongodb);
    await db.open();
    inspect(db);
    listNovel = db.collection(novel_collection);
    datauser = db.collection(user);
  }

  static Future<List<UserModel>> getuser() async {
    if (datauser != null) {
      final hasil = await datauser.find().toList();
      return List<UserModel>.from(
          hasil.map((duser) => UserModel.fromMap(duser))).toList();
    }
    return [];
  }

  static Future<List<IsiNovel>> getNovel() async {
    if (listNovel != null) {
      final result = await listNovel.find().toList();
      return List<IsiNovel>.from(result.map((novel) => IsiNovel.fromMap(novel)))
          .toList();
    }
    return [];
  }

  static update(UserModel user) async {
    var u = await datauser.findOne({"_id": user.id});

    u["f_name"] = user.fName;
    u["l_name"] = user.lName;
    u["email"] = user.email;
    u["phone"] = user.phone;
    u["about"] = user.about;
    await datauser.save(u);
  }
}
