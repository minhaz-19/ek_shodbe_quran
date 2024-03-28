import 'dart:isolate';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/main.dart';
import 'package:ek_shodbe_quran/notification_controller.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:flutter/material.dart';
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

  @override
  State<NamazWakto> createState() => _NamazWaktoState();
}

class _NamazWaktoState extends State<NamazWakto> {
  bool alarmIsSet = false;
  DateTime newTime = DateTime.now();

  static get developer => null;

  @override
  void initState() {
    // print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    AndroidAlarmManager.initialize();
    _initializeAlarm();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  void _initializeAlarm() async {
    final prefs = await SharedPreferences.getInstance();
    final String isAlarmNull = prefs.getString('${widget.alarmId}') ?? '0';
    // print('Reaching here %%%%%%%%%%%%%%%%%%%%%%% id: ${widget.alarmId}');
    if (isAlarmNull == '0') {
      // print('Now here %%%%%%%%%%%%%%%%%%%%%%% id: ${widget.alarmId}');
      setState(() {
        alarmIsSet = false;
      });
    } else {
      // print('################################################');
      // print('Alarm Id: ${widget.alarmId}');
      // DateTime scheduledTime = DateTime.parse(isAlarmNull);
      // print(
      //     'Scheduled Alarm Time: $scheduledTime'); // Print scheduled alarm time for debugging
      // print('Expected Alarm Time: ${widget.alarmTime}');
      // print('Time remaining: ${scheduledTime.difference(DateTime.now())}');

      setState(() {
        alarmIsSet = true;
      });
    }
  }

  // The background
  static SendPort? uiSendPort;

  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> callback(int alarmId) async {
    // Show a notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: alarmId,
      channelKey: alarmId==1? 'fazr_sound' : 'custom_sound',
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

    await saveDataToDevice(
        alarmId.toString(), '$alarmId'); // Save the new alarm time

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
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
                                AndroidAlarmManager.cancel(widget.alarmId),
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

                                setState(() {
                                  alarmIsSet = true;
                                }),

                                // Fluttertoast.showToast(msg: alarmId.toString()),

                                if (widget.alarmTime.isBefore(DateTime.now()))
                                  {
                                    // If alarm time has already passed, set the alarm for the next day
                                    setState(() {
                                      newTime = widget.alarmTime
                                          .add(const Duration(days: 1));
                                    }),
                                    await saveDataToDevice(
                                        widget.alarmId.toString(), '$newTime'),
                                    await AndroidAlarmManager.oneShotAt(
                                      newTime,
                                      widget.alarmId,
                                      callback,
                                    )
                                  }
                                else
                                  {
                                    await saveDataToDevice(
                                        widget.alarmId.toString(),
                                        '${widget.alarmTime}'),
                                    // If alarm time is in the future, set the alarm normally
                                    await AndroidAlarmManager.oneShotAt(
                                      widget.alarmTime,
                                      widget.alarmId,
                                      alarmClock: true,
                                      allowWhileIdle: true,
                                      exact: true,
                                      wakeup: true,
                                      rescheduleOnReboot: true,
                                      callback,
                                    )
                                  },

                                Fluttertoast.showToast(
                                    msg: 'অ্যালার্ম সেট করা হয়েছে'),
                              };
                      },
                      child: ImageIcon(
                        const AssetImage(
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
