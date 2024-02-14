import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/readable.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  bool _isLoading = false;

  @override
  initState() {
    initializeSurahPage();
    super.initState();
  }

  void initializeSurahPage() async {
    setState(() {
      _isLoading = true;
    });
    var sura_para_details =
        Provider.of<SurahParaProvider>(context, listen: false);
    // await FirebaseFirestore.instance
    //     .collection('surah')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     // sura_para_details.addSurahList(doc['name'], doc.id);
    //     // sura_para_details.addSurahArabicList(doc['arabic'], doc.id);
    //     // sura_para_details.addSurahBengaliList(doc['bengali'], doc.id);
    //   });
    // }).then((value) {

    // });

    findDownloadedSurah();

    setState(() {
      _isLoading = false;
    });
  }

  void findDownloadedSurah() async {
    var sura_para_details =
        Provider.of<SurahParaProvider>(context, listen: false);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    sura_para_details.surahList.forEach((key, value) {
      String filePath = '$appDocPath/$value.pdf';
      File pdfFile = File(filePath);
      if (pdfFile.existsSync()) {
        sura_para_details.addDownloadedSurahIndex(key);
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
          await FirebaseStorage.instance
              .ref()
              .child(
                  'surah/$fileName') // Replace 'pdfs' with your Firebase Storage path
              .writeToFile(pdfFile);
          Fluttertoast.showToast(msg: 'সফলভাবে ডাউনলোড হয়েছে');
          var sura_para_details =
              Provider.of<SurahParaProvider>(context, listen: false);
          sura_para_details.addDownloadedSurahIndex(index);
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

  void checkAndDownloadPdf(String fileName, String index) async {
    bool fileExists = await doesFileExist(fileName);

    if (!fileExists) {
      await downloadPdf(fileName, index);
    } else {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      openPdfViewer(filePath, fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sura_para_details = Provider.of<SurahParaProvider>(context);
    return (_isLoading)
        ? const ProgressBar()
        : ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: sura_para_details.surahList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  checkAndDownloadPdf(
                      '${sura_para_details.surahList['${index + 1}']}.pdf',
                      '${index + 1}');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Card(
                    elevation: 3,
                    color: const Color.fromRGBO(230, 245, 250, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        // onTap: () {
                        //   checkAndDownloadPdf('${sura_para_details.surahList['${index + 1}']}.pdf', '${index + 1}');
                        // },
                        title: Text(
                          'সূরা ${sura_para_details.surahList['${index + 1}']}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${Readable.QuranData[index]['name']}' +
                              ' - ' +
                              '${Readable.QuranData[index]['translation']}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        trailing: (sura_para_details.downloadedSurahIndex
                                .contains('${index + 1}'))
                            ? null
                            : Image.asset(
                                'assets/icons/download.png',
                                height: 30,
                                width: 30,
                              ),
                        leading: Stack(
                          children: [
                            const CircleAvatar(
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
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
