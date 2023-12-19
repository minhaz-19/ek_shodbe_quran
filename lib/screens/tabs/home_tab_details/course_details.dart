import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/contact_in_course_details.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
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
          title: const Text('কোর্স সমূহ'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset('assets/images/toprectangle.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'মৌলিক আরবি ভাষা',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'আমাদের মেন্টরশিপ প্রোগ্রামের সাথে আপনার সম্ভাবনা আনলক করুন। মূল্যবান অন্তর্দৃষ্টি, ব্যক্তিগতকৃত নির্দেশিকা এবং শিল্প সংযোগ লাভ করুন। নতুন সুযোগ আনলক করুন, আপনার বৃদ্ধি ত্বরান্বিত করুন এবং আপনার লক্ষ্য অর্জন করুন। এখন আমাদের সাথে যোগ দিন এবং সাফল্যের দিকে আপনার যাত্রা শুরু করুন!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text.rich(
                TextSpan(
                  text: 'কোর্স ফি: ',
                  style: TextStyle(
                    // fontSize: 16,
                    color: Colors.black, // Customize the color as needed
                  ),
                  children: [
                    TextSpan(
                      text: '1850',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' টাকা',
                      style: TextStyle(
                        // fontSize: 16,
                        color: Colors.black, // Customize the color as needed
                      ),
                    ),
                  ],
                ),
              ),
              //  const Spacer(),
              const SizedBox(
                height: 100,
              ),
              WideButton(
                'যোগাযোগ',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactInCourseDetails()));
                },
                backgroundcolor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )));
  }
}
