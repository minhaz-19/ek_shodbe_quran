import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  BookDetails(
      {super.key,
      required this.book_name,
      required this.book_image,
      required this.author_name,
      required this.book_price});

  String book_name;
  String book_image;
  int book_price;
  String author_name;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
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
        title: Text(widget.book_name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Positioned(
                top: -MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      'assets/images/${widget.book_image}.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.book_name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      '${widget.book_price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            widget.author_name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'প্রকাশনী : ফেরা প্রকাশন',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'বিষয় : আত্মশুদ্ধি ও অনুপ্রেরণা',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'অনুবাদক : আরিফ আফ্ফান',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'পৃষ্ঠা : 72, কভার : পেপার ব্যাক, সংস্করণ : 1st Published, 2022',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'ভাষা : বাংলা',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'বিস্তারিত',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                            'তোমাদের মধ্যে আল্লাহর নিকট সেই ব্যক্তি সর্বাপেক্ষা মর্যাদাসম্পন্ন, যে তোমাদের মধ্যে সর্বাপেক্ষা মুত্তাকি। নিশ্চয় আল্লাহ সবকিছু জানেন, সকল ব্যাপারে অবহিত।তাকওয়াই হলো শ্রেষ্ঠত্বের উৎস, উত্তম চরিত্রাবলির কেন্দ্রবিন্দু। যেমন দয়া, অঙ্গীকার পূর্ণ করা, সত্যবাদিতা, ন্যায়পরায়ণতা, আত্মসংযম, শরিয়ত নির্দেশিত কাজে ব্যয় করা, দানসদকা, হাদিয়া তথা এ প্রকারের যত উত্তম গুণাবলি রয়েছে, এগুলো তাকওয়া ও আল্লাহভীতিরই শাশ্বত ফলাফল। এই তাকওয়াই মানুষের নির্জনতার একমাত্র সঙ্গী ও ধ্বংস থেকে মুক্তিদানকারী।তোমাদের মধ্যে আল্লাহর নিকট সেই ব্যক্তি সর্বাপেক্ষা মর্যাদাসম্পন্ন, যে তোমাদের মধ্যে সর্বাপেক্ষা মুত্তাকি। নিশ্চয় আল্লাহ সবকিছু জানেন, সকল ব্যাপারে অবহিত।তাকওয়াই হলো শ্রেষ্ঠত্বের উৎস, উত্তম চরিত্রাবলির কেন্দ্রবিন্দু। যেমন দয়া, অঙ্গীকার পূর্ণ করা, সত্যবাদিতা, ন্যায়পরায়ণতা, আত্মসংযম, শরিয়ত নির্দেশিত কাজে ব্যয় করা, দানসদকা, হাদিয়া তথা এ প্রকারের যত উত্তম গুণাবলি রয়েছে, এগুলো তাকওয়া ও আল্লাহভীতিরই শাশ্বত ফলাফল। এই তাকওয়াই মানুষের নির্জনতার একমাত্র সঙ্গী ও ধ্বংস থেকে মুক্তিদানকারী।')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  WideButton(
                    'কার্ট এ যুক্ত করুন',
                    onPressed: () async{
                      cartDetails.addBookName(widget.book_name);
                      cartDetails.addBookPriceCart(
                          widget.book_name, widget.book_price);
                      cartDetails.addBookAuthorCart(
                          widget.book_name, widget.author_name);
                      cartDetails.addBookImagePath(
                          widget.book_name, widget.book_image);
                      cartDetails.addBookQuantityCart(widget.book_name, 1);
                      cartDetails.updateTotalPrice(widget.book_price);

                      await saveList('bookname', cartDetails.bookList);
                      await saveMap('bookprice', cartDetails.bookPriceCart);
                      await saveMap('bookauthor', cartDetails.bookAuthorCart);
                      await saveMap('bookimage', cartDetails.bookImagePath);
                      await saveMap('bookquantity', cartDetails.bookQuantityCart);
                      await saveDataToDevice('totalprice', cartDetails.totalPrice.toString());

                      Fluttertoast.showToast(
                          msg: 'বইটি কার্টে যুক্ত করা হয়েছে');
                      // print('####################################');
                      // print('${cartDetails.bookList}');
                      // print('${cartDetails.bookAuthorCart}');
                      // print('${cartDetails.bookImagePath}');
                      // print('${cartDetails.bookPriceCart}');
                      // print('${cartDetails.bookQuantityCart}');
                      // print('${cartDetails.totalPrice}');
                    },
                    backgroundcolor: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    padding: MediaQuery.of(context).size.width * 0.08,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  WideButton(
                    'পড়ে দেখুন',
                    onPressed: () {},
                    backgroundcolor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: MediaQuery.of(context).size.width * 0.08,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
