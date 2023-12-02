import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:ek_shodbe_quran/component/video.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String uid = '';
  String name = '';
  String email = '';

  @override
  void initState() {
    setState(() {
      uid = UserDetailsProvider().getId();
      name = UserDetailsProvider().getName();
      email = UserDetailsProvider().getEmail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                            image: AssetImage('assets/images/toprectangle.png'),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                          child: Image.asset('assets/icons/applogo.png'),
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
                    'Read Quran',
                    onPressed: () {},
                    backgroundcolor: const Color(0xFF007C49),
                    padding: MediaQuery.of(context).size.width * 0.25,
                  )),
            ]),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/icons/namaz_time.png'),
                    ),
                    const Text(
                      'নামাজের সময়',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/icons/ayat.png'),
                    ),
                    const Text(
                      ' আয়াত',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/icons/durud.png'),
                    ),
                    const Text(
                      'তিলাওয়াত',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/icons/compass.png'),
                    ),
                    const Text(
                      'কিবলা',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset('assets/icons/book.png'),
                  ),
                  const Text(
                    'কোর্স সমূহ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset('assets/icons/calendar.png'),
                    ),
                    const Text(
                      'ক্যালেন্ডার',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset('assets/icons/durud.png'),
                  ),
                  const Text(
                    'দুরুদ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
          Column(
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
          Column(
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
        ],
      ),
    ));
  }
}
