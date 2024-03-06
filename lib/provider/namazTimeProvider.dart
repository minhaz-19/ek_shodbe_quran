import 'package:flutter/material.dart';

class NamazTimeProvider with ChangeNotifier {
  var fajr;
  var sunrise;
  var dhuhr;
  var asr;
  var sunset;
  var maghrib;
  var isha;

  DateTime? fajrTime;
  DateTime? sunriseTime;
  DateTime? dhuhrTime;
  DateTime? asrTime;
  DateTime? sunsetTime;
  DateTime? maghribTime;
  DateTime? ishaTime;

  void setNamazTime(var fajr, var dhuhr, var asr, var maghrib, var isha,
      var sunrise, var sunset) {
    this.fajr = fajr;
    this.sunrise = sunrise;
    this.dhuhr = dhuhr;
    this.asr = asr;
    this.sunset = sunset;
    this.maghrib = maghrib;
    this.isha = isha;
    notifyListeners();
  }

  DateTime namazTimeBasedOnAlarmId(int alarmId) {
    switch (alarmId) {
      case 1:
        return fajrTime ?? DateTime.now();
      case 7:
        return sunriseTime ?? DateTime.now();
      case 2:
        return dhuhrTime ?? DateTime.now();
      case 3:
        return asrTime ?? DateTime.now();
      case 8:
        return sunsetTime ?? DateTime.now();
      case 4:
        return maghribTime ?? DateTime.now();
      case 5:
        return ishaTime ?? DateTime.now();
      default:
        return DateTime.now();
    }
  }

  void setNamazTimeDateTime(DateTime fajr, DateTime dhuhr, DateTime asr,
      DateTime maghrib, DateTime isha, DateTime sunrise) {
    fajrTime = fajr;
    sunriseTime = sunrise;
    dhuhrTime = dhuhr;
    asrTime = asr;
    sunsetTime = maghrib.subtract(const Duration(minutes: 10));
    maghribTime = maghrib;
    ishaTime = isha;
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

  void clearNamazTimeDateTime() {
    fajrTime = null;
    sunriseTime = null;
    dhuhrTime = null;
    asrTime = null;
    sunsetTime = null;
    maghribTime = null;
    ishaTime = null;
    notifyListeners();
  }
}
