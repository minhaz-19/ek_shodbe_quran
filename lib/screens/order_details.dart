import 'package:ek_shodbe_quran/component/cart_details_element.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.order_id});

  final String order_id;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String name = 'Minhaz';
  String mobile = '01714501019';
  String address =
      '185/5/C, Road 09, Basabo, Khilgaon, Dhaka , Khilgaon , Dhaka , Bangladesh';
  String book_name = 'asdf';
  String book_image = 'toprectangle';
  String author_name = 'minhaz';
  var per_unit_price = 17;
  int quantity = 1;
  int total_price = 17;
  int sub_total = 17;

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
          title: Text('অর্ডার ${widget.order_id}'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('স্ট্যাটাস'),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Text('Delivered'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('ডেলিভারি এড্রেস',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Text('$address'),
              Text('নাম : $name'),
              Text('মোবাইল নম্বর : $mobile'),
              SizedBox(
                height: 20,
              ),
              Text('অর্ডার সারসংক্ষেপ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OrderDetailsFromFirebase(
                      order_id: 'asdfadfadf',
                    );
                  },
                  itemCount: 3,
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                child: SizedBox(
                  height: 82,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Subtotal',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Spacer(),
                            Text(
                              '$total_price ৳',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Total',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Spacer(),
                            Text(
                              '$total_price ৳',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
