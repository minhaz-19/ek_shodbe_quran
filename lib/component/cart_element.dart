import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartElement extends StatefulWidget {
  const CartElement(
      {super.key,
      required this.book_name,
      required this.author_name,
      required this.book_price,
      required this.book_image});

  final String book_name;
  final String book_image;
  final num book_price;
  final String author_name;
  @override
  State<CartElement> createState() => _CartElementState();
}

class _CartElementState extends State<CartElement> {
  int quantity = 1;
  int totalamount = 0;
  @override
  void initState() {
    setState(() {
      var cartDetails = Provider.of<CartProvider>(context, listen: false);
      quantity = cartDetails.getBookQuantityCart(widget.book_name);
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
            child: Image.asset(widget.book_image)),
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
                  InkWell(
                    onTap: () async {
                      setState(() async {
                        quantity++;
                        cartDetails.addBookQuantityCart(
                            widget.book_name, quantity);
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
                              widget.book_name, quantity);

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
                  Text('${widget.book_price} ৳')
                ],
              ),
            )
          ],
        ),
        trailing: InkWell(
          onTap: ()async {
            setState(()async {
              cartDetails.deleteBook(widget.book_name);
              cartDetails.calculateTotalPrice();
              await saveList('bookname', cartDetails.bookList);
                      await saveMap('bookprice', cartDetails.bookPriceCart);
                      await saveMap('bookauthor', cartDetails.bookAuthorCart);
                      await saveMap('bookimage', cartDetails.bookImagePath);
                      await saveMap('bookquantity', cartDetails.bookQuantityCart);
                      await saveDataToDevice('totalprice', cartDetails.totalPrice.toString());
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
