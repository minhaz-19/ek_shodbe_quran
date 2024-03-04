import 'package:ek_shodbe_quran/screens/videoPlayBack.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  const Video({super.key,
    required this.videoDescription,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoImage,});
  // final CourseContents coursecontent;
  final String videoDescription;
  final String videoUrl;
  final String videoTitle;
  final String videoImage;
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => PlayVideoFromYoutube(videoDescription:widget.videoDescription,videoTitle: widget.videoTitle,videoUrl: widget.videoUrl),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        width: 250,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the desired border radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(widget.videoImage),
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.videoDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
