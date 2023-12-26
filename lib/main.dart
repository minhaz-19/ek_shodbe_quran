import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp( MyApp( email: email,));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    this.email,
  });
  final String? email;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromRGBO(0, 36, 22, 1.0), // You can set any color here
      statusBarIconBrightness:
          Brightness.light, // Change the status bar icons' color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF007C49),
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(0, 36, 22, 1.0),
          ),
        ),
        home: AnimatedSplashScreen(
            duration: 1500,
            splash: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/applogo.png",
                        height: 250,
                        width: 250,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                        child: Text(
                          'এক শব্দে কুরআন',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            nextScreen: widget.email == null ? const Home() : const Login(),
            splashIconSize: 550,
            splashTransition: SplashTransition.scaleTransition,
            // pageTransitionType:  Animation(),
            backgroundColor: Colors.white),
      ),
    );
  }
}
