import 'dart:ffi';

import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        drawer: const drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 35, 10, 0),
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
                        backgroundcolor: Color(0xFF007C49),
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
                        Text(
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
                        Text(
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
                        Text(
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
                        Text(
                          'কিবলা',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
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
                          child: Image.asset('assets/icons/book.png'),
                        ),
                        Text(
                          'কোর্স সমূহ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
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
                        Text(
                          'ক্যালেন্ডার',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
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
                        Text(
                          'দুরুদ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ],
          ),
        ));
  }
}
