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
    userName = id;
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
