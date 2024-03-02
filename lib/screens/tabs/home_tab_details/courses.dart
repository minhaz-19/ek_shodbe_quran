import 'package:ek_shodbe_quran/component/course.dart';
import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<String> courses = [
    'একশব্দে কুরআন শিক্ষা কোর্স (ফ্রি)',
    'অনলাইনে কুরআন শিক্ষা কোর্স (পুরুষ)',
    'অনলাইনে কুরআন শিক্ষা কোর্স (মহিলা)',
  ];

  List<int> coursePrice = [0, 3000, 3000];
  List<String> courseImage = [
    'course1.png',
    'course2.png',
    'course3.png',
  ];

   List<String> description = [
    "বাংলাদেশের সকল পেশার, সকল বয়সের মানুষকে সবচেয়ে সহজ পদ্ধতিতে কুরআন শিক্ষা দেয়া আমাদের উদ্দেশ্য। ঘরে বসেই আপনি এখন কুরআন শিখতে পারবেন পৃথিবীর যে কোন যায়গা থেকে ।\nকুরআন সহীহ শুদ্ধ করে শিখে নেয়া অতীব জরুরী। যেহেতু আল্লাহ রাব্বুল আলামীন বলেছেন, وَرَتِّلِ الْقُرْﺇنَ تَرْتِيْلاً অর্থ: ধীরে ধীরে স্পষ্টভাবে সহীহ শুদ্ধ করে কুরআন তিলাওয়াত করো। সূরা মুযযাম্মিল ৭৩ : আয়াত ৪।  কুরআন অশুদ্ধ ভাবে পড়ার কারনে নামাজের মতো ইবাদতও বাতিল হয়ে যেতে পারে। তাই আমাদের সবার শুদ্ধভাবে কুরআন পড়তে হবে। কোর্সটিতে মাখরাজ অনুযায়ী আরবি হরফ উচ্চারণ থেকে শুরু করে তিলাওয়াতের জন্য প্রয়োজনীয় নিয়ম-কানুন মাদ, গুন্নাহ, ওয়াক্বফ, সিফাত সহ যাবতীয় বিধিবিধান সহজ ভাষায় পড়ানো হবে। এছাড়া কিছু গুরুত্বপূর্ণ দুয়া ও আমল জানতে পারবেন এই কোর্সে। তাই কোর্সটির মাধ্যমে একজন শিক্ষার্থী কুরআনুল কারিম সম্পূর্ণ শুদ্ধভাবে তিলাওয়াত করতে পারবেন ইনশা-আল্লাহ।",
    "আসসালামুআলাইকুম ওয়ারাহমাতুল্লাহ।\n\nطلب العلم فريضه على كل مسلم ومسلمه\nপ্রয়োজনীয় দ্বীনি ইলম অর্জন করা প্রত্যেক মুসলিম নারী-পুরুষের উপর ফরজ।\n\nখুব শীঘ্রই একটি শব্দের মাধ্যমে কুরআনুল কারীমের সহিহ তিলাওয়াত শিক্ষার নতুন একটি ব্যাচের ক্লাস শুরু হবে ইনশাআল্লাহ।ক্লাস নিবেন:- এনটিভি কুরআন শিক্ষার আসর অনুষ্ঠানের সম্মানিত পরিচালক শাইখ আবুল হাসানাত মুহাম্মদ ইমদাদুল্লাহ\n\nক্লাসে যা থাকবে:-\n🌿একটি শব্দের মাধ্যমে সহি শুদ্ধভাবে কুরআন শিক্ষা, কুরআন বুঝার জন্য এরাবিক মৌলিক ধারণা প্রদান।\n🌿সহীহ শুদ্ধভাবে মদ,মাখরাজ, সিফাত ও উচ্চরণ শিক্ষা\n🌿একজন প্রকৃত মুসলিমের জীবন পরিচালনা করার জন্য প্রয়োজনীয় মাসায়েল শিক্ষা।\n🌿দৈনন্দিন জীবনের প্রয়োজনীয় সহীহ হাদীসের ভিত্তিতে জিকির ও দুআ শিক্ষা।\n🌿প্রতিটি ক্লাসের ভিডিও ক্লিপস প্রদান করা হবে\n🌿কোর্স শেষে পরীক্ষার মাধ্যমে উত্তীর্ণদের সনদ প্রদান করা হবে ইনশাআল্লাহ।\n\nক্লাসে যারা অংশগ্রহণ করবেন:- যেকোনো বয়সের নারী পুরুষ।\nশিক্ষাগত যোগ্যতা:- দেখে দেখে বাংলা পড়তে পারেন এমন যে কোন ব্যক্তি\nক্লাসের মাধ্যম:- অনলাইন জুম\nকোর্সের সময়কাল:- ১ বছর\nক্লাসের সময়:- সপ্তাহে তিন দিন ১ ঘন্টা করে।",
    "আসসালামুআলাইকুম ওয়ারাহমাতুল্লাহ।\n\nطلب العلم فريضه على كل مسلم ومسلمه\nপ্রয়োজনীয় দ্বীনি ইলম অর্জন করা প্রত্যেক মুসলিম নারী-পুরুষের উপর ফরজ।\n\nখুব শীঘ্রই একটি শব্দের মাধ্যমে কুরআনুল কারীমের সহিহ তিলাওয়াত শিক্ষার নতুন একটি ব্যাচের ক্লাস শুরু হবে ইনশাআল্লাহ।ক্লাস নিবেন:- একশব্দে কুরআন শিক্ষা ফাউন্ডেশনের সম্মানিত মহিলা সম্পাদিকা জান্নাতুল ফেরদাউস\n\nক্লাসে যা থাকবে:-\n🌿একটি শব্দের মাধ্যমে সহি শুদ্ধভাবে কুরআন শিক্ষা, কুরআন বুঝার জন্য এরাবিক মৌলিক ধারণা প্রদান।\n🌿 সহীহ শুদ্ধভাবে মদ,মাখরাজ, সিফাত ও উচ্চরণ শিক্ষা\n🌿একজন প্রকৃত মুসলিমের জীবন পরিচালনা করার জন্য প্রয়োজনীয় মাসায়েল শিক্ষা।\n🌿দৈনন্দিন জীবনের প্রয়োজনীয় সহীহ হাদীসের ভিত্তিতে জিকির ও দুআ শিক্ষা।\n🌿প্রতিটি ক্লাসের ভিডিও ক্লিপস প্রদান করা হবে\n🌿কোর্স শেষে পরীক্ষার মাধ্যমে উত্তীর্ণদের সনদ প্রদান করা হবে ইনশাআল্লাহ।\n\nক্লাসে যারা অংশগ্রহণ করবেন:- যেকোনো বয়সের নারী পুরুষ।\nশিক্ষাগত যোগ্যতা:- দেখে দেখে বাংলা পড়তে পারেন এমন যে কোন ব্যক্তি\nক্লাসের মাধ্যম:- অনলাইন জুম\nকোর্সের সময়কাল:- ১ মাস\nক্লাসের সময়:- সপ্তাহে তিন দিন ১ ঘন্টা করে।"
  ];

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
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CoursesWidget(
                  courseName: courses[index],
                  coursePrice: coursePrice[index],
                  courseImage: courseImage[index],
                  description: description[index]),
            );
          },
        ));
  }
}
