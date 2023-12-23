import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
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
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) =>  PdfPage(
                        pdfHeading:'সূরা আল ফাতিহা' ,
                      ),
                    ),
                  );
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
