import 'package:adhan/adhan.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/location_provider.dart';
import 'package:ek_shodbe_quran/provider/namazTimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  List<Placemark> placemarks = [];
  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<LocationProvider>(context);
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
          onPicked: (pickedData) async {
            var namazTimeData =
                Provider.of<NamazTimeProvider>(context, listen: false);
          await  saveDataToDevice(
                'current latitude', '${pickedData.latLong.latitude}');
          await  saveDataToDevice(
                'current longitude', '${pickedData.latLong.longitude}');
            locationData.setLocation(
                double.parse(pickedData.latLong.latitude.toString()),
                double.parse(pickedData.latLong.longitude.toString()));
            placemarks = await placemarkFromCoordinates(
                locationData.latitude, locationData.longitude);
            locationData.setAddress(
                placemarks[0].subLocality.toString(),
                placemarks[0].locality.toString(),
                placemarks[0].country.toString());
            final myCoordinates =
                Coordinates(locationData.latitude, locationData.longitude);
            final params = CalculationMethod.karachi.getParameters();
            params.madhab = Madhab.hanafi;
            final prayerTimes = PrayerTimes.today(myCoordinates, params);

            var _faazar_time = DateFormat.jm().format(prayerTimes.fajr);
            var _johor_time = DateFormat.jm().format(prayerTimes.dhuhr);
            var _asor_time = DateFormat.jm().format(prayerTimes.asr);
            var _magrib_time = DateFormat.jm().format(prayerTimes.maghrib);
            var _esha_time = DateFormat.jm().format(prayerTimes.isha);
            // _tahajjud_time = DateFormat.jm().format(prayerTimes.);
            var _sunrise_time = DateFormat.jm().format(prayerTimes.sunrise);
            final DateFormat format = DateFormat.jm();
            DateTime responseDateTime = format.parse(_magrib_time);

            // Subtract one minute
            responseDateTime = responseDateTime.subtract(Duration(minutes: 1));

            // Format the adjusted time for display
            String adjustedTime = format.format(responseDateTime);
            var _sunset_time = adjustedTime;

            namazTimeData.setNamazTime(_faazar_time, _johor_time, _asor_time,
                _magrib_time, _esha_time, _sunrise_time, _sunset_time);
            namazTimeData.setNamazTimeDateTime(
                prayerTimes.fajr,
                prayerTimes.dhuhr,
                prayerTimes.asr,
                prayerTimes.maghrib,
                prayerTimes.isha,
                prayerTimes.sunrise);
            Navigator.pop(context);
          },
        ));
  }
}
