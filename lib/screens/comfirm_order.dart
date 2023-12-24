import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:flutter/material.dart';
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
        title: const Text('কার্ট'),
        centerTitle: true,
      ),
      body: Padding(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                        items: districts
                            .map<DropdownMenuItem<String>>((String value) {
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
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'মোট',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '${cartDetails.totalPrice} ৳',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    WideButton(
                      'অর্ডার নিশ্চিত করুন',
                      onPressed: () {},
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
