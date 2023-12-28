import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          (FirebaseAuth.instance.currentUser == null)
              ? Expanded(
                  child: Container(),
                )
              : Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection(
                            'users/${FirebaseAuth.instance.currentUser!.uid}/questions')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No questions available'));
                      } else {
                        // Iterate through documents and build the list
                        List<Widget> listTiles = snapshot.data!.docs.map((doc) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                doc['question'],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: (doc['answer'] == null ||
                                      !snapshot.data.)
                                  ? null
                                  : Text(
                                      doc['answer']
                                          .toString(), // Adjust as needed
                                      style: TextStyle(color: Colors.black54),
                                    ),
                            ),
                          );
                        }).toList();

                        return ListView(
                          children: listTiles,
                        );
                      }
                    },
                  ),
                ),
          Card(
            color: Colors.green[100],
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
                  InkWell(
                    onTap: () async {
                      if (_questionController.text.isNotEmpty) {
                        if (FirebaseAuth.instance.currentUser != null) {
                          await FirebaseFirestore.instance
                              .collection(
                                  'users/${FirebaseAuth.instance.currentUser!.uid}/questions')
                              .add({
                            'question': _questionController.text,
                            'time': Timestamp.now(),
                          }).then((value) async {
                            await FirebaseFirestore.instance
                                .collection('questions/')
                                .add({
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'question': _questionController.text,
                              'time': Timestamp.now(),
                            });
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg: 'আপনার প্রশ্ন সফলভাবে জমা দেওয়া হয়েছে');
                          });
                          _questionController.clear();
                        } else {
                          Fluttertoast.showToast(
                              msg: 'প্রশ্ন জিজ্ঞাসা করতে লগইন করুন');
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                        }
                      }
                    },
                    child: const Image(
                      image: AssetImage(
                        'assets/icons/send.png',
                      ),
                      height: 40,
                    ),
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
