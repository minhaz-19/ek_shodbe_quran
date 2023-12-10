 import 'package:flutter/material.dart';

class QuestionTab extends StatefulWidget {
  const QuestionTab({super.key});

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  final TextEditingController _questionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
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
                );
              },
            ),
          ),
          Card(
            elevation: 3,
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 2,
                      controller: _questionController,
                      decoration: const InputDecoration(
                        hintText: 'প্রশ্ন জিজ্ঞাসা করুন',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const Image(
                    image: AssetImage('assets/icons/send.png'),
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          // Add some space below the bottom sheet
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
