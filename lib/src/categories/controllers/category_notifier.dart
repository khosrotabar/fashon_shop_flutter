import 'package:flutter/material.dart';

class CategoryNotifier with ChangeNotifier {
  String _category = '';
  int _id = 0;

  String get category => _category;
  int get id => _id;

  void setCategory(String c, int id) {
    _category = c;
    _id = id;
    notifyListeners();
  }
}
