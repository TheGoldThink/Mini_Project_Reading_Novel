import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../database/mongodb.dart';
import '../../models/user_model.dart';

enum UserState {
  none,
  loading,
  error,
}

class UserProviders with ChangeNotifier {
  UserState _state = UserState.none;
  List<UserModel> dataUser = [];

  UserProviders() {
    _fetchuser();
  }

  UserState get state => _state;

  changeState(UserState s) {
    _state = s;
    notifyListeners();
  }

  void _fetchuser() async {
    changeState(UserState.loading);
    try {
      dataUser = await mongoDatabase.getuser();

      changeState(UserState.none);
    } catch (error) {
      changeState(UserState.error);
    }
  }

  List<UserModel> get isiProfile {
    var temp = [...dataUser];
    return temp;
  }

  updateuser(UserModel u) async {
    await mongoDatabase.update(u);
    final index = dataUser.indexWhere((element) => element.id == u.id);
    dataUser[index] = u;

    notifyListeners();
  }

  updatefavorite(UserModel u) async {}
}
