import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _loginTime = '';

  String get userName => _userName;
  String get loginTime => _loginTime;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setLoginTime(String time) {
    _loginTime = time;
    notifyListeners();
  }
}
