import 'dart:convert';

import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/environment.dart';
import 'package:fashon_shop/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WhishlistNotifier with ChangeNotifier {
  String? error;

  void setError(String e) {
    error = e;
    notifyListeners();
  }

  void addRemoveWhishlist(int id, Function refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/whishlist/toggle/?id=$id');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        setToList(id);
        refetch();
      } else if (response.statusCode == 204) {
        setToList(id);
        refetch();
      }
    } catch (e) {
      setError(e.toString());
    }
  }

  List _whishlist = [];

  List get whishlist => _whishlist;

  void setWhishlist(List w) {
    _whishlist.clear();
    _whishlist = w;
    notifyListeners();
  }

  void setToList(int v) {
    String? accessToken = Storage().getString('accessToken');

    String? whishlist = Storage().getString('${accessToken}whishlist');

    if (whishlist == null) {
      List whishlist = [];
      whishlist.add(v);
      setWhishlist(whishlist);

      Storage().setString('${accessToken}whishlist', jsonEncode(whishlist));
    } else {
      List w = jsonDecode(whishlist);

      if (w.contains(v)) {
        w.removeWhere((e) => e == v);
        setWhishlist(w);

        Storage().setString('${accessToken}whishlist', jsonEncode(w));
      } else if (!w.contains(v)) {
        w.add(v);
        setWhishlist(w);

        Storage().setString('${accessToken}whishlist', jsonEncode(w));
      }
    }
  }

  void getWhishListOnInitialLoad() {
    String? accessToken = Storage().getString('accessToken');

    String? whishlist = Storage().getString('${accessToken}whishlist');

    if (whishlist == null) {
      setWhishlist([]);
    } else {
      List w = jsonDecode(whishlist);

      setWhishlist(w);
    }
  }
}
