import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
          title: const Text('আমাদের সম্পর্কে'),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'ইসলামিক সঙ্গীতে স্বাগতম, ইসলামের পথে আপনার আধ্যাত্মিক যাত্রাকে সমর্থন করার জন্য প্রেম এবং ভক্তি দিয়ে তৈরি একটি উত্সর্গীকৃত প্ল্যাটফর্ম। আমাদের লক্ষ্য হল বিশ্বব্যাপী মুসলমানদের জন্য একটি ব্যাপক এবং অ্যাক্সেসযোগ্য সংস্থান প্রদান করা, তাদের বিশ্বাস, জ্ঞান এবং অনুশীলনকে শক্তিশালী করতে সক্ষম করে।',
                textAlign: TextAlign.center,
              )
            ],
          ),
        )));
  }
}
