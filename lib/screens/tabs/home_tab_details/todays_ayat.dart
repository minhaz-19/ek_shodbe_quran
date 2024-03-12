import 'dart:math';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/readable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysAyat extends StatefulWidget {
  const TodaysAyat({super.key});

  @override
  State<TodaysAyat> createState() => _TodaysAyatState();
}

class _TodaysAyatState extends State<TodaysAyat> {
  // choose a random variable between 1 to 114
  var surahNumber;
  var ayatNumber;
  var ayatText;
  var ayatTranslation;
  bool _isLoading = false;
  bool _loadfromlocal = false;
  @override
  void initState() {
    _initializeTodaysAyat();
    super.initState();
  }

  void _initializeTodaysAyat() async {
    setState(() {
      _isLoading = true;
    });
    surahNumber = Random().nextInt(114) + 1;
    int totalAyat = Readable.QuranData[surahNumber - 1]["total_verses"];
    ayatNumber = Random().nextInt(totalAyat) + 1;
    setState(() {
      _isLoading = false;
    });
    // try {
    //   var sura_para_details =
    //       Provider.of<SurahParaProvider>(context, listen: false);
    //   // await FirebaseFirestore.instance
    //   //     .collection('surah')
    //   //     .get()
    //   //     .then((QuerySnapshot querySnapshot) {
    //   //   querySnapshot.docs.forEach((doc) {
    //   //     sura_para_details.addSurahList(doc['name'], doc.id);
    //   //   });

    //   // });
    //   setState(() {
    //       _isLoading = false;
    //     });
    // } catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //     _loadfromlocal = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var sura_para_details = Provider.of<SurahParaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage(
              'assets/images/toprectangle.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        foregroundColor: Colors.white,
        title: const Text('আজকের আয়াত'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const ProgressBar()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Readable.QuranData[surahNumber - 1]['verses'][ayatNumber - 1]["text"]}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '"${Readable.QuranData[surahNumber - 1]['verses'][ayatNumber - 1]["translation"]}"',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      _loadfromlocal
                          ? 'সূরা ${Readable.QuranData[surahNumber - 1]['transliteration']}, আয়াত - $ayatNumber'
                          : 'সূরা ${sura_para_details.surahList['${surahNumber}']}, আয়াত - $ayatNumber',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
