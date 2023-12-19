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
      body: SingleChildScrollView(child: Column(children: [

      ],),)
    );
  }
}