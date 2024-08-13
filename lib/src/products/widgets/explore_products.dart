import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/widgets/login_bottom_sheet.dart';
import 'package:fashon_shop/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashon_shop/const/resource.dart';
import 'package:fashon_shop/src/home/controllers/home_tab_notifier.dart';
import 'package:fashon_shop/src/products/hook/fetch_products.dart';
import 'package:fashon_shop/src/products/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ExploreProducts extends HookWidget {
  const ExploreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final controller = Provider.of<HomeTabNotifier>(context);
    final results = fetchProducts(controller.queryType);
    final products = results.products;
    final isLoding = results.isLoading;

    if (isLoding) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListShimmer(),
      );
    }

    return products.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(25),
            child: Image.asset(
              R.ASSETS_IMAGES_EMPTY_PNG,
              height: ScreenUtil().screenHeight * 0.3,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: StaggeredGrid.count(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 4,
              children: List.generate(products.length, (index) {
                final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
                final product = products[index];
                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: mainAxisCellCount,
                  child: StaggeredTileWidget(
                    i: index,
                    product: product,
                    onTap: () {
                      if (accessToken == null) {
                        loginBottomSheet(context);
                      } else {
                        // handle whishlist functionality
                      }
                    },
                  ),
                );
              }),
            ),
          );
  }
}
