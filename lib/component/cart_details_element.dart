import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartDetailsElementFromFirebase extends StatefulWidget {
  const CartDetailsElementFromFirebase({super.key, required this.order_id});

  final String order_id;
  @override
  State<CartDetailsElementFromFirebase> createState() => _CartDetailsElementFromFirebaseState();
}

class _CartDetailsElementFromFirebaseState extends State<CartDetailsElementFromFirebase> {
  int quantity = 1;
  int totalamount = 0;
  String book_name = 'asdf';
  String book_image = 'toprectangle';
  String author_name = 'minhaz';
  var per_unit_price = 17;
  @override
  void initState() {
    setState(() {
      var cartDetails = Provider.of<CartProvider>(context, listen: false);
      quantity = cartDetails.getBookQuantityCart(book_name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartDetails = Provider.of<CartProvider>(context);
    return ListTile(
        leading: Container(
            // width: 60,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: Image.asset(book_image)),
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
                  InkWell(
                    onTap: () async {
                      setState(() async {
                        quantity++;
                        cartDetails.addBookQuantityCart(
                            book_name, quantity);
                        cartDetails.calculateTotalPrice();
                        await saveMap(
                            'bookquantity', cartDetails.bookQuantityCart);
                        await saveDataToDevice(
                            'totalprice', cartDetails.totalPrice.toString());
                      });
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: const Icon(
                          Icons.add,
                          size: 15,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('$quantity'),
                  ),
                  InkWell(
                    onTap: () async {
                      if (quantity > 1) {
                        setState(() async {
                          quantity--;
                          cartDetails.addBookQuantityCart(
                              book_name, quantity);

                          cartDetails.calculateTotalPrice();
                          await saveMap(
                              'bookquantity', cartDetails.bookQuantityCart);
                          await saveDataToDevice(
                              'totalprice', cartDetails.totalPrice.toString());
                        });
                      }
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: const Icon(
                          Icons.remove,
                          size: 15,
                        )),
                  ),
                  Container(
                      height: 20,
                      width: 20,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.black)
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 15,
                      )),
                  Text('$per_unit_price ৳')
                ],
              ),
            )
          ],
        ),
        trailing: InkWell(
          onTap: () async {
            setState(() async {
              cartDetails.deleteBook(book_name);
              cartDetails.calculateTotalPrice();
              await saveList('bookname', cartDetails.bookList);
              await saveMap('bookprice', cartDetails.bookPriceCart);
              await saveMap('bookauthor', cartDetails.bookAuthorCart);
              await saveMap('bookimage', cartDetails.bookImagePath);
              await saveMap('bookquantity', cartDetails.bookQuantityCart);
              await saveDataToDevice(
                  'totalprice', cartDetails.totalPrice.toString());
            });
          },
          child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).primaryColor),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              )),
        ));
  }
}
