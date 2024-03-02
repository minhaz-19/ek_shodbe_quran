import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/course_details.dart';
import 'package:flutter/material.dart';

class CoursesWidget extends StatefulWidget {
  const CoursesWidget(
      {super.key,
      required this.courseImage,
      required this.courseName,
      required this.coursePrice,
      required this.description});
  // final CourseContents coursecontent;
  final String courseName;
  final int coursePrice;
  final String courseImage;
  final String description;
  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CourseDetails( courseName: widget.courseName, coursePrice: widget.coursePrice, courseImage: widget.courseImage, description: widget.description,)));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the desired border radius
          ),
          color: Colors.green[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/images/${widget.courseImage}'),
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Text('${widget.courseName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                child: Text(
                  'কোর্স ফি: ${widget.coursePrice} টাকা',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
