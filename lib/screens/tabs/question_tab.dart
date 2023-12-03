import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionTab extends StatefulWidget {
  const QuestionTab({super.key});

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              child: ListTile(
                title: Text(
                  'আমি কি ভর্তির যোগ্য?',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'লার্নিং ম্যানেজমেন্ট সিস্টেম, শারীরিক শ্রেণীকক্ষ ছাড়াই একটি ক্লাস সেটিং উপস্থাপন করার জন্য বিস্তৃত বৈশিষ্ট্যগুলিকে একত্রিত করে।',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
