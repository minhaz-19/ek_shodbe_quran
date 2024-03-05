import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  BookDetails(
      {super.key,
      required this.book_name,
      required this.book_image,
      required this.author_name,
      required this.book_price,
      required this.prokashok,
      required this.subject,
      required this.translator,
      required this.coverType,
      required this.totalPage,
      required this.bookEdition,
      required this.bookLanguage,
      required this.bookDescription});

  String book_name;
  String book_image;
  int book_price;
  String author_name;
  final String prokashok;
  final String subject;
  final String translator;
  final String coverType;
  final int totalPage;
  final String bookEdition;
  final String bookLanguage;
  final String bookDescription;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool _currentlyDownloading = false;
  String _percentage = '0%';
  bool _showProgress = false;

  Future<bool> doesFileExist(String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    return File(filePath).existsSync();
  }

  Future<void> downloadPdf(String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';

    File pdfFile = File(filePath);
    if (!pdfFile.existsSync()) {
      try {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          if (_currentlyDownloading) {
            Fluttertoast.showToast(
                msg: 'ডাউনলোড চলছে, অনুগ্রহ করে অপেক্ষা করুন');
          } else {
            Fluttertoast.showToast(msg: 'ডাউনলোড হচ্ছে...');
            setState(() {
              _showProgress = true;
            });
            final storageRef =
                FirebaseStorage.instance.ref().child('book/$fileName.pdf');
            final downloadTask = storageRef.writeToFile(pdfFile);

            downloadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
              final progress = snapshot.bytesTransferred / snapshot.totalBytes;
              final percentage = (progress * 100).toStringAsFixed(2);
              setState(() {
                _percentage = '$percentage%';
              });
              // Update UI with the percentage if needed
            });

            await downloadTask;
            Fluttertoast.showToast(msg: 'সফলভাবে ডাউনলোড হয়েছে');
            setState(() {
              _currentlyDownloading = false;
              _percentage = '0%';
            });
            setState(() {
              _showProgress = false;
            });
            openPdfViewer(filePath, fileName);
          }
        } else {
          Fluttertoast.showToast(msg: 'ইন্টারনেট সংযোগ নেই');
        }
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: '$e');
        openPdfViewer(filePath, fileName);
      } catch (e) {
        Fluttertoast.showToast(msg: 'ডাউনলোড ব্যর্থ হয়েছে');
      }
    } else {
      Fluttertoast.showToast(msg: '$filePath');
      openPdfViewer(filePath, fileName);
    }
  }

  void openPdfViewer(String filePath, String pdfHeading) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => PdfPage(
          pdfHeading: pdfHeading,
          filePath: filePath,
        ),
      ),
    );
  }

  Future<bool> isFileCorrupted(String filePath) async {
    try {
      // Open the file
      File file = File(filePath);
      // Read a small chunk of the file to check for corruption
      List<int> bytes = await file.readAsBytes();
      // You can implement your own logic here to check for corruption
      // For example, checking if the bytes are in PDF format
      // For simplicity, I'm just checking if the file size is zero
      if (bytes.isEmpty) {
        return true; // File is corrupted
      } else {
        return false; // File is not corrupted
      }
    } catch (e) {
      // If any error occurs during file reading, consider it as corrupted
      return true;
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      // Delete the file
      File file = File(filePath);
      await file.delete();
    } catch (e) {
      // Handle error if deletion fails
      print('Error deleting file: $e');
    }
  }

  void checkAndDownloadPdf(String fileName) async {
    bool fileExists = await doesFileExist(fileName);

    if (!fileExists) {
      await downloadPdf(fileName);
    } else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      // Check if the file is corrupted
      bool isCorrupted = await isFileCorrupted(filePath);
      if (isCorrupted) {
        // If corrupted, delete the file
        await deleteFile(filePath);
        checkAndDownloadPdf(fileName);
      } else {
        // If not corrupted, open the file
        openPdfViewer(filePath, fileName);
      }
    }
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
        title: Text(widget.book_name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset(
                    'assets/images/${widget.book_image}',
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.book_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    '${widget.book_price} TK',
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
                          'প্রকাশনী : ${widget.prokashok}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          'বিষয় : ${widget.subject}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          'অনুবাদক : ${widget.translator}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          'পৃষ্ঠা : ${widget.totalPage}, কভার : ${widget.coverType}, সংস্করণ : ${widget.bookEdition}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          'ভাষা : ${widget.bookLanguage}',
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
                        widget.bookDescription,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            _showProgress == true
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      height: 100,
                      child: new CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 5.0,
                        percent: double.parse(_percentage.replaceAll('%', '')) /
                            100.0,
                        center: new Text(
                          _percentage,
                          style: TextStyle(fontSize: 10),
                        ),
                        progressColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        WideButton(
                          'কার্ট এ যুক্ত করুন',
                          onPressed: () async {
                            if (cartDetails.bookList
                                .contains(widget.book_name)) {
                              Fluttertoast.showToast(
                                  msg: 'বইটি আগে থেকেই কার্টে যুক্ত করা হয়েছে');
                            } else {
                              cartDetails.addBookName(widget.book_name);
                              cartDetails.addBookPriceCart(
                                  widget.book_name, widget.book_price);
                              cartDetails.addBookAuthorCart(
                                  widget.book_name, widget.author_name);
                              cartDetails.addBookImagePath(
                                  widget.book_name, widget.book_image);
                              cartDetails.addBookQuantityCart(
                                  widget.book_name, 1);
                              cartDetails.updateTotalPrice(widget.book_price);

                              await saveList('bookname', cartDetails.bookList);
                              await saveMap(
                                  'bookprice', cartDetails.bookPriceCart);
                              await saveMap(
                                  'bookauthor', cartDetails.bookAuthorCart);
                              await saveMap(
                                  'bookimage', cartDetails.bookImagePath);
                              await saveMap(
                                  'bookquantity', cartDetails.bookQuantityCart);
                              await saveDataToDevice('totalprice',
                                  cartDetails.totalPrice.toString());

                              Fluttertoast.showToast(
                                  msg: 'বইটি কার্টে যুক্ত করা হয়েছে');
                            }

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
                          onPressed: () {
                            checkAndDownloadPdf(widget.book_name);
                          },
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
