import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  int totalPrice = 0;

  void updateTotalPrice(int addPrice) {
    totalPrice += addPrice;
    notifyListeners();
  }
  int getTotalPrice() {
    return totalPrice;
  }
}
