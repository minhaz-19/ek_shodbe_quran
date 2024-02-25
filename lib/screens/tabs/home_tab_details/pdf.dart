import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  final String pdfHeading;
  var filePath;

  PdfPage({required this.pdfHeading, required this.filePath});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  late PdfViewerController _pdfViewerController;
  final ScreenshotController screenshotController = ScreenshotController();
  var _currentPage;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    setState(() {
      _currentPage = 1;
    });
  }

  void _takeScreenshot() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
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

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: RepaintBoundary(
                  key: _containerKey,
                  child: Screenshot(
                    controller: screenshotController,
                    child: SfPdfViewer.file(
                      File('${widget.filePath}'),
                      key: _pdfViewerKey,
                      controller: _pdfViewerController,
                      scrollDirection: PdfScrollDirection.horizontal,
                      pageLayoutMode: PdfPageLayoutMode.single,
                      canShowScrollHead: false,
                      enableDoubleTapZooming: true,
                      onDocumentLoadFailed:
                          (PdfDocumentLoadFailedDetails details) async {
                        await deleteFile(widget.filePath);
                        Fluttertoast.showToast(
                            msg: 'ফাইল ক্ষতিগ্রস্ত হয়েছে এবং মুছে ফেলা হয়েছে');
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                _pdfViewerController.previousPage();
                                if (_currentPage > 1) {
                                  setState(() {
                                    _currentPage--;
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
                            _pdfViewerController.nextPage();
                            if (_currentPage < _pdfViewerController.pageCount) {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 14.0,
            left: 20.0,
            child: SizedBox(
              child: Text(
                'পৃষ্ঠা: $_currentPage',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: 20.0,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
