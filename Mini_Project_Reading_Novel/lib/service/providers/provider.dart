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
  List<User_model> dataUser = [];

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
      datanov = await mongoDatabase.getNovel();
      dataUser = await mongoDatabase.getuser();
      changeState(novelState.none);
    } catch (error) {
      changeState(novelState.error);
    }
  }

  List<IsiNovel> get isinovelnya {
    var temp = [...datanov];
    temp.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    return temp;
  }
}
