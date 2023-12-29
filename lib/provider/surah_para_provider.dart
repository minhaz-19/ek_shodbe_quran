import 'package:flutter/material.dart';

class SurahParaProvider with ChangeNotifier {
  List<String> downloadedSurahIndex = [];
  Map<String, dynamic> surahList = {};
  Map<String, dynamic> paraList = {};

  void addSurahList(String surahName, String surahIndex) {
    surahList[surahIndex] = surahName;
    notifyListeners();
  }

  void addParaList(String paraName, String paraIndex) {
    paraList[paraIndex] = paraName;
    notifyListeners();
  }

  void addDownloadedSurahIndex(String surahIndex) {
    downloadedSurahIndex.add(surahIndex);
    notifyListeners();
  }
}
