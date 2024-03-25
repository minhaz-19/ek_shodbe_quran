import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Durud extends StatefulWidget {
  const Durud({super.key});

  @override
  State<Durud> createState() => _DurudState();
}

class _DurudState extends State<Durud> {
  bool _on = false;
  bool _loading = false;
  @override
  void initState() {
    _initializeDurud();

    super.initState();
  }

  void _initializeDurud() async {
    setState(() {
      _loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final String isAlarmNull = prefs.getString('11') ?? '0';
    if (isAlarmNull == '0') {
      setState(() {
        _on = false;
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
        _on = true;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: _loading
          ? const ProgressBar()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/toprectangle.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        16.0), // Adjust the left padding as needed
                                child:
                                    Icon(Icons.arrow_back, color: Colors.white),
                              ),
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'দরুদ',
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Image(
                                  image:
                                      AssetImage('assets/icons/location.png'),
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (locationData.locality == "")
                                      ? "${locationData.country}"
                                      : (locationData.subLocality == "")
                                          ? "${locationData.locality}, ${locationData.country}"
                                          : "${locationData.subLocality}, ${locationData.locality}, ${locationData.country}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const PickLocation(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor),
                                  child: const Text(
                                    'পরিবর্তন',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'আপনার লোকেশন এর উপর ভিত্তি করে দিন এর বেশ কিছু সময় আপনাকে রসুল (সাঃ) প্রতি দরুদ পাঠ করে শোনাবে ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('বন্ধ',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_on) {
                                  AndroidAlarmManager.cancel(11);
                                  await removeDataFromDevice('11');
                                  setState(() {
                                    _on = false;
                                  });
                                  // Fluttertoast.showToast(msg: alarmId.toString()),
                                  Fluttertoast.showToast(
                                      msg: 'দরুদ বন্ধ করা হয়েছে');
                                } else {
                                  await saveDataToDevice('11', '11');
                                  setState(() {
                                    _on = true;
                                  });

                                  Fluttertoast.showToast(
                                      msg: 'দরুদ চালু করা হয়েছে');
                                }
                              },
                              child: Container(
                                width: 60,
                                height: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      if (_on) const Spacer(),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      if (!_on) const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('চালু',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
