import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/const/constants.dart';
import 'package:fashon_shop/src/products/controllers/color_size_notifier.dart';
import 'package:fashon_shop/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(
      builder: (_, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (index) {
              String c = context.read<ProductNotifier>().product!.colors[index];
              return GestureDetector(
                onTap: () {
                  controller.setColor(c);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: kRadiusAll,
                    color: c == controller.color ? Kolors.kPrimary : Kolors.kGray,
                  ),
                  child: ReusableText(
                    text: c,
                    style: appStyle(
                      12,
                      Kolors.kWhite,
                      FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
