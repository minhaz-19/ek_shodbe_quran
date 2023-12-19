import 'package:ek_shodbe_quran/component/order.dart';
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
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return OrderElement(
              date: DateTime.now().toString(),
              order_id: 'asdfsasfsasdfasdfasdfasf',
              status: 'Shipped',
              price: 1000,
            );
          },
          itemCount: 10,
        ));
  }
}
