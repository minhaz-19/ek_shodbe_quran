import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
      statusBarColor: Color(0xFF007C49), // You can set any color here
      statusBarIconBrightness:
          Brightness.light, // Change the status bar icons' color
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF007C49), // Set your desired primary color here 007C49
        // You can also set other theme properties here, such as accentColor, fontFamily, etc.
      ),
      home: const Login(),
    );
  }
}


