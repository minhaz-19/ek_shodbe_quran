import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final validCharacters = RegExp(r'^01\d{9}$');
  String area = 'ঢাকা মহানগরীর ভিতরে';
  bool _isLoading = false;

  List<String> districts = <String>[
    'ঢাকা মহানগরীর ভিতরে',
    'ঢাকা মহানগরীর বাইরে'
  ];

  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<UserDetailsProvider>(context);
    var cartDetails = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
              'assets/images/toprectangle.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        foregroundColor: Colors.white,
        title: const Text('অর্ডার নিশ্চিত'),
        centerTitle: true,
      ),
      body: (_isLoading)
          ? const ProgressBar()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                            child: Text(
                              'নাম',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            // obscureText: true,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 0,
                              ),
                              hintText: userdata.getName() == ''
                                  ? 'নাম'
                                  : userdata.getName(),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.green[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(191, 153, 245, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onSaved: (newValue) {
                              setState(() {
                                // Handle the value if needed
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                            child: Text(
                              'মোবাইল নাম্বার',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            controller: _phoneController,
                            // obscureText: true,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 0,
                              ),
                              hintText: '01xxxxxxxxx',
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.green[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(191, 153, 245, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onSaved: (newValue) {
                              setState(() {
                                // Handle the value if needed
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                            child: Text(
                              'মহানগরীর ভিতরে/বাইরে',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[100],
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: area,
                              onChanged: (newValue) {
                                setState(() {
                                  area = newValue!;
                                });
                              },
                              items: districts.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                            child: Text(
                              'ঠিকানা',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            controller: _addressController,
                            // obscureText: true,
                            maxLines: 4,
                            keyboardType: TextInputType.streetAddress,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 0,
                              ),
                              hintText: 'নিশ্চিত করুন',
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.green[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(191, 153, 245, 1),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                const Text(
                                  'মোট',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  area == 'ঢাকা মহানগরীর ভিতরে'
                                      ? '${cartDetails.totalPrice + 50} ৳'
                                      : '${cartDetails.totalPrice + 100} ৳',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          WideButton(
                            'অর্ডার নিশ্চিত করুন',
                            onPressed: () async {
                              if (cartDetails.bookList.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'কার্টে কোন বই নেই');
                              } else if (_nameController.text.isEmpty) {
                                Fluttertoast.showToast(msg: 'আপনার নাম লিখুন');
                              } else if (_phoneController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'আপনার মোবাইল নাম্বার লিখুন');
                              } else if (_addressController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: 'আপনার ঠিকানা লিখুন');
                              } else if (!validCharacters
                                  .hasMatch(_phoneController.text)) {
                                Fluttertoast.showToast(
                                    msg: 'আপনার মোবাইল নাম্বার সঠিক নয়');
                              } else {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('orders/')
                                        .add({
                                      'uid': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'name': _nameController.text,
                                      'time': Timestamp.now(),
                                      'mobile': _phoneController.text,
                                      'area': area,
                                      'address': _addressController.text,
                                      'total': cartDetails.totalPrice,
                                      'order': cartDetails.bookList,
                                      'status': 'Pending',
                                      'quantity': cartDetails.bookQuantityCart,
                                      'unit price': cartDetails.bookPriceCart,
                                      'image': cartDetails.bookImagePath,
                                      'author': cartDetails.bookAuthorCart,
                                      'delivery charge':
                                          area == 'ঢাকা মহানগরীর ভিতরে'
                                              ? 50
                                              : 100,
                                    }).then((value) {
                                      Fluttertoast.showToast(
                                          msg: 'অর্ডার নিশ্চিত হয়েছে');
                                    });
                                    _addressController.clear();
                                    _phoneController.clear();
                                    _nameController.clear();
                                    cartDetails.bookList.forEach((element) {
                                      setState(() async {
                                        cartDetails.deleteBook(element);
                                        cartDetails.calculateTotalPrice();
                                        await saveList(
                                            'bookname', cartDetails.bookList);
                                        await saveMap('bookprice',
                                            cartDetails.bookPriceCart);
                                        await saveMap('bookauthor',
                                            cartDetails.bookAuthorCart);
                                        await saveMap('bookimage',
                                            cartDetails.bookImagePath);
                                        await saveMap('bookquantity',
                                            cartDetails.bookQuantityCart);
                                        await saveDataToDevice('totalprice',
                                            cartDetails.totalPrice.toString());
                                        _isLoading = false;
                                      });
                                    });
                                    Navigator.of(context).pop();
                                  } on FirebaseAuthException {
                                    Fluttertoast.showToast(
                                        msg: 'অর্ডার নিশ্চিত হয়নি');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: 'অর্ডার নিশ্চিত করতে লগইন করুন');
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ));
                                }
                              }
                            },
                            backgroundcolor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            borderColor: Theme.of(context).primaryColor,
                            padding: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add some space below the bottom sheet
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
