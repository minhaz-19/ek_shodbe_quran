import 'package:ek_shodbe_quran/component/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
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
                height: 250,
                child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Video();
                  },
                  itemCount: 10,
                )),
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
              child: Text("কুরআন শিখুন",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                height: 250,
                child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Video();
                  },
                  itemCount: 10,
                )),
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 10, 0, 0),
              child: Text("কুরআন শিখুন",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
                height: 250,
                child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Video();
                  },
                  itemCount: 10,
                )),
          ],
        ),
      ),
    );
  }
}
