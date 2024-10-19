import 'package:flutter/material.dart';
import 'models.dart';

class UserState with ChangeNotifier {
  User _user = User();
  bool _signedInWithThirdParty = false;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  set signedInWithThirdParty(bool value) {
    _signedInWithThirdParty = value;
    notifyListeners();
  }

  bool get signedInWithThirdParty => _signedInWithThirdParty;

  void decrementPostsLeft() {
    _user.numPostsLeft--;
    notifyListeners();
  }

  void incrementPostsLeft() {
    _user.numPostsLeft += 3;
    notifyListeners();
  }
}
