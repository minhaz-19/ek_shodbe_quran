import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:ek_shodbe_quran/component/namaz_time.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/sun_time.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class NamazTime extends StatefulWidget {
  const NamazTime({super.key});

  @override
  State<NamazTime> createState() => _NamazTimeState();
}

class _NamazTimeState extends State<NamazTime> {
  bool _is_loading = false;

  List<Placemark> placemarks = [];

  @override
  void initState() {
    // initializeNamazTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
    var namazTimeData = Provider.of<NamazTimeProvider>(context);
    return Scaffold(
      body: (_is_loading)
          ? const ProgressBar()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 348,
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
                                  'নামাজের সময়',
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
                                  (locationData.subLocality != "")
                                      ? "${locationData.subLocality}, ${locationData.locality}, ${locationData.country}"
                                      : '${locationData.locality}, ${locationData.country}',
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'নামাজের সময়',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NamazWakto(
                                imagePath: 'assets/images/fazar.png',
                                waktoName: 'ফজর',
                                waktoTime: namazTimeData.fajr ?? ''),
                            NamazWakto(
                                imagePath: 'assets/images/johor.png',
                                waktoName: 'যোহর',
                                waktoTime: namazTimeData.dhuhr ?? ''),
                            NamazWakto(
                                imagePath: 'assets/images/fazar.png',
                                waktoName: 'আসর',
                                waktoTime: namazTimeData.asr ?? ''),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NamazWakto(
                                imagePath: 'assets/images/magrib.png',
                                waktoName: 'মাগরিব',
                                waktoTime: namazTimeData.maghrib ?? ''),
                            NamazWakto(
                              imagePath: 'assets/images/esha.png',
                              waktoName: 'এশা',
                              waktoTime: namazTimeData.isha ?? '',
                              color: Colors.white,
                            ),
                            Container(
                              height: 120,
                              width: 120,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'সূর্যোদয় এবং সূর্যাস্ত',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SunTime(
                                imagePath: 'assets/images/sunrise.png',
                                waktoName: 'সূর্যোদয়',
                                waktoTime: namazTimeData.sunrise ?? ''),
                            SunTime(
                              imagePath: 'assets/images/sunset.png',
                              waktoName: 'সূর্যাস্ত',
                              waktoTime: namazTimeData.sunset ?? '',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
