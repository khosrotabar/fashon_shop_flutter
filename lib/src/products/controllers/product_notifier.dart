import 'package:fashon_shop/src/products/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  Products? product;
  bool _description = false;

  void setProduct(Products p) {
    product = p;
    notifyListeners();
  }

  bool get description => _description;

  void setDescription(bool desc) {
    _description = desc;
    notifyListeners();
  }
}
