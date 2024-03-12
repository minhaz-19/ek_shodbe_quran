import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/main.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamazWakto extends StatefulWidget {
  NamazWakto({
    super.key,
    required this.imagePath,
    required this.waktoName,
    required this.waktoTime,
    required this.alarmTime,
    required this.alarmId,
    this.color = Colors.black,
  });

  final String imagePath;
  final String waktoName;
  final String waktoTime;
  final DateTime alarmTime;
  final int alarmId;
  var color;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  State<NamazWakto> createState() => _NamazWaktoState();
}

class _NamazWaktoState extends State<NamazWakto> {
  bool alarmIsSet = false;

  static get developer => null;

  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();
    _initializeAlarm();
  }

  void _initializeAlarm() async {
    final prefs = await SharedPreferences.getInstance();
    final String isAlarmNull = prefs.getString('${widget.alarmId}') ?? '0';
    if (isAlarmNull == '0') {
      setState(() {
        alarmIsSet = false;
      });
    } else {
      if (DateTime.now().isBefore(DateTime.parse(isAlarmNull))) {
        setState(() {
          alarmIsSet = true;
        });
      } else {
        await removeDataFromDevice(widget.alarmId.toString());
        setState(() {
          alarmIsSet = false;
        });
      }
    }
  }

  // The background
  static SendPort? uiSendPort;

  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> callback(int alarmId) async {
    developer.log('Alarm fired!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    // Get the previous cached count and increment it.

    // Show a notification
    await NamazWakto.flutterLocalNotificationsPlugin.show(
      alarmId,
      'সালাতের সময় হয়েছে',
      (alarmId == 1)
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
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          fullScreenIntent: true,
          visibility: NotificationVisibility.public,
          // sound: RawResourceAndroidNotificationSound('al'),
          enableVibration: true,
          enableLights: true,
          icon: '@mipmap/launcher_icon',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        ),
      ),
    );

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
    var namazTimeData = Provider.of<NamazTimeProvider>(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        // (alarmIsSet)
                        //     ? {
                        //         await removeDataFromDevice(
                        //             widget.alarmId.toString()),
                        //         setState(() {
                        //           alarmIsSet = false;
                        //         }),
                        //         // Fluttertoast.showToast(msg: alarmId.toString()),
                        //         Fluttertoast.showToast(
                        //             msg: 'অ্যালার্ম বন্ধ করা হয়েছে'),
                        //       }
                        //     : {
                        //         await saveDataToDevice('current latitude',
                        //             '${locationData.latitude}'),
                        //         await saveDataToDevice('current longitude',
                        //             '${locationData.longitude}'),
                        //         await saveDataToDevice(
                        //             widget.alarmId.toString(),
                        //             '${namazTimeData.namazTimeBasedOnAlarmId(widget.alarmId)}'),
                        //         setState(() {
                        //           alarmIsSet = true;
                        //         }),
                        //         // Fluttertoast.showToast(msg: alarmId.toString()),
                        //         if (widget.alarmTime.isBefore(DateTime.now()))
                        //           {
                        //             await AndroidAlarmManager.oneShotAt(
                        //                 widget.alarmTime.add(Duration(days: 1)),
                        //                 widget.alarmId,
                        //                 callback),
                        //           }
                        //         else
                        //           {
                        //             await AndroidAlarmManager.oneShotAt(
                        //                 widget.alarmTime,
                        //                 widget.alarmId,
                        //                 alarmClock: true,
                        //                 allowWhileIdle: true,
                        //                 exact: true,
                        //                 wakeup: true,
                        //                 rescheduleOnReboot: true,
                        //                 callback),
                        //           },

                        //         Fluttertoast.showToast(
                        //             msg: 'অ্যালার্ম সেট করা হয়েছে')
                        //       };

                        Fluttertoast.showToast(msg: 'এটি শীঘ্রই সংযুক্ত করা হবে');
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
          )),
    );
  }
}
