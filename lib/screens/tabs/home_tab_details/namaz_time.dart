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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
              children: [
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
