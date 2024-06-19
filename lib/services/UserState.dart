import 'package:flutter/material.dart';
import 'models.dart';

class UserState with ChangeNotifier {
    User _user = User();

    User get user => _user;

    set user(User user) {
        _user = user;
        notifyListeners();
    }

}