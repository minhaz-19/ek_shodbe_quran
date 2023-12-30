import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
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
          title: const Text('লোকেশন নির্বাচন করুন'),
          centerTitle: true,
        ),
        body: OpenStreetMapSearchAndPick(
          buttonTextStyle:
              const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
          buttonColor: Theme.of(context).primaryColor,
          locationPinIconColor: Theme.of(context).primaryColor,
          locationPinTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
          buttonText: 'নির্বাচন করুন',
          hintText: 'লোকেশন অনুসন্ধান করুন',
          locationPinText: 'লোকেশন',
          onPicked: (pickedData) {
            saveDataToDevice(
                'current latitude', '${pickedData.latLong.latitude}');
            saveDataToDevice(
                'current longitude', '${pickedData.latLong.longitude}');
            Navigator.pop(context);
            
          },
        ));
  }
}
