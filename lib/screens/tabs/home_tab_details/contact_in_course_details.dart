import 'package:flutter/material.dart';

class ContactInCourseDetails extends StatefulWidget {
  const ContactInCourseDetails({super.key});

  @override
  State<ContactInCourseDetails> createState() => _ContactInCourseDetailsState();
}

class _ContactInCourseDetailsState extends State<ContactInCourseDetails> {
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
          title: const Text('যোগাযোগ'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 10, 0),
                child: ImageIcon(
                  const AssetImage('assets/icons/address.png'),
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ঠিকানা',
                        style: TextStyle(
                            // fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '131, Aronno Talaimari',
                      ),
                      Text(
                        'Square, Rajshahi-6206',
                      ),
                    ],
                  )),
            ]),
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 10, 0),
                child: ImageIcon(
                  const AssetImage('assets/icons/phone.png'),
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'মোবাইল',
                        style: TextStyle(
                            // fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '02588867203',
                      ),
                    ],
                  )),
            ]),
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 10, 0),
                child: ImageIcon(
                  const AssetImage('assets/icons/email2.png'),
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ইমেইল',
                        style: TextStyle(
                            // fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'eksobdequran.yt@gmail.com',
                      ),
                    ],
                  )),
            ]),
          ],
        )));
  }
}
