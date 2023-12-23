import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTab extends StatefulWidget {
  const BookTab({super.key});

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  @override
  Widget build(BuildContext context) {
    var cartDetails = Provider.of<CartProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (cartDetails.bookList.length == 0) {
            await cartDetails.initializeFromSharedPreferences();
          }
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => const Cart(),
          ));
        },
        backgroundColor: const Color(0xFF007C49),
        child: const ImageIcon(
          AssetImage("assets/icons/floatingcart.png"),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
