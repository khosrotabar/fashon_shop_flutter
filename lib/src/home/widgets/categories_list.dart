import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/common/widgets/shimmers/categories_shimmer.dart';
import 'package:fashon_shop/src/categories/controllers/category_notifier.dart';
import 'package:fashon_shop/src/categories/hook/fetch_home_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesList extends HookWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.categories;
    final isLoding = results.isLoading;

    if (isLoding) {
      return const CatergoriesShimmer();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () {
                  context.read<CategoryNotifier>().setCategory(category.title, category.id);
                  context.push('/category');
                },
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: SvgPicture.network(
                            category.imageUrl,
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                      ),
                      ReusableText(
                        text: category.title,
                        style: appStyle(
                          12,
                          Kolors.kGray,
                          FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
