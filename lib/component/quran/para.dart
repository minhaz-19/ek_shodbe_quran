import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Para extends StatefulWidget {
  const Para({super.key});

  @override
  State<Para> createState() => _ParaState();
}

class _ParaState extends State<Para> {
  bool _isLoading = false;
  int _currentDownloadingIndex = 0;
  String _percentage = '0%';

  @override
  initState() {
    initializeParaPage();
    super.initState();
  }

  void initializeParaPage() async {
    setState(() {
      _isLoading = true;
    });
    var sura_para_details =
        Provider.of<SurahParaProvider>(context, listen: false);
    // await FirebaseFirestore.instance
    //     .collection('para')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     sura_para_details.addParaList(doc['name'], doc.id);
    //     // surahList[doc.id] = doc['name'];
    //   });
    // }).then((value) {
    //   findDownloadedPara();
    // });
    findDownloadedPara();
    setState(() {
      _isLoading = false;
    });
  }

  void findDownloadedPara() async {
    var sura_para_details =
        Provider.of<SurahParaProvider>(context, listen: false);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    sura_para_details.paraList.forEach((key, value) {
      String filePath = '$appDocPath/$value.pdf';
      File pdfFile = File(filePath);
      if (pdfFile.existsSync()) {
        sura_para_details.addDownloadedParaIndex(key);
        // downloadedSurahIndex.add(key);
      }
    });
  }

  Future<bool> doesFileExist(String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    return File(filePath).existsSync();
  }

  Future<void> downloadPdf(String fileName, String index) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';

    File pdfFile = File(filePath);
    if (!pdfFile.existsSync()) {
      try {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          Fluttertoast.showToast(msg: 'ডাউনলোড হচ্ছে...');
          setState(() {
            _currentDownloadingIndex = int.parse(index);
          });
          final downloadTask = FirebaseStorage.instance
              .ref()
              .child(
                  'para/$fileName') // Replace 'pdfs' with your Firebase Storage path
              .writeToFile(pdfFile);

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
          var sura_para_details =
              Provider.of<SurahParaProvider>(context, listen: false);
          sura_para_details.addDownloadedParaIndex(index);
          openPdfViewer(filePath, fileName);
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

  void checkAndDownloadPdf(String fileName, String index) async {
    bool fileExists = await doesFileExist(fileName);

    if (!fileExists) {
      await downloadPdf(fileName, index);
    } else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      // Check if the file is corrupted
      bool isCorrupted = await isFileCorrupted(filePath);
      if (isCorrupted) {
        // If corrupted, delete the file
        await deleteFile(filePath);
        Fluttertoast.showToast(
            msg: 'ফাইল ক্ষতিগ্রস্ত হয়েছে এবং মুছে ফেলা হয়েছে');
      } else {
        // If not corrupted, open the file
        openPdfViewer(filePath, fileName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var sura_para_details = Provider.of<SurahParaProvider>(context);
    return (_isLoading)
        ? const ProgressBar()
        : ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: sura_para_details.paraList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  checkAndDownloadPdf(
                      '${sura_para_details.paraList['${index + 1}']}.pdf',
                      '${index + 1}');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Card(
                    elevation: 3,
                    color: Color.fromRGBO(230, 245, 250, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          '${sura_para_details.paraList['${index + 1}']}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: (sura_para_details.downloadedParaIndex
                                .contains('${index + 1}'))
                            ? null
                            : (_currentDownloadingIndex == index + 1)
                                ? SizedBox(
                                    width: 70,
                                    child: new LinearPercentIndicator(
                                      width: 70.0,
                                      lineHeight: 14.0,
                                      percent: double.parse(
                                              _percentage.replaceAll('%', '')) /
                                          100.0,
                                      center: Text(
                                        _percentage,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 8),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                      progressColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/icons/download.png',
                                    height: 30,
                                    width: 30,
                                  ),
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/icons/star.png'),
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
                                    '${index + 1}',
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
                ),
              );
            },
          );
  }
}
