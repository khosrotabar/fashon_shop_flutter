import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/const/constants.dart';
import 'package:fashon_shop/src/products/controllers/product_notifier.dart';
import 'package:fashon_shop/src/products/widgets/color_selection_widget.dart';
import 'package:fashon_shop/src/products/widgets/expandable_text.dart';
import 'package:fashon_shop/src/products/widgets/product_bottom_bar.dart';
import 'package:fashon_shop/src/products/widgets/product_sizes_widget.dart';
import 'package:fashon_shop/src/products/widgets/similar_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductNotifier>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Kolors.kWhite,
            expandedHeight: 320.h,
            collapsedHeight: 65.h,
            floating: false,
            pinned: true,
            leading: const AppBackButton(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    backgroundColor: Kolors.kSecondaryLight,
                    child: Icon(
                      AntDesign.heart,
                      color: Kolors.kRed,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: SizedBox(
                height: 415.h,
                child: ImageSlideshow(
                  autoPlayInterval: 15000,
                  isLoop: controller.product!.imageUrls.length > 1 ? true : false,
                  indicatorColor: Kolors.kPrimaryLight,
                  children: List.generate(
                    controller.product!.imageUrls.length,
                    (index) => CachedNetworkImage(
                      placeholder: placeholder,
                      errorWidget: errorWidget,
                      imageUrl: controller.product!.imageUrls[index],
                      height: 415.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: controller.product!.clothesType.toUpperCase(),
                    style: appStyle(13, Kolors.kGray, FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                      ReusableText(
                        text: controller.product!.ratings.toStringAsFixed(2),
                        style: appStyle(13, Kolors.kGray, FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReusableText(
                text: controller.product!.title,
                style: appStyle(16, Kolors.kDark, FontWeight.w600),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: ExpandableText(
                text: controller.product!.description,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Divider(
                thickness: 0.5.h,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReusableText(
                text: "Select Sizes",
                style: appStyle(
                  14,
                  Kolors.kDark,
                  FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5.h,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ProductSizesWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReusableText(
                text: "Select Color",
                style: appStyle(
                  14,
                  Kolors.kDark,
                  FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5.h,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ColorSelectionWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReusableText(
                text: "Similar Products",
                style: appStyle(
                  14,
                  Kolors.kDark,
                  FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5.h,
            ),
          ),
          const SliverToBoxAdapter(
            child: SimilarProducts(),
          ),
        ],
      ),
      bottomNavigationBar: ProductBottomBar(
        price: controller.product!.price.toString(),
      ),
    );
  }
}
