import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';

class Tilawat extends StatefulWidget {
  const Tilawat({super.key});

  @override
  State<Tilawat> createState() => _TilawatState();
}

class _TilawatState extends State<Tilawat> {
  bool _isLoading = false;
  int _currentSurah = 0;
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(
                'assets/images/toprectangle.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.white,
          title: const Text('তিলাওয়াত'),
          centerTitle: true,
        ),
        body: (_isLoading)
            ? const ProgressBar()
            : ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: 114,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
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
                              '${getSurahName(index + 1)}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${getVerseCount(index + 1)} আয়াত',
                              style: TextStyle(color: Colors.black54),
                            ),
                            trailing: _currentSurah == (index + 1)
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentSurah = 0;
                                      });
                                      player.pause();
                                    },
                                    child: Icon(
                                      Icons.pause_circle_filled,
                                      color: Theme.of(context).primaryColor,
                                      size: 40,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _currentSurah = index + 1;
                                      });
                                      var url = getAudioURLBySurah(index + 1);
                                      await player.setAsset(url);
                                      player.play();
                                    },
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Theme.of(context).primaryColor,
                                      size: 40,
                                    ),
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
              ));
  }
}
