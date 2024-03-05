import 'package:ek_shodbe_quran/component/video.dart';
import 'package:ek_shodbe_quran/screens/tabs/bookdetails_from_authors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  List<String> videoTitle = VideoDetailsFromAuthor.videoTitle;
  List<String> videoDescription = VideoDetailsFromAuthor.videoDescription;
  List<String> videoImage = VideoDetailsFromAuthor.videoImage;
  List<String> videoUrl = VideoDetailsFromAuthor.videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
              child: Text("কুরআন শিখুন",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                height: 251,
                child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Video(
                      videoDescription: videoDescription[index],
                      videoImage: videoImage[index],
                      videoTitle: videoTitle[index],
                      videoUrl: videoUrl[index],
                    );
                  },
                  itemCount: 17,
                )),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
            //   child: Text("কুরআন শিখুন",
            //       textAlign: TextAlign.start,
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            // ),
            // SizedBox(
            //     height: 250,
            //     child: ListView.builder(
            //       //shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return Video();
            //       },
            //       itemCount: 10,
            //     )),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
            //   child: Text("কুরআন শিখুন",
            //       textAlign: TextAlign.start,
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            // ),
            // SizedBox(
            //     height: 250,
            //     child: ListView.builder(
            //       //shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return Video();
            //       },
            //       itemCount: 10,
            //     )),
          ],
        ),
      ),
    );
  }
}
