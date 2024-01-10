import 'package:flutter/material.dart';

class SurahParaProvider with ChangeNotifier {
  List<String> downloadedSurahIndex = [];
  List<String> downloadedParaIndex = [];
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

  void addDownloadedParaIndex(String paraIndex) {
    downloadedParaIndex.add(paraIndex);
    notifyListeners();
  }
}
