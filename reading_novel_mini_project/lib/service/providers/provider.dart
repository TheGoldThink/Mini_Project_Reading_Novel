import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../models/novelModeldata.dart';
import '../database/mongodb.dart';
import '../../models/user_model.dart';

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
    if (u != 0) {
      await mongoDatabase.update(u);
      final index = dataUser.indexWhere((element) => element.id == u.id);
      dataUser[index] = u;
      notifyListeners();
    }
  }
}
