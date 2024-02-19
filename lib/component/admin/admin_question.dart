import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:flutter/material.dart';

class AdminQuestion extends StatefulWidget {
  const AdminQuestion({Key? key}) : super(key: key);

  @override
  State<AdminQuestion> createState() => _AdminQuestionState();
}

class _AdminQuestionState extends State<AdminQuestion> {
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage('assets/images/toprectangle.png'),
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.white,
          title: const Text('প্রশ্নোত্তর বিভাগ'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'নতুন',
              ),
              Tab(
                text: 'সম্পূর্ণ',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('questions')
                  .where('answer', isEqualTo: '')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: ProgressBar());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center();
                } else {
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
                        trailing: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(doc['question']),
                                  content: TextField(
                                    controller: _answerController,
                                    decoration: const InputDecoration(
                                      hintText: 'উত্তর',
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('বাতিল'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('questions')
                                            .doc(doc.id)
                                            .update({
                                          'answer': _answerController.text,
                                        });
                                        _answerController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('সাবমিট'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('questions')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: ProgressBar());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center();
                } else {
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
                                  color: Color.fromRGBO(108, 104, 138, 1.0),
                                ),
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
          ],
        ),
      ),
    );
  }
}
