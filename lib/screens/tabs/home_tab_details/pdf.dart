import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PdfPage extends StatefulWidget {
  final String pdfHeading;
  var filePath;

  PdfPage({required this.pdfHeading, required this.filePath});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  final ScreenshotController screenshotController = ScreenshotController();
  var _currentPage = 0;
  var _totalPages;

  void _takeScreenshot() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 0))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        // await Share.shareFiles([imagePath.path]);
        Share.shareFiles([imagePath.path], text: 'আমার পড়া বইটি শেয়ার করছি');
      }
    });
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

  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pdfHeading.split('.').first,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black45
            : Colors.white,
      ),
      body: RepaintBoundary(
        key: _containerKey,
        child: Screenshot(
          controller: screenshotController,
          child: PDFView(
            filePath: widget.filePath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) async {
              await deleteFile(widget.filePath);
              Fluttertoast.showToast(
                  msg: 'ফাইল ক্ষতিগ্রস্ত হয়েছে এবং মুছে ফেলা হয়েছে');
            },
            onRender: (pages) {
              setState(() {
                _totalPages = pages;
              });
            },
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page ?? 1;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            SizedBox(
              child: Text(
                'পৃষ্ঠা: ${_currentPage + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 1),
                  IconButton(
                    onPressed: () {
                      if (_currentPage > 0) {
                        _controller.future.then((value) {
                          value.setPage(_currentPage - 1);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  if (_currentPage < _totalPages - 1) {
                    _controller.future.then((value) {
                      value.setPage(_currentPage + 1);
                    });
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  _takeScreenshot();
                },
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
