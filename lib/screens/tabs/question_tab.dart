import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionTab extends StatefulWidget {
  const QuestionTab({Key? key}) : super(key: key);

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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('questions')
                        .where('uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: ProgressBar());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center();
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
                              subtitle: (doc['answer'] == '')
                                  ? null
                                  : Text(
                                      doc['answer'],
                                      style: const TextStyle(
                                          color: Color.fromRGBO(
                                              108, 104, 138, 1.0)),
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
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    color: Color.fromARGB(255, 208, 249, 210),
                    child: TextField(
                      maxLines: 2,
                      controller: _questionController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: 'প্রশ্ন জিজ্ঞাসা করুন',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color.fromARGB(255, 221, 251, 250),
                  child: InkWell(
                    onTap: () async {
                      if (_questionController.text.isNotEmpty) {
                        if (FirebaseAuth.instance.currentUser != null) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('questions/')
                                .add({
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'question': _questionController.text,
                              'time': Timestamp.now(),
                              'answer': '',
                            }).then((value) {
                              Fluttertoast.showToast(
                                  msg:
                                      'আপনার প্রশ্ন সফলভাবে জমা দেওয়া হয়েছে');
                            });
                            _questionController.clear();
                          } on FirebaseException catch (e) {
                            Fluttertoast.showToast(msg: '$e');
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: 'প্রশ্ন জমা দেওয়া হয়নি');
                          }
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
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: const Image(
                        image: AssetImage(
                          'assets/icons/send.png',
                        ),
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          // Add some space below the bottom sheet
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
