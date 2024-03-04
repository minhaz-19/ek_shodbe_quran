import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/provider/surah_para_provider.dart';
import 'package:ek_shodbe_quran/readable.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/recite_each_surah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tilawat extends StatefulWidget {
  const Tilawat({super.key});

  @override
  State<Tilawat> createState() => _TilawatState();
}

class _TilawatState extends State<Tilawat> {
  bool _isLoading = false;

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
          title: const Text('তিলাওয়াত'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // open dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('তিলাওয়াতের রিসাইটার পরিবর্তন করুন'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         
                          ListTile(
                            title: const Text('মিশারী রাশিদ আলেফাসি'),
                            onTap: () {
                              sura_para_details.ReciterName = 'ar.alafasy';
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: (_isLoading)
            ? const ProgressBar()
            : ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: 114,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SurahRecite(surahNumber: index + 1)));
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
