import 'dart:convert';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/surah_audio.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/readable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SurahRecite extends StatefulWidget {
  // final surah;
  final int surahNumber;
  final String surahName;

  const SurahRecite(
      {Key? key, required this.surahNumber, required this.surahName})
      : super(key: key);

  @override
  State<SurahRecite> createState() => _SurahState();
}

class _SurahState extends State<SurahRecite> {
  var surah;
  final ScrollController _scrollController = ScrollController();
  late int currentIndex;
  late int maxIndex;
  final surahAudioPlayer = AssetsAudioPlayer();
  bool isPlayingAudio = false;
  bool isPlayable = false;
  String _reciterName = 'ar.alafasy';
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState

    _initialize();
    super.initState();
  }

  void _initialize() async {
    setState(() {
      _isLoading = true;
      _reciterName =
          Provider.of<SurahParaProvider>(context, listen: false).ReciterName;
    });
    surah = Readable.QuranData[widget.surahNumber - 1];
    maxIndex = surah['verses'].length - 1;
    currentIndex = maxIndex > 10 ? 10 : maxIndex;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
        debugPrint('End Scroll');
      }
    });
    await _getAudio();
    surahAudioPlayer.isPlaying.listen((isPlaying) {
      if (mounted) {
        setState(() {
          isPlayingAudio = isPlaying;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    surahAudioPlayer.stop();
    super.dispose();
  }

  Future<SurahAudio> fetchAlbum() async {
    String surahNumber = widget.surahNumber.toString();
    String url = 'https://api.alquran.cloud/v1/surah/$surahNumber/ar.alafasy';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SurahAudio.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _getAudio() async {
    await fetchAlbum().then((value) async {
      try {
        await surahAudioPlayer
            .open(
                playInBackground: PlayInBackground.enabled,
                showNotification: true,
                forceOpen: true,
                Playlist(
                    audios: value.audiourls
                        .map((audio) => Audio.network(audio['audio'],
                            metas: Metas(
                                title: 'সূরা ${widget.surahName}',
                                artist: 'মিশারী রাশিদ আলেফাসি',
                                image: const MetasImage.asset(
                                    'assets/icons/applogo.png'))))
                        .toList()),
                autoStart: false)
            .then((value) {
          setState(() {
            isPlayable = true;
          });
        });

        // assetsAudioPlayer.play();
      } catch (t) {
        //mp3 unreachable
      }
    });
  }

  _playorPauseAudio() async {
    if (isPlayable) {
      if (!isPlayingAudio) {
        surahAudioPlayer.play();
        setState(() {
          isPlayingAudio = true;
        });
      } else {
        // assetsAudioPlayer.stop();
        surahAudioPlayer.pause();

        setState(() {
          isPlayingAudio = false;
        });
      }
    }
  }

  _getMoreData() {
    if (currentIndex < maxIndex) {
      if (currentIndex + 10 < maxIndex) {
        setState(() {
          currentIndex += 10;
        });
      } else {
        setState(() {
          currentIndex = maxIndex;
        });
      }
    } else {
      debugPrint('No more data');
    }
  }

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
          centerTitle: true,
          title: Text('সূরা ${widget.surahName}'),
        ),
        body: _isLoading
            ? const ProgressBar()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SelectableText(
                        surah['name'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lateef(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SelectableText(
                        'بسم الله الرحمن الرحيم',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lateef(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SelectableText(
                                widget.surahName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SelectableText(
                                surah['translation'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 2,
                            height: 40,
                            color: Theme.of(context).highlightColor,
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  surah['type'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SelectableText(
                                  surah['total_verses'].toString() + ' আয়াত',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Divider(
                        height: 5,
                      ),
                      Divider(
                        height: 5,
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: (isPlayingAudio)
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_circle),
                        onPressed: () {
                          _playorPauseAudio();
                        },
                      ),
                      Text(
                        "Play/Pause Audio",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemBuilder: (context, index) {
                      //     if (index == currentIndex && currentIndex < maxIndex) {
                      //       return CupertinoActivityIndicator();
                      //     } else {
                      //       return ListTile(
                      //         leading: SelectableText((index + 1).toString()),
                      //         title: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(
                      //             surah['verses'][index]['text'],
                      //             textAlign: TextAlign.end,
                      //             style: GoogleFonts.lateef(
                      //               textStyle: TextStyle(
                      //                   fontWeight: FontWeight.normal, fontSize: 30),
                      //             ),
                      //             // style: TextStyle(
                      //             //     fontWeight: FontWeight.normal, fontSize: 35),
                      //           ),
                      //         ),
                      //         subtitle: Column(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 surah['verses'][index]['translation'],
                      //                 textAlign: TextAlign.start,
                      //                 style: TextStyle(
                      //                   fontWeight: FontWeight.normal,
                      //                 ),
                      //               ),
                      //             ),
                      //             Divider()
                      //           ],
                      //         ),
                      //         onTap: () {
                      //           surahAudioPlayer.stop();
                      //           Navigator.pushNamed(context,
                      //               '/quran?surah=${surah["id"]}&&ayat=${index + 1}');
                      //           // Navigator.popAndPushNamed(context,
                      //           //     '/quran?surah=${widget.surahNumber}&&ayat=${index + 1}');
                      //         },
                      //       );
                      //     }
                      //   },
                      //   itemCount: currentIndex + 1,
                      // ),
                    ],
                  ),
                ),
              ));
  }
}
