import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/src/categories/controllers/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryNotifier>(context);

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
    );
  }
}
