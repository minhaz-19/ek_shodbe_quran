import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/contact_in_course_details.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
    required this.courseName,
    required this.coursePrice,
    required this.courseImage,
    required this.description,
  });

  final String courseName;
  final int coursePrice;
  final String courseImage;
  final String description;
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
              Image.asset('assets/images/${widget.courseImage}'),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${widget.courseName}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
               Text(
                '${widget.description}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  text: 'কোর্স ফি: ',
                  style: const TextStyle(
                    // fontSize: 16,
                    color: Colors.black, // Customize the color as needed
                  ),
                  children: [
                    TextSpan(
                      text: '${widget.coursePrice}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
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
