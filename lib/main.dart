import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/readable.dart';
import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:isolate';
import 'dart:ui';

bool result = false;

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
ReceivePort port = ReceivePort();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  await Readable.readJson();
  result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    result = true;
  } else {
    result = false;
  }

// Be sure to add this line if initialize() call happens before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/applogo',
    [
      NotificationChannel(
          // channelGroupKey: 'basic_channel_group',
          channelKey: 'custom_sound',
          channelName: 'Salat notifications',
          channelDescription: 'Salat alarm',
          defaultColor: Colors.white,
          playSound: true,
          importance: NotificationImportance.Max,
          enableVibration: true,
          soundSource: 'resource://raw/adhan',
          criticalAlerts: true,
          ledColor: Colors.white),
          NotificationChannel(
          // channelGroupKey: 'basic_channel_group',
          channelKey: 'durud_sound',
          channelName: 'Durud notifications',
          channelDescription: 'Durud alarm',
          defaultColor: Colors.white,
          playSound: true,
          importance: NotificationImportance.Max,
          enableVibration: true,
          soundSource: 'resource://raw/durud',
          criticalAlerts: true,
          ledColor: Colors.white),
          NotificationChannel(
          // channelGroupKey: 'basic_channel_group',
          channelKey: 'fazr_sound',
          channelName: 'Durud notifications',
          channelDescription: 'Durud alarm',
          defaultColor: Colors.white,
          playSound: true,
          importance: NotificationImportance.Max,
          enableVibration: true,
          soundSource: 'resource://raw/fazradhan',
          criticalAlerts: true,
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    // channelGroups: [
    //   NotificationChannelGroup(
    //       channelGroupKey: 'basic_channel_group',
    //       channelGroupName: 'Basic group')
    // ],
  );
  bool isAlowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAlowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(MyApp(
    email: email,
  ));
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
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SurahParaProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => NamazTimeProvider()),
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
                          'একশব্দে\nকুরআন শিক্ষা',
                          textAlign: TextAlign.center,
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
            nextScreen: (widget.email == null || result == false)
                ? const Home()
                : const Login(),
            splashIconSize: 550,
            splashTransition: SplashTransition.scaleTransition,
            // pageTransitionType:  Animation(),
            backgroundColor: Colors.white),
      ),
    );
  }
}
