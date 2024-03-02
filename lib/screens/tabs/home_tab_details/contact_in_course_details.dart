import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        'একশব্দে কুরআন শিক্ষা ফাউন্ডেশন',
                      ),
                      Text(
                        'উত্তরা, ঢাকা।',
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
                        '01715125125',
                      ),
                      Text(
                        '01976125125',
                      ),
                      Text(
                        '01975125125',
                      ),
                    ],
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: InkWell(
                    onTap: () {
                      launch('tel:01715125125');
                    },
                    child: const Icon(Icons.call)),
              ),
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
                        'asqsfb@gmail.com',
                      ),
                    ],
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: InkWell(
                    onTap: () {
                      launch('mailto:asqsfb@gmail.com');
                    },
                    child: const Icon(Icons.email)),
              ),
            ]),
          ],
        )));
  }
}
