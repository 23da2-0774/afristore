import 'package:flutter/foundation.dart';

import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = sampleUser;

  UserModel get user => _user;

  void updateUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
