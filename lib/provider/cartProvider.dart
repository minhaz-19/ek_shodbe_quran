import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  dynamic totalPrice = 0;
  Map<String, dynamic> bookAuthorCart = {};
  Map<String, dynamic> bookQuantityCart = {};
  Map<String, dynamic> bookPriceCart = {};
  Map<String, dynamic> bookImagePath = {};
  List<String> bookList = [];

  void updateTotalPrice(int addPrice) {
    totalPrice += addPrice;
    notifyListeners();
  }

  void addBookAuthorCart(String bookName, String authorName) {
    bookAuthorCart[bookName] = authorName;
    notifyListeners();
  }

  void addBookQuantityCart(String bookName, int quantity) {
    bookQuantityCart[bookName] = quantity;
    notifyListeners();
  }

  String getBookAuthorCart(String bookName) {
    return bookAuthorCart[bookName];
  }

  int getBookQuantityCart(String bookName) {
    return bookQuantityCart[bookName];
  }

  void deleteBook(String bookName) {
    bookList.remove(bookName);
    bookAuthorCart.remove(bookName);
    bookQuantityCart.remove(bookName);
    bookPriceCart.remove(bookName);
    bookImagePath.remove(bookName);
    notifyListeners();
  }

  void deleteAllBook() {
    bookList.clear();
    bookAuthorCart.clear();
    bookQuantityCart.clear();
    bookPriceCart.clear();
    bookImagePath.clear();
    notifyListeners();
  }

  void addBookName(String bookName) {
    bookList.add(bookName);
    notifyListeners();
  }

  List<String> getBookList() {
    return bookList;
  }

  void addBookImagePath(String bookName, String imagePath) async {
    bookImagePath[bookName] = imagePath;
    notifyListeners();
  }

  String getBookImagePath(String bookName) {
    return bookImagePath[bookName];
  }

  void addBookPriceCart(String bookName, int price) {
    bookPriceCart[bookName] = price;
    notifyListeners();
  }

  int getBookPriceCart(String bookName) {
    return bookPriceCart[bookName];
  }

  void calculateTotalPrice() {
    dynamic total = 0;
    for (int i = 0; i < bookList.length; i++) {
      total += bookPriceCart[bookList[i]] * bookQuantityCart[bookList[i]];
    }
    totalPrice = total;

    notifyListeners();
  }

  void createMapFromSharedPreference(Map<String, dynamic> map, String mapName) {
    bookList = map.keys.toList();
    for (int i = 0; i < bookList.length; i++) {
      if (mapName == 'bookprice') {
        bookPriceCart[bookList[i]] = map[bookList[i]];
      } else if (mapName == 'bookauthor') {
        bookAuthorCart[bookList[i]] = map[bookList[i]];
      } else if (mapName == 'bookimage') {
        bookImagePath[bookList[i]] = map[bookList[i]];
      } else if (mapName == 'bookquantity') {
        bookQuantityCart[bookList[i]] = map[bookList[i]];
      }
    }
    notifyListeners();
  }

  Future<void> initializeFromSharedPreferences() async {
    // Fetch the maps from SharedPreferences
    // bookList = await getList('bookname') ;
    bookPriceCart = await getMap('bookprice');
    bookAuthorCart = await getMap('bookauthor');
    bookImagePath = await getMap('bookimage');
    bookQuantityCart = await getMap('bookquantity');
    bookList = bookPriceCart.keys.toList();

    notifyListeners();
  }
}
