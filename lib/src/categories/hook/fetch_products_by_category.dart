import 'package:fashon_shop/common/utils/environment.dart';
import 'package:fashon_shop/src/categories/hook/results/products_results.dart';
import 'package:fashon_shop/src/products/models/products_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:http/http.dart" as http;

FetchProducts fetchProductsByCategory(int categoryId) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/category/?category=$categoryId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;

    fetchData();
  }

  return FetchProducts(products: products.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
