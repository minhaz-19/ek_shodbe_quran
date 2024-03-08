import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/qiblah_compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class Kiblah extends StatefulWidget {
  const Kiblah({super.key});

  @override
  State<Kiblah> createState() => _KiblahState();
}

class _KiblahState extends State<Kiblah> {
final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

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
          title: const Text('কিবলা'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return ProgressBar();
            if (snapshot.hasError)
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );

            if (snapshot.data!)
              return QiblahCompass();
            else
              return Center(child: Container(child: Text('Device does not support compass'),));
          },
        ),
        );
  }
}
