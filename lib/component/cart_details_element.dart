import 'package:flutter/material.dart';

class OrderDetailsFromFirebase extends StatefulWidget {
  const OrderDetailsFromFirebase({super.key, required this.order_id});

  final String order_id;
  @override
  State<OrderDetailsFromFirebase> createState() =>
      _OrderDetailsFromFirebaseState();
}

class _OrderDetailsFromFirebaseState extends State<OrderDetailsFromFirebase> {
  String name = 'Minhaz';
  String mobile = '01714501019';
  String address =
      '185/5/C, Road 09, Basabo, Khilgaon, Dhaka , Khilgaon , Dhaka , Bangladesh';
  String book_name = 'The Road to Recognition';
  String book_image = 'toprectangle';
  String author_name = 'minhaz';
  var per_unit_price = 17;
  int quantity = 14;

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
          child: Image.asset('assets/images/$book_image.png')),
      title: Text(book_name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(author_name),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$per_unit_price ৳',
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
                    child: Center(child: Text(quantity.toString()))),
                SizedBox(
                  width: 50,
                ),
                Text('$per_unit_price ৳')
              ],
            ),
          )
        ],
      ),
    );
  }
}
