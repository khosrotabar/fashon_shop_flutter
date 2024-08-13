import 'package:fashon_shop/common/utils/environment.dart';
import 'package:fashon_shop/src/products/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get iaLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Products> _results = [];

  List<Products> get results => _results;

  void setResults(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
    notifyListeners();
  }

  String _searchKey = '';

  String get searchKey => _searchKey;

  void setSearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  String _error = '';

  String get error => _error;

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  void searchFunction(String searchKey) async {
    setIsLoading(true);
    setSearchKey(searchKey);

    Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/search/?q=$searchKey');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = productsFromJson(response.body);

        setResults(data);
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setIsLoading(false);
    }
  }
}