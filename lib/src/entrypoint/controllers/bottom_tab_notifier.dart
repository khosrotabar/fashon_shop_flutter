import 'package:flutter/material.dart';

class TabIndexNotifier with ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}