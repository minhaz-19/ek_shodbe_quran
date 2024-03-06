import 'dart:isolate';
import 'dart:ui';

import 'package:adhan/adhan.dart';
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
    required this.alarmId,
    this.color = Colors.black,
  });

  final String imagePath;
  final String waktoName;
  final String waktoTime;
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
  static Future<void> callback() async {
    developer.log('Alarm fired!');
    // Get the previous cached count and increment it.

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
                        (alarmIsSet)
                            ? {
                                await removeDataFromDevice(
                                    widget.alarmId.toString()),
                                setState(() {
                                  alarmIsSet = false;
                                }),
                                // Fluttertoast.showToast(msg: alarmId.toString()),
                                Fluttertoast.showToast(
                                    msg: 'অ্যালার্ম বন্ধ করা হয়েছে'),
                              }
                            : {
                                await saveDataToDevice('current latitude',
                                    '${locationData.latitude}'),
                                await saveDataToDevice('current longitude',
                                    '${locationData.longitude}'),
                                await saveDataToDevice(
                                    widget.alarmId.toString(),
                                    '${namazTimeData.namazTimeBasedOnAlarmId(widget.alarmId)}'),
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
          )),
    );
  }
}
