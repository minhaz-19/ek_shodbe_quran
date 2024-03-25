import 'dart:isolate';
import 'dart:isolate';
import 'dart:ui';
import 'package:adhan/adhan.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ek_shodbe_quran/component/feature_icon.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/component/video.dart';
import 'package:ek_shodbe_quran/main.dart';
import 'package:ek_shodbe_quran/notification_controller.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/repeat_book_and_video_page.dart';
import 'package:ek_shodbe_quran/screens/tabs/bookdetails_from_authors.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/calendar.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/courses.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/read_quran.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/donate.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/durud.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/kiblah.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/namaz_time.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/tilawat.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/todays_ayat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as loc;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> bookName = BookDetailsFromAuthors.bookName;
  List<String> bookImage = BookDetailsFromAuthors.bookImage;
  List<String> authorName = BookDetailsFromAuthors.authorName;
  List<int> bookPrice = BookDetailsFromAuthors.bookPrice;
  List<String> bookProkashoni = BookDetailsFromAuthors.bookProkashoni;
  List<String> bookSubject = BookDetailsFromAuthors.bookSubject;
  List<String> bookTranslator = BookDetailsFromAuthors.bookTranslator;
  List<String> bookCover = BookDetailsFromAuthors.bookCover;
  List<String> bookLanguage = BookDetailsFromAuthors.bookLanguage;
  List<String> bookEdition = BookDetailsFromAuthors.bookEdition;
  List<int> bookTotalPage = BookDetailsFromAuthors.bookTotalPage;
  List<String> bookDescription = BookDetailsFromAuthors.booDescription;

  List<String> videoTitle = VideoDetailsFromAuthor.videoTitle;
  List<String> videoDescription = VideoDetailsFromAuthor.videoDescription;
  List<String> videoImage = VideoDetailsFromAuthor.videoImage;
  List<String> videoUrl = VideoDetailsFromAuthor.videoUrl;

  String uid = '';
  String name = '';
  String email = '';
  bool _is_loading = false;
  List<Placemark> placemarks = [];
  var _currentWakto = '';
  var _nextWakto = '';
  var _currentWaktoTime = '';
  var _nextWaktoTime = '';
  loc.Location location = new loc.Location();

  bool _serviceEnabled = false;
  bool _firstTimeAlarmLoad = true;

  @override
  void initState() {
    setState(() {
      uid = UserDetailsProvider().getId();
      name = UserDetailsProvider().getName();
      email = UserDetailsProvider().getEmail();
    });
    _initializeHome();

    super.initState();
  }

  void _initializeHome() async {
    setState(() {
      _is_loading = true;
    });
    await getDataFromDevice('periodic alarm').then((value) {
      // if (value == null) {
      //   Fluttertoast.showToast(msg: 'Periodic Alarm is not set');
      // }
    });
    AndroidAlarmManager.initialize();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        debugPrint('Location Denied once');
      }
    }
    var namazTimeData = Provider.of<NamazTimeProvider>(context, listen: false);
    var locationData = Provider.of<LocationProvider>(context, listen: false);
    await getDataFromDevice('current latitude').then((value) async {
      if (value == null) {
        setState(() {
          locationData.locality = 'Jashore';
          locationData.subLocality = 'Jashore Zilla School';
          locationData.country = 'Bangladesh';
          locationData.setLocation(
            23.160969261812728,
            89.20574491067016,
          );
        });
      } else {
        await getDataFromDevice('current longitude').then((longitude) async {
          await getDataFromDevice('current latitude').then((latitude) {
            locationData.setLocation(double.parse(latitude.toString()),
                double.parse(longitude.toString()));
          });

          placemarks = await placemarkFromCoordinates(
              locationData.latitude, locationData.longitude);
        });

        locationData.setAddress(
            placemarks[0].subLocality.toString(),
            placemarks[0].locality.toString(),
            placemarks[0].country.toString());
      }
    });

    final myCoordinates =
        Coordinates(locationData.latitude, locationData.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    var _faazar_time = DateFormat.jm().format(prayerTimes.fajr);
    var _johor_time = DateFormat.jm().format(prayerTimes.dhuhr);
    var _asor_time = DateFormat.jm().format(prayerTimes.asr);
    var _magrib_time = DateFormat.jm()
        .format(prayerTimes.maghrib.add(const Duration(minutes: 3)));
    var _esha_time = DateFormat.jm().format(prayerTimes.isha);
    // _tahajjud_time = DateFormat.jm().format(prayerTimes.);
    var _sunrise_time = DateFormat.jm().format(prayerTimes.sunrise);
    final DateFormat format = DateFormat.jm();
    DateTime responseDateTime = format.parse(_magrib_time);

    // Subtract one minute
    responseDateTime = responseDateTime.subtract(Duration(minutes: 1));

    // Format the adjusted time for display
    String adjustedTime = format.format(responseDateTime);
    var _sunset_time = adjustedTime;

    namazTimeData.setNamazTime(_faazar_time, _johor_time, _asor_time,
        _magrib_time, _esha_time, _sunrise_time, _sunset_time);

    namazTimeData.setNamazTimeDateTime(
        prayerTimes.fajr,
        prayerTimes.dhuhr,
        prayerTimes.asr,
        prayerTimes.maghrib.add(const Duration(minutes: 3)),
        prayerTimes.isha,
        prayerTimes.sunrise);
    // find the current wakto
    var now = DateTime.now();
    if (now.isBefore(prayerTimes.fajr.subtract(const Duration(minutes: 5)))) {
      _currentWakto = 'তাহাজ্জুদ';
      _nextWakto = 'ফজর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.fajr.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.fajr);
    } else if (now.isBefore(prayerTimes.fajr)) {
      _currentWakto = 'তাহাজ্জুদ';
      _nextWakto = 'ফজর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.fajr.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.fajr);
    } else if (now.isBefore(prayerTimes.sunrise)) {
      _currentWakto = 'ফজর';
      _nextWakto = 'যোহর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.sunrise.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.dhuhr);
    } else if (now.isBefore(prayerTimes.dhuhr)) {
      _currentWakto = 'ফজর';
      _nextWakto = 'যোহর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.sunrise.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.dhuhr);
    } else if (now.isBefore(prayerTimes.asr)) {
      _currentWakto = 'যোহর';
      _nextWakto = 'আসর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.asr.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.asr);
    } else if (now
        .isBefore(prayerTimes.maghrib.add(const Duration(minutes: 3)))) {
      _currentWakto = 'আসর';
      _nextWakto = 'মাগরিব';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.maghrib.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm()
          .format(prayerTimes.maghrib.add(const Duration(minutes: 3)));
    } else if (now
        .isBefore(prayerTimes.isha.subtract(const Duration(minutes: 5)))) {
      _currentWakto = 'মাগরিব';
      _nextWakto = 'ঈশা';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.isha.subtract(const Duration(minutes: 5)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.isha);
    } else if (now.isBefore(prayerTimes.isha)) {
      _currentWakto = 'মাগরিব';
      _nextWakto = 'ঈশা';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.isha.subtract(const Duration(minutes: 5)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.isha);
    } else {
      _currentWakto = 'ঈশা';
      _nextWakto = 'ফজর';
      _currentWaktoTime = DateFormat.jm()
          .format(prayerTimes.fajr.subtract(const Duration(minutes: 1)));
      _nextWaktoTime = DateFormat.jm().format(prayerTimes.fajr);
    }

    if (_firstTimeAlarmLoad) {
      // Fluttertoast.showToast(msg: 'Setting Master Alarm');
      await AndroidAlarmManager.periodic(
          const Duration(minutes: 1), 41, periodicCallback);
      setState(() {
        _firstTimeAlarmLoad = false;
      });
    }
    // await AndroidAlarmManager.cancel(41);

    setState(() {
      _is_loading = false;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> periodicCallback(int alarmId) async {
    // set other alarms
        final prefs = await SharedPreferences.getInstance();
    final String isAlarm1Null = prefs.getString('1') ?? '0';
    final String isAlarm2Null = prefs.getString('2') ?? '0';
    final String isAlarm3Null = prefs.getString('3') ?? '0';
    final String isAlarm4Null = prefs.getString('4') ?? '0';
    final String isAlarm5Null = prefs.getString('5') ?? '0';
    final String isAlarm11Null = prefs.getString('11') ?? '0';

    var alarmLatitude, alarmLongitude;
    await getDataFromDevice('current longitude').then((longitude) async {
      await getDataFromDevice('current latitude').then((latitude) {
        alarmLatitude = double.parse(latitude!);
        alarmLongitude = double.parse(longitude!);
      });
    });

    final myCoordinates = Coordinates(alarmLatitude, alarmLongitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final alarmPrayerTimes = PrayerTimes.today(myCoordinates, params);

    DateTime nextFajr = alarmPrayerTimes.fajr.add(const Duration(days: 1));
    DateTime nextDhuhr = alarmPrayerTimes.dhuhr.add(const Duration(days: 1));
    DateTime nextAsr = alarmPrayerTimes.asr.add(const Duration(days: 1));
    DateTime nextMaghrib = alarmPrayerTimes.maghrib.add(const Duration(days: 1));
    DateTime nextIsha = alarmPrayerTimes.isha.add(const Duration(days: 1));
    
    DateTime minBeforeFajr = alarmPrayerTimes.fajr.subtract(const Duration(minutes: 15));
    DateTime minBeforeDhuhr = alarmPrayerTimes.dhuhr.subtract(const Duration(minutes: 15));
    DateTime minBeforeAsr = alarmPrayerTimes.asr.subtract(const Duration(minutes: 15));
    DateTime minBeforeMaghrib = alarmPrayerTimes.maghrib.subtract(const Duration(minutes: 15));
    DateTime minBeforeIsha = alarmPrayerTimes.isha.subtract(const Duration(minutes: 15));

    DateTime nextminBeforeFajr = minBeforeFajr.add(const Duration(days: 1));
    DateTime nextminBeforeDhuhr = minBeforeDhuhr.add(const Duration(days: 1));
    DateTime nextminBeforeAsr = minBeforeAsr.add(const Duration(days: 1));
    DateTime nextminBeforeMaghrib = minBeforeMaghrib.add(const Duration(days: 1));
    DateTime nextminBeforeIsha = minBeforeIsha.add(const Duration(days: 1));


    if (isAlarm1Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(alarmPrayerTimes.fajr)
            ? alarmPrayerTimes.fajr
            : nextFajr,
        1,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }

    if (isAlarm2Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(alarmPrayerTimes.dhuhr)
            ? alarmPrayerTimes.dhuhr
            : nextDhuhr,
        2,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }

    if (isAlarm3Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(alarmPrayerTimes.asr)
            ? alarmPrayerTimes.asr
            : nextAsr,
        3,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }

    if (isAlarm4Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(alarmPrayerTimes.maghrib)
            ? alarmPrayerTimes.maghrib
            : nextMaghrib,
        4,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }

    if (isAlarm5Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(alarmPrayerTimes.isha)
            ? alarmPrayerTimes.isha
            : nextIsha,
        5,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }

    if (isAlarm11Null != '0') {
      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(minBeforeFajr)
            ? minBeforeFajr
            : nextminBeforeFajr,
        6,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );

      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(minBeforeDhuhr)
            ? minBeforeDhuhr
            : nextminBeforeDhuhr,
        7,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );

      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(minBeforeAsr)
            ? minBeforeAsr
            : nextminBeforeAsr,
        8,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );

      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(minBeforeMaghrib)
            ? minBeforeMaghrib
            : nextminBeforeMaghrib,
        9,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );

      await AndroidAlarmManager.oneShotAt(
        DateTime.now().isBefore(minBeforeIsha)
            ? minBeforeIsha
            : nextminBeforeIsha,
        10,
        alarmClock: true,
        allowWhileIdle: true,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
        callback,
      );
    }
  }





  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> callback(int alarmId) async {
    // Show a notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: alarmId,
      channelKey: 'custom_sound',
      actionType: ActionType.Default,
      title: 'সালাতের সময় হয়েছে',
      body: (alarmId == 1)
          ? 'ফজরের সালাতের সময় হয়েছে'
          : (alarmId == 2)
              ? 'যোহরের সালাতের সময় হয়েছে'
              : (alarmId == 3)
                  ? 'আসরের সালাতের সময় হয়েছে'
                  : (alarmId == 4)
                      ? 'মাগরিবের সালাতের সময় হয়েছে'
                      : (alarmId == 5)
                          ? 'এশার সালাতের সময় হয়েছে'
                          : 'সালাতের সময় হয়েছে',
      color: Colors.white,
      wakeUpScreen: true,
      fullScreenIntent: true,
      // customSound: 'resource://raw/adhan',
    ));
  }

    // The callback for our durud
  @pragma('vm:entry-point')
  static Future<void> durudCallback(int alarmId) async {
    // Show a notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: alarmId,
      channelKey: 'durud_sound',
      actionType: ActionType.Default,
      title: 'সালাতের প্রস্তুতি নিন',
      body: (alarmId == 6)
          ? 'ফজরের সালাতের প্রস্তুতি নিন'
          : (alarmId == 7)
              ? 'যোহরের সালাতের প্রস্তুতি নিন'
              : (alarmId == 8)
                  ? 'আসরের সালাতের প্রস্তুতি নিন'
                  : (alarmId == 9)
                      ? 'মাগরিবের সালাতের প্রস্তুতি নিন'
                      : (alarmId == 10)
                          ? 'এশার সালাতের প্রস্তুতি নিন'
                          : 'সালাতের প্রস্তুতি নিন',
      color: Colors.white,
      wakeUpScreen: true,
      fullScreenIntent: true,
      // customSound: 'resource://raw/adhan',
    ));
  }

    // The background
  static SendPort? uiSendPort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_is_loading)
            ? const ProgressBar()
            : RefreshIndicator(
                onRefresh: () async {
                  _initializeHome();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 510,
                        child: Stack(children: [
                          Column(
                            children: [
                              Container(
                                height: 350,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/toprectangle.png'),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 35, 10, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'সালাতুল',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            '$_currentWakto',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'ওয়াক্ত শেষ $_currentWaktoTime',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'সালাতুল',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            '$_nextWakto',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'ওয়াক্ত শুরু $_nextWaktoTime',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 10, 0),
                                      child: Image.asset(
                                          'assets/icons/applogo.png'),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 240,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const ReadQuran()));
                                  },
                                  child: Image.asset(
                                    'assets/images/readQuranLogo.png',
                                    height: 220,
                                    width: 165,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const ReadQuran()));
                                      },
                                      child: Text(
                                        'পড়ুন',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const ReadQuran()));
                                      },
                                      child: Image.asset(
                                        'assets/icons/rightArrow.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: FeatureIcon(
                                  label: 'সালাতের সময়',
                                  iconPath: 'assets/icons/namaz_time.png',
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const NamazTime()));
                                  })),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: FeatureIcon(
                                  label: 'আয়াত',
                                  iconPath: 'assets/icons/ayat.png',
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const TodaysAyat()));
                                  })),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: FeatureIcon(
                                  label: 'তিলাওয়াত',
                                  iconPath: 'assets/icons/durud.png',
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const Tilawat()));
                                  })),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: FeatureIcon(
                                label: 'কিবলা',
                                iconPath: 'assets/icons/compass.png',
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const Kiblah()));
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FeatureIcon(
                              label: 'কোর্স সমূহ',
                              iconPath: 'assets/icons/book.png',
                              onPressed: () async {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Courses()));
                              }),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: FeatureIcon(
                                  label: 'ক্যালেন্ডার',
                                  iconPath: 'assets/icons/calendar.png',
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                CalendarTab()));
                                  })),
                          FeatureIcon(
                              label: 'দুরুদ',
                              iconPath: 'assets/icons/durud.png',
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Durud()));
                              }),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("ভিডিও",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            TextButton(
                                onPressed: () async {
                                  // print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                                  // // await getMap('bookprice').then((value) {
                                  // //   cartDetails.createMapFromSharedPreference(
                                  // //       value, 'bookprice');

                                  // // });
                                  // await cartDetails.initializeFromSharedPreferences();
                                  // print(cartDetails.bookAuthorCart);
                                  // print(cartDetails.bookList);

                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             CourseScreen(cat: null)));
                                },
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const VideoTabRepeat()));
                                  },
                                  child: Text("আরো দেখুন ->",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 228,
                          child: ListView.builder(
                            //shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  if (index == 0)
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  VideoForHome(
                                    videoDescription: videoDescription[index],
                                    videoImage: videoImage[index],
                                    videoTitle: videoTitle[index],
                                    videoUrl: videoUrl[index],
                                  ),
                                ],
                              );
                            },
                            itemCount: 5,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("বই পড়ুন",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             CourseScreen(cat: null)));
                                },
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const BookTabRepeat()));
                                  },
                                  child: Text("আরো দেখুন ->",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 300,
                          child: ListView.builder(
                            //shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  if (index == 0)
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ReadBook(
                                    bookName: bookName[index],
                                    bookImage: bookImage[index],
                                    author: authorName[index],
                                    bookPrice: bookPrice[index],
                                    prokashok: bookProkashoni[index],
                                    subject: bookSubject[index],
                                    translator: bookTranslator[index],
                                    coverType: bookCover[index],
                                    totalPage: bookTotalPage[index],
                                    bookEdition: bookEdition[index],
                                    bookLanguage: bookLanguage[index],
                                    bookDescription: bookDescription[index],
                                  ),
                                ],
                              );
                            },
                            itemCount: 4,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'একশব্দে কুরআন ফাউন্ডেশন',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'কুরআন শিক্ষা ফাউন্ডেশন’ গণপ্রজাতন্ত্রী বাংলাদেশ সরকারের বিধি মোতাবেক নিবন্ধিত একটি শিক্ষামূলক, গবেষণাধর্মী, সেবামূলক ও অরাজনৈতিক প্রতিষ্ঠান।',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  'https://youtube.com/playlist?list=PLtd0vnenjYmTbeagqYgWlTwnYOIyONOoW&si=DnNEFL_InlHATpQU');
                            },
                            child: Image.asset(
                              'assets/icons/youtube.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  'https://www.facebook.com/QuranChannelBD?mibextid=ZbWKwL');
                            },
                            child: Image.asset(
                              'assets/icons/facebook.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              launch('mailto:asqsfb@gmail.com');
                            },
                            child: Image.asset(
                              'assets/icons/email.png',
                              height: 50,
                              width: 50,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const Donate()));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Image.asset('assets/images/donate.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "হে ঈমানদারগণ! আমার দেয়া জীবিকা থেকে খরচ কর সেদিন আসার পূর্বে যেদিন কোন বিক্রয়, বন্ধুত্ব এবং সুপারিশ কাজে আসবে না। বস্তুতঃ কাফিরগণই অত্যাচারী।",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ইসলামের খেদমতে দান করুন ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/rightArrow.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
