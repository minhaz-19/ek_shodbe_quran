import 'package:flutter/material.dart';

class SurahParaProvider with ChangeNotifier {
  List<String> downloadedSurahIndex = [];
  List<String> downloadedParaIndex = [];
  String ReciterName = 'ar.alafasy';

  Map<String, dynamic> surahList = {
    "1": "আল- ফাতিহা",
    "2": "আল-বাকারা",
    "3": "আল ইমরান",
    "4": "আন নিসা",
    "5": "আল মায়িদাহ",
    "6": "আল আনআম",
    "7": "আল আরাফ",
    "8": "আল আনফাল",
    "9": "আত-তাওবাহ্‌",
    "10": "ইউনুস",
    "11": "হুদ",
    "12": "ইউসুফ",
    "13": "আর-রাদ",
    "14": "ইব্রাহীম",
    "15": "আল হিজর",
    "16": "আন নাহল",
    "17": "বনী-ইসরাঈল",
    "18": "আল কাহফ",
    "19": "মারইয়াম",
    "20": "ত্বোয়া-হা",
    "21": "আল আম্বিয়া",
    "22": "আল হাজ্জ্ব",
    "23": "আল মু'মিনূন",
    "24": "আন নূর",
    "25": "আল ফুরকান",
    "26": "আশ শুআরা",
    "27": "আন নম্‌ল",
    "28": "আল কাসাস",
    "29": "আল আনকাবূত",
    "30": "আর রুম",
    "31": "লোক্‌মান",
    "32": "আস সেজদাহ্",
    "33": "আল আহ্‌যাব",
    "34": "সাবা",
    "35": "ফাতির",
    "36": "ইয়াসীন",
    "37": "আস ছাফ্‌ফাত",
    "38": "ছোয়াদ",
    "39": "আয্‌-যুমার",
    "40": "আল মু'মিন",
    "41": "হা-মীম সেজদাহ্‌",
    "42": "আশ্‌-শূরা",
    "43": "আয্‌-যুখরুফ",
    "44": "আদ-দোখান",
    "45": "আল জাসিয়াহ",
    "46": "আল আহ্‌ক্বাফ",
    "47": "মুহাম্মদ",
    "48": "আল ফাত্‌হ",
    "49": "আল হুজুরাত",
    "50": "ক্বাফ",
    "51": "আয-যারিয়াত",
    "52": "আত্ব তূর",
    "53": "আন-নাজম",
    "54": "আল ক্বামার",
    "55": "আর রাহমান",
    "56": "আল-ওয়াকিয়াহ",
    "57": "আল-হাদীদ",
    "58": "আল-মুজাদালাহ",
    "59": "আল-হাশর",
    "60": "আল-মুমতাহিনাহ",
    "61": "আস-সাফ",
    "62": "আল-জুমুআ",
    "63": "আল-মুনাফিকুন",
    "64": "আত-তাগাবুন",
    "65": "আত-তালাক",
    "66": "আত-তাহরীম",
    "67": "আল-মুলক",
    "68": "আল-কলম",
    "69": "আল-হাক্কাহ",
    "70": "আল-মাআরিজ",
    "71": "নূহ",
    "72": "আল জ্বিন",
    "73": "আল মুজাম্মিল",
    "74": "আল মুদ্দাস্সির",
    "75": "আল-ক্বিয়ামাহ",
    "76": "আদ-দাহর",
    "77": "আল-মুরসালাত",
    "78": "আন নাবা",
    "79": "আন নাযিয়াত",
    "80": "আবাসা",
    "81": "আত-তাকভীর",
    "82": "আল-ইনফিতার",
    "83": "আত মুত্বাফ্‌ফিফীন",
    "84": "আল ইন‌শিকাক",
    "85": "আল-বুরুজ",
    "86": "আত-তারিক্ব",
    "87": "আল আ'লা",
    "88": "আল গাশিয়াহ্‌",
    "89": "আল ফাজ্‌র",
    "90": "আল বালাদ",
    "91": "আশ-শাম্‌স",
    "92": "আল লাইল",
    "93": "আদ-দুহা",
    "94": "আল ইনশিরাহ",
    "95": "ত্বীন",
    "96": "আলাক্ব",
    "97": "ক্বদর",
    "98": "বাইয়্যিনাহ",
    "99": "যিলযাল",
    "100": "আল-আদিয়াত",
    "101": "ক্বারিয়াহ",
    "102": "তাকাসুর",
    "103": "আছর",
    "104": "হুমাযাহ",
    "105": "ফীল",
    "106": "কুরাইশ",
    "107": "মাউন",
    "108": "কাওসার",
    "109": "কাফিরুন",
    "110": "নাসর",
    "111": "লাহাব",
    "112": "আল-ইখলাস",
    "113": "আল-ফালাক",
    "114": "আন-নাস",
  };
  Map<String, dynamic> surahBengaliList = {};
  Map<String, dynamic> surahArabicList = {};
  Map<String, dynamic> paraList = {
    '1': '১ পারা',
    '2': '২ পারা',
    '3': '৩ পারা',
    '4': '৪ পারা',
    '5': '৫ পারা',
    '6': '৬ পারা',
    '7': '৭ পারা',
    '8': '৮ পারা',
    '9': '৯ পারা',
    '10': '১০ পারা',
    '11': '১১ পারা',
    '12': '১২ পারা',
    '13': '১৩ পারা',
    '14': '১৪ পারা',
    '15': '১৫ পারা',
    '16': '১৬ পারা',
    '17': '১৭ পারা',
    '18': '১৮ পারা',
    '19': '১৯ পারা',
    '20': '২০ পারা',
    '21': '২১ পারা',
    '22': '২২ পারা',
    '23': '২৩ পারা',
    '24': '২৪ পারা',
    '25': '২৫ পারা',
    '26': '২৬ পারা',
    '27': '২৭ পারা',
    '28': '২৮ পারা',
    '29': '২৯ পারা',
    '30': '৩০ পারা',
  };

  dynamic copySurahList(Map<String, dynamic> surahList) {
    this.surahList = surahList;
    notifyListeners();
  }

  void addSurahList(String surahName, String surahIndex) {
    surahList[surahIndex] = surahName;
    notifyListeners();
  }

  void addSurahBengaliList(String surahName, String surahIndex) {
    surahBengaliList[surahIndex] = surahName;
    notifyListeners();
  }

  void addSurahArabicList(String surahName, String surahIndex) {
    surahArabicList[surahIndex] = surahName;
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

  void changeReciterName(String reciterName) {
    ReciterName = reciterName;
    notifyListeners();
  }
}

Map<String, dynamic> surah = {};
