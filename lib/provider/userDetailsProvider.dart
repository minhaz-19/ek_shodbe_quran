import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier {
  static String userName = '';
  static String userEmail = '';
  static String userId = '';
  void updateName(String name) {
    userName = name;
    notifyListeners();
  }
  void updateEmail(String email) {
    userEmail = email;
    notifyListeners();
  }
  void updateId(String id) {
    userId = id;
    notifyListeners();
  }
  String getName() {
    return userName;
  }
  String getEmail() {
    return userEmail;
  }
  String getId() {
    return userId;
  }
}
