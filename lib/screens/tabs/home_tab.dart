import 'package:adhan/adhan.dart';
import 'package:ek_shodbe_quran/component/feature_icon.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/component/video.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/calendar.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/read_quran.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/courses.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/donate.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/durud.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/kiblah.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/namaz_time.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/todays_ayat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String uid = '';
  String name = '';
  String email = '';
  bool _is_loading = false;
  List<Placemark> placemarks = [];

  @override
  void initState() {
    setState(() {
      uid = UserDetailsProvider().getId();
      name = UserDetailsProvider().getName();
      email = UserDetailsProvider().getEmail();
    });

    super.initState();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var namazTimeData = Provider.of<NamazTimeProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
        body: (_is_loading)
            ? const ProgressBar()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 340,
                      child: Stack(children: [
                        Column(
                          children: [
                            Container(
                              height: 280,
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
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 35, 10, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'সালাতুল',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'মাগরিব ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'ওয়াক্ত শেষ 6:00 PM',
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
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'ঈশা ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'ওয়াক্ত শুরু 6:00 PM',
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child:
                                        Image.asset('assets/icons/applogo.png'),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: 255,
                            left: 0,
                            right: 0,
                            child: WideButton(
                              'আল-কুরআন পড়ুন',
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReadQuran()));
                              },
                              backgroundcolor: const Color(0xFF007C49),
                              padding: MediaQuery.of(context).size.width * 0.25,
                            )),
                      ]),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: FeatureIcon(
                                label: 'নামাজের সময়',
                                iconPath: 'assets/icons/namaz_time.png',
                                onPressed: () async {
                                  await getDataFromDevice('current latitude')
                                      .then((value) async {
                                    if (value == null) {
                                      setState(() {
                                        locationData.locality = 'Jashore';
                                        locationData.subLocality =
                                            'Jashore Zilla School';
                                        locationData.country = 'Bangladesh';
                                        locationData.setLocation(
                                          23.160969261812728,
                                          89.20574491067016,
                                        );
                                      });
                                    } else {
                                      await getDataFromDevice(
                                              'current longitude')
                                          .then((longitude) async {
                                        await getDataFromDevice(
                                                'current latitude')
                                            .then((latitude) {
                                          locationData.setLocation(
                                              double.parse(latitude.toString()),
                                              double.parse(
                                                  longitude.toString()));
                                        });

                                        placemarks =
                                            await placemarkFromCoordinates(
                                                locationData.latitude,
                                                locationData.longitude);
                                      });

                                      locationData.setAddress(
                                          placemarks[0].subLocality.toString(),
                                          placemarks[0].locality.toString(),
                                          placemarks[0].country.toString());
                                    }
                                  });

                                  final myCoordinates = Coordinates(
                                      locationData.latitude,
                                      locationData.longitude);
                                  final params =
                                      CalculationMethod.karachi.getParameters();
                                  params.madhab = Madhab.hanafi;
                                  final prayerTimes =
                                      PrayerTimes.today(myCoordinates, params);

                                  var _faazar_time =
                                      DateFormat.jm().format(prayerTimes.fajr);
                                  var _johor_time =
                                      DateFormat.jm().format(prayerTimes.dhuhr);
                                  var _asor_time =
                                      DateFormat.jm().format(prayerTimes.asr);
                                  var _magrib_time = DateFormat.jm()
                                      .format(prayerTimes.maghrib);
                                  var _esha_time =
                                      DateFormat.jm().format(prayerTimes.isha);
                                  // _tahajjud_time = DateFormat.jm().format(prayerTimes.);
                                  var _sunrise_time = DateFormat.jm()
                                      .format(prayerTimes.sunrise);
                                  final DateFormat format = DateFormat.jm();
                                  DateTime responseDateTime =
                                      format.parse(_magrib_time);

                                  // Subtract one minute
                                  responseDateTime = responseDateTime
                                      .subtract(Duration(minutes: 1));

                                  // Format the adjusted time for display
                                  String adjustedTime =
                                      format.format(responseDateTime);
                                  var _sunset_time = adjustedTime;

                                  namazTimeData.setNamazTime(
                                      _faazar_time,
                                      _johor_time,
                                      _asor_time,
                                      _magrib_time,
                                      _esha_time,
                                      _sunrise_time,
                                      _sunset_time);

                                  namazTimeData.setNamazTimeDateTime(
                                      prayerTimes.fajr,
                                      prayerTimes.dhuhr,
                                      prayerTimes.asr,
                                      prayerTimes.maghrib,
                                      prayerTimes.isha,
                                      prayerTimes.sunrise
                                  );

                                  setState(() {
                                    _is_loading = false;
                                  });
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
                                onPressed: () {})),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: FeatureIcon(
                              label: 'কিবলা',
                              iconPath: 'assets/icons/compass.png',
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Kiblah()));
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
                            onPressed: () {
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
                                          builder: (context) => CalendarTab()));
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
                    const SizedBox(
                      height: 20,
                    ),
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
                              child: Text("আরো দেখুন ->",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)))
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 250,
                        child: ListView.builder(
                          //shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Video();
                          },
                          itemCount: 10,
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
                              child: Text("আরো দেখুন ->",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)))
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 250,
                        child: ListView.builder(
                          //shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ReadBook();
                          },
                          itemCount: 10,
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'এক শব্দে কুরআন ফাউন্ডেশন',
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
                        'ইসলামিক সঙ্গীতে স্বাগতম, ইসলামের পথে আপনার আধ্যাত্মিক যাত্রাকে সমর্থন করার জন্য প্রেম এবং ভক্তি দিয়ে তৈরি একটি উত্সর্গীকৃত প্ল্যাটফর্ম। আমাদের লক্ষ্য হল বিশ্বব্যাপী মুসলমানদের জন্য একটি ব্যাপক এবং অ্যাক্সেসযোগ্য সংস্থান প্রদান করা, তাদের বিশ্বাস, জ্ঞান এবং অনুশীলনকে শক্তিশালী করতে সক্ষম করে।',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/youtube.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/icons/facebook.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/icons/email.png',
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset('assets/images/donate.png'),
                          ),
                          Text(
                            'ইসলামের খেদমতে দান করুন ->',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _launchURL('https://niharon.com/');
                      },
                      child: Column(
                        children: [
                          Text(
                            'This Application is Developed by',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            // width: MediaQuery.of(context).size.width * 0.7,
                            child: Image.asset(
                              'assets/images/niharon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
