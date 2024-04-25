import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int selectedindex = 0;

  void onItemTapped(int index) {
    selectedindex = index;
    notifyListeners();
  }
}
