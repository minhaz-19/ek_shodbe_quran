import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/order.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
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
          title: const Text('অর্ডার'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            (FirebaseAuth.instance.currentUser == null)
                ? Expanded(
                    child: Container(),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .where('uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: ProgressBar());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center();
                        } else {
                          // Iterate through documents and build the list
                          List<Widget> listTiles =
                              snapshot.data!.docs.map((doc) {
                            return OrderElement(
                              date: doc['time'].toDate().toString(),
                              order_id: doc.id,
                              status: doc['status'],
                              price: doc['total'],
                            );
                          }).toList();

                          return ListView(
                            children: listTiles,
                          );
                        }
                      },
                    ),
                  ),
          ],
        ));
  }
}
