import 'package:flutter/material.dart';

class TodaysAyat extends StatefulWidget {
  const TodaysAyat({super.key});

  @override
  State<TodaysAyat> createState() => _TodaysAyatState();
}

class _TodaysAyatState extends State<TodaysAyat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
              'assets/images/toprectangle.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        foregroundColor: Colors.white,
        title: const Text('আজকের আয়াত'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ٱلْحَمْدُ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '"সমস্ত প্রশংসা বিশ্বজাহানের পালনকর্তা আল্লাহর জন্য"',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'সূরা আল ফাতিহা, আয়াত - ১',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
