import 'package:adhan/adhan.dart';
import 'package:ek_shodbe_quran/component/namaz_time.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/sun_time.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class NamazTime extends StatefulWidget {
  const NamazTime({super.key});

  @override
  State<NamazTime> createState() => _NamazTimeState();
}

class _NamazTimeState extends State<NamazTime> {
  bool _is_loading = false;
  var _current_latitude;
  var _current_longitude;
  Position? _current_position;
  String? _locality;
  String? _subLocality;
  String? _country;
  var _faazar_time;
  var _johor_time;
  var _asor_time;
  var _magrib_time;
  var _esha_time;
  var _tahajjud_time;
  var _sunrise_time;
  var _sunset_time;
  List<Placemark> placemarks = [];

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future _get_location() async {
    setState(() {
      _is_loading = true;
    });
    _current_position = await _determinePosition();
    setState(() {
      _current_latitude = _current_position!.latitude;
      _current_longitude = _current_position!.longitude;
    });
    placemarks =
        await placemarkFromCoordinates(_current_latitude, _current_longitude);

    setState(() {
      _locality = placemarks[0].locality;

      _subLocality = placemarks[0].subLocality;
      _is_loading = false;
    });
  }

  @override
  void initState() {
    initializeNamazTime();
    super.initState();
  }

  void initializeNamazTime() async {
    await _get_location().then((value) {
      setState(() {
        _locality = placemarks[0].locality;
        _subLocality = placemarks[0].subLocality;
        _country = placemarks[0].country;
      });

      final myCoordinates = Coordinates(_current_latitude,
          _current_longitude); // Replace with your own location lat, lng.
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);

      _faazar_time = DateFormat.jm().format(prayerTimes.fajr);
      _johor_time = DateFormat.jm().format(prayerTimes.dhuhr);
      _asor_time = DateFormat.jm().format(prayerTimes.asr);
      _magrib_time = DateFormat.jm().format(prayerTimes.maghrib);
      _esha_time = DateFormat.jm().format(prayerTimes.isha);
      // _tahajjud_time = DateFormat.jm().format(prayerTimes.);
      _sunrise_time = DateFormat.jm().format(prayerTimes.sunrise);
      final DateFormat format = DateFormat.jm();
      DateTime responseDateTime = format.parse(_magrib_time);

      // Subtract one minute
      responseDateTime = responseDateTime.subtract(Duration(minutes: 1));

      // Format the adjusted time for display
      String adjustedTime = format.format(responseDateTime);
      _sunset_time = adjustedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_is_loading)
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
                                  (_country == null)
                                      ? 'লোকেশন পাওয়া যায়নি'
                                      : (_subLocality != "")
                                          ? "$_subLocality, $_locality, $_country"
                                          : '$_locality, $_country',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
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
                                waktoTime: _faazar_time ?? ''),
                            NamazWakto(
                                imagePath: 'assets/images/johor.png',
                                waktoName: 'যোহর',
                                waktoTime: _johor_time ?? ''),
                            NamazWakto(
                                imagePath: 'assets/images/fazar.png',
                                waktoName: 'আসর',
                                waktoTime: _asor_time ?? ''),
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
                                waktoTime: _magrib_time ?? ''),
                            NamazWakto(
                              imagePath: 'assets/images/esha.png',
                              waktoName: 'এশা',
                              waktoTime: _esha_time ?? '',
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
                                waktoTime: _sunrise_time ?? ''),
                            SunTime(
                              imagePath: 'assets/images/sunset.png',
                              waktoName: 'সূর্যাস্ত',
                              waktoTime: _sunset_time ?? '',
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
