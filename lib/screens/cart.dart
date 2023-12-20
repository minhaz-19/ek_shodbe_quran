import 'package:ek_shodbe_quran/component/cart_element.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var cartDetails = Provider.of<CartProvider>(context, listen: false);
      // Calculate and set the initial total price after the build process is complete
      Future.delayed(Duration.zero, () {
        cartDetails.calculateTotalPrice();
      });
    });
    // Provider.of<CartProvider>(context, listen: false).calculateTotalPrice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  // cartDetails.updateTotalPrice(cartDetails
                  //     .getBookPriceCart(cartDetails.bookList[index]));
                  return CartElement(
                    book_name: cartDetails.bookList[index],
                    book_image:
                        'assets/images/${cartDetails.getBookImagePath(cartDetails.bookList[index])}.png',
                    book_price: cartDetails
                        .getBookPriceCart(cartDetails.bookList[index]),
                    author_name: cartDetails
                        .getBookAuthorCart(cartDetails.bookList[index]),
                  );
                },
                itemCount: cartDetails.bookList.length,
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
