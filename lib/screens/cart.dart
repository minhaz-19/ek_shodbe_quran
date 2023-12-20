import 'package:ek_shodbe_quran/component/cart_element.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
          title: const Text('কার্ট'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const CartElement(
                    book_name: 'আল-কোরআনুল কারিম',
                    book_image: 'assets/images/toprectangle.png',
                    book_price: 500,
                    author_name: 'মুহাম্মাদ মুজাহিদুল ইসলাম',
                  );
                },
                itemCount: 10,
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
                            '১০০০ ৳',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    WideButton(
                      'চেক আউট',
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
        ));
  }
}
