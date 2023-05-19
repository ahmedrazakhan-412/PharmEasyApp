import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late String userName;

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }
}
