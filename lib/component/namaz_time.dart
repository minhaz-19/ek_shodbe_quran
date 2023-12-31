import 'package:adhan/adhan.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NamazWakto extends StatefulWidget {
  NamazWakto({
    super.key,
    required this.imagePath,
    required this.waktoName,
    required this.waktoTime,
    this.color = Colors.black,
  });

  final String imagePath;
  final String waktoName;
  final String waktoTime;
  var color;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  State<NamazWakto> createState() => _NamazWaktoState();
}

class _NamazWaktoState extends State<NamazWakto> {
  bool alarmIsSet = false;
  int alarmId = 0;
  @override
  void initState() {
    initializeAlarm();
    super.initState();
  }

  void initializeAlarm() async {
    setState(() {
      alarmId = (widget.waktoName == 'ফজর')
          ? 1
          : (widget.waktoName == 'যোহর')
              ? 2
              : (widget.waktoName == 'আসর')
                  ? 3
                  : (widget.waktoName == 'মাগরিব')
                      ? 4
                      : (widget.waktoName == 'এশা')
                          ? 5
                          : 6;
    });
    await getDataFromDevice(alarmId.toString()).then((value) {
      if (value != null) {
        setState(() {
          alarmIsSet = true;
        });
      } else {
        setState(() {
          alarmIsSet = false;
        });
      }
    });
  }

  static dynamic _periodicTaskCallback(int alarmId) async {
    // Show a notification
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

    DateTime _faazar_time = DateTime.now();
    DateTime _johor_time = DateTime.now();
    DateTime _asor_time = DateTime.now();
    DateTime _magrib_time = DateTime.now();
    DateTime _esha_time = DateTime.now();

    await getDataFromDevice('current longitude').then((longitude) async {
      await getDataFromDevice('current latitude').then((latitude) async {
        final myCoordinates = Coordinates(double.parse(latitude.toString()),
            double.parse(longitude.toString()));
        final params = CalculationMethod.karachi.getParameters();
        params.madhab = Madhab.hanafi;
        final prayerTimes = PrayerTimes.today(myCoordinates, params);

        _faazar_time = prayerTimes.fajr;
        _johor_time = prayerTimes.dhuhr;
        _asor_time = prayerTimes.asr;
        _magrib_time = prayerTimes.maghrib;
        _esha_time = prayerTimes.isha;
      });
    });

    Duration duration = const Duration(hours: 23);
    await AndroidAlarmManager.periodic(
      duration,
      alarmId,
      _periodicTaskCallback, // Pass the function reference without calling it
      wakeup: true,
      rescheduleOnReboot: true,
      exact: true,
      allowWhileIdle: true,
      startAt: (alarmId == 1)
          ? _faazar_time
          : (alarmId == 2)
              ? _johor_time
              : (alarmId == 3)
                  ? _asor_time
                  : (alarmId == 4)
                      ? _magrib_time
                      : (alarmId == 5)
                          ? _esha_time
                          : _faazar_time,
    );
  }

  void _schedulePeriodicAlarm(int alarmId) async {
    var namazTimeData = Provider.of<NamazTimeProvider>(context, listen: false);
    Duration duration = const Duration(hours: 23);
    await AndroidAlarmManager.periodic(
      duration,
      alarmId,
      _periodicTaskCallback, // Pass the function reference without calling it
      wakeup: true,
      rescheduleOnReboot: true,
      exact: true,
      allowWhileIdle: true,
      startAt: (alarmId == 1)
          ? namazTimeData.fajrTime
          : (alarmId == 2)
              ? namazTimeData.dhuhrTime
              : (alarmId == 3)
                  ? namazTimeData.asrTime
                  : (alarmId == 4)
                      ? namazTimeData.maghribTime
                      : (alarmId == 5)
                          ? namazTimeData.ishaTime
                          : namazTimeData.sunriseTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
    return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11),
              child: Row(
                children: [
                  Text(
                    widget.waktoName,
                    style: TextStyle(
                        color: widget.color,
                        fontSize: (widget.waktoName == 'তাহাজ্জুদ') ? 15 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      (alarmIsSet)
                          ? {
                              await AndroidAlarmManager.cancel(alarmId),

                              await removeDataFromDevice(alarmId.toString()),
                              setState(() {
                                alarmIsSet = false;
                              }),
                              // Fluttertoast.showToast(msg: alarmId.toString()),
                              Fluttertoast.showToast(
                                  msg: 'অ্যালার্ম বন্ধ করা হয়েছে'),
                            }
                          : {
                              _schedulePeriodicAlarm(alarmId),
                              await saveDataToDevice('current latitude',
                                  '${locationData.latitude}'),
                              await saveDataToDevice('current longitude',
                                  '${locationData.longitude}'),
                              await saveDataToDevice(
                                  alarmId.toString(), alarmId.toString()),
                              setState(() {
                                alarmIsSet = true;
                              }),
                              // Fluttertoast.showToast(msg: alarmId.toString()),
                              Fluttertoast.showToast(
                                  msg: 'অ্যালার্ম সেট করা হয়েছে')
                            };
                    },
                    child: ImageIcon(
                      AssetImage(
                        'assets/icons/alarm.png',
                      ),
                      color: (alarmIsSet) ? Colors.pink : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(11),
              child: Text(
                widget.waktoTime,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
