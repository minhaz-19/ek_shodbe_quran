import 'package:flutter/material.dart';

class NamazTimeProvider with ChangeNotifier {

  var fajr;
  var sunrise;
  var dhuhr;
  var asr;
  var sunset;
  var maghrib;
  var isha;

  void setNamazTime(var fajr, var dhuhr, var asr, var maghrib, var isha, var sunrise, var sunset) {
    this.fajr = fajr;
    this.sunrise = sunrise;
    this.dhuhr = dhuhr;
    this.asr = asr;
    this.sunset = sunset;
    this.maghrib = maghrib;
    this.isha = isha;
    notifyListeners();
  }

  void clearNamazTime() {
    fajr = null;
    sunrise = null;
    dhuhr = null;
    asr = null;
    sunset = null;
    maghrib = null;
    isha = null;
    notifyListeners();
  }
}
