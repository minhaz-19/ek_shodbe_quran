import 'package:ek_shodbe_quran/component/namaz_time.dart';
import 'package:ek_shodbe_quran/component/sun_time.dart';
import 'package:flutter/material.dart';

class NamazTime extends StatefulWidget {
  const NamazTime({super.key});

  @override
  State<NamazTime> createState() => _NamazTimeState();
}

class _NamazTimeState extends State<NamazTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('নামাজের সময়'),
        flexibleSpace: const Image(
          image: AssetImage(
              'assets/images/toprectangle.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(240),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/icons/location.png'),
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'খিলগাঁও, ঢাকা, বাংলাদেশ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'পরিবর্তন',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor)),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'নামাজের সময়',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NamazWakto(
                      imagePath: 'assets/images/fazar.png',
                      waktoName: 'ফজর',
                      waktoTime: '4:30 AM'),
                  NamazWakto(
                      imagePath: 'assets/images/johor.png',
                      waktoName: 'যোহর',
                      waktoTime: '12:30 PM'),
                  NamazWakto(
                      imagePath: 'assets/images/fazar.png',
                      waktoName: 'আসর',
                      waktoTime: '4:30 PM'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NamazWakto(
                      imagePath: 'assets/images/magrib.png',
                      waktoName: 'মাগরিব',
                      waktoTime: '6:30 PM'),
                  NamazWakto(
                    imagePath: 'assets/images/esha.png',
                    waktoName: 'এশা',
                    waktoTime: '8:30 PM',
                    color: Colors.white,
                  ),
                  NamazWakto(
                    imagePath: 'assets/images/esha.png',
                    waktoName: 'তাহাজ্জুদ',
                    waktoTime: '4:30 PM',
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'সূর্যোদয় এবং সূর্যাস্ত',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SunTime(
                      imagePath: 'assets/images/sunrise.png',
                      waktoName: 'সূর্যোদয়',
                      waktoTime: '6:30 AM'),
                  SunTime(
                    imagePath: 'assets/images/sunset.png',
                    waktoName: 'সূর্যাস্ত',
                    waktoTime: '6:30 PM',
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
