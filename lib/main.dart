import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF007C49), // You can set any color here
      statusBarIconBrightness:
          Brightness.light, // Change the status bar icons' color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(
              0xFF007C49), 
              appBarTheme: const AppBarTheme(
          color: Color(0xFF012A1A),
        ),

        ),
        home: AnimatedSplashScreen(
            duration: 1500,
            splash: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/applogo.png",
                        height: 250,
                        width: 250,
                      ),
                      Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 8, 8),
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
            nextScreen: const Login(),
            splashIconSize: 550,
            splashTransition: SplashTransition.scaleTransition,
            // pageTransitionType:  Animation(),
            backgroundColor: Colors.white),
      ),
    );
  }
}
