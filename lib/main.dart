import 'package:adhan/adhan.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ek_shodbe_quran/component/namaz_time.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool result = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  NamazWakto.flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await NamazWakto.flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (id) async {},
  );

  await Readable.readJson();
  result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    result = true;
  } else {
    result = false;
  }
// assign surah list to surah para provider

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
                          'একশব্দে কুরআন শিক্ষা',
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

dynamic _periodicTaskCallback(int alarmId) async {
  // Show a notification

  if (alarmId == 10) {
    // write a logic so that it sets an alarm at 12:05 AM once
    bool _fazarAlarmIsSet = await getDataFromDevice('1').then((value) {
      return value == null ? false : true;
    });

    bool _johorAlarmIsSet = await getDataFromDevice('2').then((value) {
      return value == null ? false : true;
    });

    bool _asorAlarmIsSet = await getDataFromDevice('3').then((value) {
      return value == null ? false : true;
    });

    bool _magribAlarmIsSet = await getDataFromDevice('4').then((value) {
      return value == null ? false : true;
    });

    bool _eshaAlarmIsSet = await getDataFromDevice('5').then((value) {
      return value == null ? false : true;
    });

    double _latitude =
        await getDataFromDevice('current latitude').then((value) {
      return value == null ? 0.0 : double.parse(value);
    });

    double _longitude =
        await getDataFromDevice('current longitude').then((value) {
      return value == null ? 0.0 : double.parse(value);
    });

    final _myCoordinates = Coordinates(_latitude, _longitude);
    final params = CalculationMethod.karachi.getParameters();
    final _prayerTimes = PrayerTimes.today(_myCoordinates, params);

    if (_fazarAlarmIsSet) {
      Duration duration = _prayerTimes.fajr.difference(DateTime.now());
      if (!duration.isNegative) {
        await AndroidAlarmManager.oneShot(
          duration,
          1,
          _periodicTaskCallback, // Pass the function reference without calling it
          wakeup: true,
          rescheduleOnReboot: true,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }

    if (_johorAlarmIsSet) {
      Duration duration = _prayerTimes.dhuhr.difference(DateTime.now());
      if (!duration.isNegative) {
        await AndroidAlarmManager.oneShot(
          duration,
          2,
          _periodicTaskCallback, // Pass the function reference without calling it
          wakeup: true,
          rescheduleOnReboot: true,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }

    if (_asorAlarmIsSet) {
      Duration duration = _prayerTimes.asr.difference(DateTime.now());
      if (!duration.isNegative) {
        await AndroidAlarmManager.oneShot(
          duration,
          3,
          _periodicTaskCallback, // Pass the function reference without calling it
          wakeup: true,
          rescheduleOnReboot: true,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }

    if (_magribAlarmIsSet) {
      Duration duration = _prayerTimes.maghrib.difference(DateTime.now());
      if (!duration.isNegative) {
        await AndroidAlarmManager.oneShot(
          duration,
          4,
          _periodicTaskCallback, // Pass the function reference without calling it
          wakeup: true,
          rescheduleOnReboot: true,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }

    if (_eshaAlarmIsSet) {
      Duration duration = _prayerTimes.isha.difference(DateTime.now());
      if (!duration.isNegative) {
        await AndroidAlarmManager.oneShot(
          duration,
          5,
          _periodicTaskCallback, // Pass the function reference without calling it
          wakeup: true,
          rescheduleOnReboot: true,
          exact: true,
          allowWhileIdle: true,
        );
      }
    }
  } else {
    await NamazWakto.flutterLocalNotificationsPlugin.show(
      alarmId,
      'নামাজের সময় হয়েছে',
      (alarmId == 1)
          ? 'ফজরের নামাজের সময় হয়েছে'
          : (alarmId == 2)
              ? 'যোহরের নামাজের সময় হয়েছে'
              : (alarmId == 3)
                  ? 'আসরের নামাজের সময় হয়েছে'
                  : (alarmId == 4)
                      ? 'মাগরিবের নামাজের সময় হয়েছে'
                      : (alarmId == 5)
                          ? 'এশার নামাজের সময় হয়েছে'
                          : 'নামাজের সময় হয়েছে',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          // sound: RawResourceAndroidNotificationSound('al'),
          enableVibration: true,
          enableLights: true,
          icon: '@mipmap/launcher_icon',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        ),
      ),
    );
  }
}
