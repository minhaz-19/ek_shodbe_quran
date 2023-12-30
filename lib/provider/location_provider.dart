import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {

  var latitude;
  var longitude;
  var subLocality;
  var locality;
  var country;

  void setLocation(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
    notifyListeners();
  }

  void setAddress(String subLocality, String locality, String country) {
    this.subLocality = subLocality;
    this.locality = locality;
    this.country = country;
    notifyListeners();
  }

  void clearLocation() {
    this.latitude = null;
    this.longitude = null;
    notifyListeners();
  }
}
