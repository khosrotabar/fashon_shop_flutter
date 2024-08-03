import 'package:flutter/material.dart';

class ColorSizesNotifier with ChangeNotifier {
  String _size = '';
  String _color = '';
  String get size => _size;
  String get color => _color;

  void setSize(String s) {
    if (_size == s) {
      _size = '';
    } else {
      _size = s;
    }

    notifyListeners();
  }

  void setColor(String c) {
    if (_color == c) {
      _color = '';
    } else {
      _color = c;
    }

    notifyListeners();
  }
}
