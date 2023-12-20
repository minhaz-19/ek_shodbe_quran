// Save data to SharedPreferences
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDataToDevice(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// Retrieve data from SharedPreferences
Future<String?> getDataFromDevice(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

// Remove data from SharedPreferences
Future<void> removeDataFromDevice(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> saveMap(String mapName, Map<String, dynamic> myMap) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String encodedMap = jsonEncode(myMap);
  prefs.setString(mapName, encodedMap);
}

Future<Map<String, dynamic>> getMap(String mapKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? encodedMap = prefs.getString(mapKey);
  if (encodedMap != null) {
    return jsonDecode(encodedMap) as Map<String, dynamic>;
  } else {
    return {}; // Return an empty map if no data is found
  }
}

Future<void> saveList(String listName, List<String> myList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String encodedList = jsonEncode(myList);
  prefs.setString(listName, encodedList);
}

Future<List<String>> getList(String listName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? encodedList = prefs.getString(listName);
  if (encodedList != null) {
    return jsonDecode(encodedList);
  } else {
    return []; // Return an empty list if no data is found
  }
}

// Future<void> bookImagePath(String bookName, String imagePath) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(bookName, imagePath);
// }

// Future<String?> getBookImagePath(String bookName) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(bookName);
// }