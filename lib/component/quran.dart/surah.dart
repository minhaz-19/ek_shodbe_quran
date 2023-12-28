import 'dart:io';

import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
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
        Fluttertoast.showToast(msg: 'ডাউনলোড হচ্ছে...');
        await FirebaseStorage.instance
            .ref()
            .child(fileName) // Replace 'pdfs' with your Firebase Storage path
            .writeToFile(pdfFile);
        Fluttertoast.showToast(msg: 'সফলভাবে ডাউনলোড হয়েছে');
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: '$e');
      } catch (e) {
        Fluttertoast.showToast(msg: 'ডাউনলোড ব্যর্থ হয়েছে');
      }
    } else {
      openPdfViewer(filePath);
    }
  }

  void openPdfViewer(String filePath) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => PdfPage(
          pdfHeading: 'সূরা আল ফাতিহা',
          filePath: filePath,
        ),
      ),
    );
  }

  void checkAndDownloadPdf(String fileName) async {
    bool fileExists = await doesFileExist(fileName);

    if (!fileExists) {
      await downloadPdf(fileName);
    }

    openPdfViewer(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Card(
            elevation: 3,
            color: Color.fromRGBO(230, 245, 250, 1.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                onTap: () {
                  checkAndDownloadPdf('C++ - The Complete Reference.pdf');
                },
                title: Text(
                  'সূরা আল ফাতিহা',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'الفاتحة' + ' - ' + 'সূচনা',
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Image.asset(
                  'assets/icons/download.png',
                  height: 30,
                  width: 30,
                ),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/star.png'),
                      backgroundColor: Colors.transparent,
                      radius: 25,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '114',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
