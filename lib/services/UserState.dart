import 'package:flutter/material.dart';
import 'models.dart';

class UserState with ChangeNotifier {
    User _user = User();

    User get user => _user;

    

    set user(User user) {
        _user = user;
        notifyListeners();
    }


    void decrementPostsLeft() {
        _user.numPostsLeft--;
        notifyListeners();
    }

    void incrementPostsLeft() {
        _user.numPostsLeft += 3;
        notifyListeners();
    }
}

