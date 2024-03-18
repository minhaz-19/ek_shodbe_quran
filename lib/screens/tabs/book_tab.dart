import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/screens/cart.dart';
import 'package:ek_shodbe_quran/screens/tabs/bookdetails_from_authors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTab extends StatefulWidget {
  const BookTab({super.key});

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  List<String> bookName = BookDetailsFromAuthors.bookName;
  List<String> bookImage = BookDetailsFromAuthors.bookImage;
  List<String> authorName = BookDetailsFromAuthors.authorName;
  List<int> bookPrice = BookDetailsFromAuthors.bookPrice;
  List<String> bookProkashoni = BookDetailsFromAuthors.bookProkashoni;
  List<String> bookSubject = BookDetailsFromAuthors.bookSubject;
  List<String> bookTranslator = BookDetailsFromAuthors.bookTranslator;
  List<String> bookCover = BookDetailsFromAuthors.bookCover;
  List<String> bookLanguage = BookDetailsFromAuthors.bookLanguage;
  List<String> bookEdition = BookDetailsFromAuthors.bookEdition;
  List<int> bookTotalPage = BookDetailsFromAuthors.bookTotalPage;
  List<String> bookDescription = BookDetailsFromAuthors.booDescription;

  @override
  Widget build(BuildContext context) {
    var cartDetails = Provider.of<CartProvider>(context);
    return Scaffold(
      floatingActionButton: Badge(
        label: Text(
          cartDetails.bookList.length.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: FloatingActionButton(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: ReadBook(
                    bookName: bookName[0],
                    bookImage: bookImage[0],
                    author: authorName[0],
                    bookPrice: bookPrice[0],
                    prokashok: bookProkashoni[0],
                    subject: bookSubject[0],
                    translator: bookTranslator[0],
                    coverType: bookCover[0],
                    totalPage: bookTotalPage[0],
                    bookEdition: bookEdition[0],
                    bookLanguage: bookLanguage[0],
                    bookDescription: bookDescription[0],
                  )),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  Expanded(
                      child: ReadBook(
                    bookName: bookName[1],
                    bookImage: bookImage[1],
                    author: authorName[1],
                    bookPrice: bookPrice[1],
                    prokashok: bookProkashoni[1],
                    subject: bookSubject[1],
                    translator: bookTranslator[1],
                    coverType: bookCover[1],
                    totalPage: bookTotalPage[1],
                    bookEdition: bookEdition[1],
                    bookLanguage: bookLanguage[1],
                    bookDescription: bookDescription[1],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: ReadBook(
                    bookName: bookName[2],
                    bookImage: bookImage[2],
                    author: authorName[2],
                    bookPrice: bookPrice[2],
                    prokashok: bookProkashoni[2],
                    subject: bookSubject[2],
                    translator: bookTranslator[2],
                    coverType: bookCover[2],
                    totalPage: bookTotalPage[2],
                    bookEdition: bookEdition[2],
                    bookLanguage: bookLanguage[2],
                    bookDescription: bookDescription[2],
                  )),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                      child: ReadBook(
                    bookName: bookName[3],
                    bookImage: bookImage[3],
                    author: authorName[3],
                    bookPrice: bookPrice[3],
                    prokashok: bookProkashoni[3],
                    subject: bookSubject[3],
                    translator: bookTranslator[3],
                    coverType: bookCover[3],
                    totalPage: bookTotalPage[3],
                    bookEdition: bookEdition[3],
                    bookLanguage: bookLanguage[3],
                    bookDescription: bookDescription[3],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
