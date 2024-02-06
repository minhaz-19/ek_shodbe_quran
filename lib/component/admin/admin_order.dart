import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/admin/order_admin.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:flutter/material.dart';

class AdminOrder extends StatelessWidget {
  const AdminOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(
                'assets/images/toprectangle.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.white,
          title: const Text('অর্ডার'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.red,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'পেন্ডিং',
              ),
              Tab(
                text: 'শিপড',
              ),
              Tab(
                text: 'ডেলিভার্ড',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .where('status', isEqualTo: 'Pending')
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
                        return AdminOrderElement(
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
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('status', isEqualTo: 'Shipped')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: ProgressBar());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center();
                  } else {
                    // Iterate through documents and build the list
                    List<Widget> listTiles = snapshot.data!.docs.map((doc) {
                      return AdminOrderElement(
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('status', isEqualTo: 'Delivered')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: ProgressBar());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center();
                  } else {
                    // Iterate through documents and build the list
                    List<Widget> listTiles = snapshot.data!.docs.map((doc) {
                      return AdminOrderElement(
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
        ),
      ),
    );
  }
}
