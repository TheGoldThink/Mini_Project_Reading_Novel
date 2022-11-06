import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:reading_novel_mini_project/boxes.dart';
import '../../models/favor.dart';
import '../../models/novelModeldata.dart';
import '../database/mongodb.dart';
import '../../models/user_model.dart';

// ignore: camel_case_types
enum novelState {
  none,
  loading,
  error,
}

class Novels with ChangeNotifier {
  novelState _state = novelState.none;
  List<IsiNovel> datanov = [];
  List<UserModel> dataUser = [];

  Novels() {
    _fetchnovel();
  }

  novelState get state => _state;

  changeState(novelState s) {
    _state = s;
    notifyListeners();
  }

  void _fetchnovel() async {
    changeState(novelState.loading);
    try {
      dataUser = await mongoDatabase.getuser();
      datanov = await mongoDatabase.getNovel();

      changeState(novelState.none);
    } catch (error) {
      changeState(novelState.error);
    }
  }

  List<UserModel> get isiProfile {
    var temp = [...dataUser];
    return temp;
  }

  List<IsiNovel> get isinovelnya {
    var temp = [...datanov];
    temp.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    return temp;
  }

  updateuser(UserModel u) async {
    await mongoDatabase.update(u);
    final index = dataUser.indexWhere((element) => element.id == u.id);
    dataUser[index] = u;
    notifyListeners();
  }

  addFavorite(Favorite u) async {
    final box = Boxes.getTransactions();
    if (box.containsKey(u.judul)) {
      box.delete(u.judul);
    } else {
      box.put(u.judul, u);
    }

    notifyListeners();
  }
}
