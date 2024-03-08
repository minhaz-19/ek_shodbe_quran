import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/order_details_element.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminOrderDetails extends StatefulWidget {
  const AdminOrderDetails({super.key, required this.order_id});

  final String order_id;
  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  String name = 'Minhaz';
  String mobile = '01714501019';
  String address =
      '185/5/C, Road 09, Basabo, Khilgaon, Dhaka , Khilgaon , Dhaka , Bangladesh';
  String book_name = 'asdf';
  String book_image = 'toprectangle';
  var per_unit_price = 17;
  int quantity = 1;
  int total_price = 17;
  int sub_total = 17;
  bool _isLoading = false;
  String status = 'Delivered';
  Map<String, dynamic> unit_price = {};
  Map<String, dynamic> quantity_map = {};
  Map<String, dynamic> book_image_map = {};
  Map<String, dynamic> author_name = {};

  List<String> bookList = [];

  @override
  void initState() {
    initializeOrderDetails();
    super.initState();
  }

  void initializeOrderDetails() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.order_id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          name = documentSnapshot['name'];
          mobile = documentSnapshot['mobile'];
          address = documentSnapshot['address'];
          total_price =
              documentSnapshot['total'] + documentSnapshot['delivery charge'];
          sub_total = documentSnapshot['total'];
          status = documentSnapshot['status'];
          unit_price =
              Map<String, dynamic>.from(documentSnapshot['unit price']);
          quantity_map =
              Map<String, dynamic>.from(documentSnapshot['quantity']);
          book_image_map = Map<String, dynamic>.from(documentSnapshot['image']);
          bookList = List<String>.from(documentSnapshot['order']);
          author_name = Map<String, dynamic>.from(documentSnapshot['author']);
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

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
        body: (_isLoading)
            ? const ProgressBar()
            : Padding(
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
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Select Status'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // Set the status to 'Delivered'
                                          try {
                                            // update specific field value in firebase
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(widget.order_id)
                                                .update({
                                              'status': 'Delivered',
                                            });
                                            setState(() {
                                              status = 'Delivered';
                                            });
                                          } on FirebaseException {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occured');
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }

                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green[700],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            child: Text('Delivered'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () async {
                                          // Set the status to 'Delivered'
                                          try {
                                            // update specific field value in firebase
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(widget.order_id)
                                                .update({
                                              'status': 'Pending',
                                            });
                                            setState(() {
                                              status = 'Pending';
                                            });
                                          } on FirebaseException {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occured');
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }

                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.yellow[700],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            child: Text('Pending'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () async {
                                          // Set the status to 'Delivered'
                                          try {
                                            // update specific field value in firebase
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(widget.order_id)
                                                .update({
                                              'status': 'Shipped',
                                            });
                                            setState(() {
                                              status = 'Shipped';
                                            });
                                          } on FirebaseException {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occured');
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }

                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 98, 9, 187),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            child: Text('Shipped'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: status == 'Pending'
                                  ? Colors.yellow[700]
                                  : status == 'Delivered'
                                      ? Colors.green[700]
                                      : const Color.fromARGB(255, 98, 9, 187),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                '$status',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text('ডেলিভারি এড্রেস',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      "Name: $name\nMobile: $mobile\nAddress: $address"));
                              Fluttertoast.showToast(msg: "কপি হয়েছে");
                            },
                            child: Text("কপি করুন",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('$address'),
                    Text('নাম : $name'),
                    Row(
                      children: [
                        Text('মোবাইল নম্বর : $mobile'),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              launch("tel://$mobile");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text('কল করুন',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('অর্ডার সারসংক্ষেপ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrderDetailsFromFirebase(
                            book_name: bookList[index],
                            book_image: book_image_map[bookList[index]],
                            author_name: author_name[bookList[index]],
                            per_unit_price: unit_price[bookList[index]],
                            quantity: quantity_map[bookList[index]],
                          );
                        },
                        itemCount: bookList.length,
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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                  Spacer(),
                                  Text(
                                    '$sub_total ৳',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
