// Save data to SharedPreferences
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
