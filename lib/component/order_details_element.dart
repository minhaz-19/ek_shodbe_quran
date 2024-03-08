import 'package:flutter/material.dart';

class OrderDetailsFromFirebase extends StatefulWidget {
  const OrderDetailsFromFirebase(
      {super.key,
      required this.book_name,
      required this.book_image,
      required this.author_name,
      required this.per_unit_price,
      required this.quantity});

  final String book_name;
  final String book_image;
  final String author_name;
  final int per_unit_price;
  final int quantity;

  @override
  State<OrderDetailsFromFirebase> createState() =>
      _OrderDetailsFromFirebaseState();
}

class _OrderDetailsFromFirebaseState extends State<OrderDetailsFromFirebase> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          // width: 60,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: Image.asset('assets/images/${widget.book_image}')),
      title: Text(widget.book_name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.author_name),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.per_unit_price} ৳',
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                    height: 20,
                    width: 20,
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.grey,
                    )),
                Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.grey)),
                    child: Center(child: Text('${widget.quantity}'))),
                SizedBox(
                  width: 50,
                ),
                Text('${widget.per_unit_price * widget.quantity} ৳')
              ],
            ),
          )
        ],
      ),
    );
  }
}
