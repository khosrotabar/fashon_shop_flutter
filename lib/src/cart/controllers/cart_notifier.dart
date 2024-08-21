import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/environment.dart';
import 'package:fashon_shop/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartNotifier with ChangeNotifier {
  int _qty = 0;

  int get qty => _qty;

  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectedCart;
  int? get selectedCart => _selectedCart;

  void setSelectedCounter(int id, int q) {
    _selectedCart = id;
    _qty = q;
    notifyListeners();
  }

  void clearSelected() {
    _selectedCart = null;
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 204) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      TLoggerHelper.debug(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      TLoggerHelper.debug(e.toString());
    }
  }

  Future<void> addToCart(String data) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');

      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {}
    } catch (e) {
      TLoggerHelper.debug(e.toString());
    }
  }
}
