import 'package:ek_shodbe_quran/component/namaz_time.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/sun_time.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
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
                                  'সালাতের সময়',
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'সালাতের সময়',
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
                            Expanded(
                              child: NamazWakto(
                                  imagePath: 'assets/images/fazar.png',
                                  waktoName: 'ফজর',
                                  alarmId: 1,
                                  alarmTime:
                                      namazTimeData.fajrTime ?? DateTime.now(),
                                  waktoTime: namazTimeData.fajr ?? ''),
                            ),
                            Expanded(
                              child: NamazWakto(
                                  imagePath: 'assets/images/johor.png',
                                  waktoName: 'যোহর',
                                  alarmId: 2,
                                  alarmTime:
                                      namazTimeData.dhuhrTime ?? DateTime.now(),
                                  waktoTime: namazTimeData.dhuhr ?? ''),
                            ),
                            Expanded(
                              child: NamazWakto(
                                  imagePath: 'assets/images/fazar.png',
                                  waktoName: 'আসর',
                                  alarmId: 3,
                                  alarmTime:
                                      namazTimeData.asrTime ?? DateTime.now(),
                                  waktoTime: namazTimeData.asr ?? ''),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: NamazWakto(
                                  imagePath: 'assets/images/magrib.png',
                                  waktoName: 'মাগরিব',
                                  alarmId: 4,
                                  alarmTime: namazTimeData.maghribTime ??
                                      DateTime.now(),
                                  waktoTime: namazTimeData.maghrib ?? ''),
                            ),
                            Expanded(
                              child: NamazWakto(
                                imagePath: 'assets/images/esha.png',
                                waktoName: 'এশা',
                                waktoTime: namazTimeData.isha ?? '',
                                alarmId: 5,
                                alarmTime:
                                    namazTimeData.ishaTime ?? DateTime.now(),
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: false, // Set visibility to false
                                child: NamazWakto(
                                  imagePath: 'assets/images/esha.png',
                                  waktoName: 'তাহাজ্জুদ',
                                  waktoTime: namazTimeData.fajr ?? '',
                                  alarmId: 6,
                                  alarmTime:
                                      namazTimeData.fajrTime ?? DateTime.now(),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'সেহেরী ও ইফতারের সময়',
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
                            Expanded(
                              child: SunTime(
                                imagePath: 'assets/images/seheri.png',
                                waktoName: 'সেহেরী',
                                waktoTime: DateFormat.jm().format(namazTimeData
                                    .fajrTime!
                                    .subtract(const Duration(minutes: 5))),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SunTime(
                                imagePath: 'assets/images/ifter.png',
                                waktoName: 'ইফতার',
                                waktoTime: namazTimeData.maghrib ?? '',
                                color: Colors.white,
                              ),
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
                            Expanded(
                              child: SunTime(
                                imagePath: 'assets/images/sunrise.png',
                                waktoName: 'সূর্যোদয়',
                                waktoTime: namazTimeData.sunrise ?? '',
                              ),
                            ),
                            Expanded(
                              child: SunTime(
                                imagePath: 'assets/images/sunset.png',
                                waktoName: 'সূর্যাস্ত',
                                waktoTime: namazTimeData.sunset ?? '',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
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
