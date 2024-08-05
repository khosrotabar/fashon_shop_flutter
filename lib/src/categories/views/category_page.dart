import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashon_shop/src/categories/controllers/category_notifier.dart';
import 'package:fashon_shop/src/categories/hook/fetch_products_by_category.dart';
import 'package:fashon_shop/src/categories/widgets/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryNotifier>(context);
    final results = fetchProductsByCategory(controller.id);
    final products = results.products;
    final isLoding = results.isLoading;

    if (isLoding) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
          text: controller.category,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ProductsByCategory(products: products),
    );
  }
}
