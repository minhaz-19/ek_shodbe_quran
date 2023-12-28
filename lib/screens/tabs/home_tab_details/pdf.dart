import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
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
  var _currentPage;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    setState(() {
      _currentPage = 1;
    });
  }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();

  Future<void> _captureAndShare() async {
    RenderRepaintBoundary boundary = _containerKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List uint8List = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/page_image.png').create();
    await file.writeAsBytes(uint8List);

    // Now, you can use the 'file' to share the image
    // Implement the code to share the image as needed
    // Share the captured image using the share_plus package
    await Share.shareFiles([file.path],
        text: 'Check out this PDF page image!',
        subject: 'PDF Page Image',
        mimeTypes: ['image/png']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pdfHeading,
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
                  child: SfPdfViewer.file(
          File('${widget.filePath}'),
                    key: _pdfViewerKey,
                    controller: _pdfViewerController,
                    scrollDirection: PdfScrollDirection.horizontal,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    canShowScrollHead: false,
                    enableDoubleTapZooming: true,
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
                onPressed: _captureAndShare,
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
