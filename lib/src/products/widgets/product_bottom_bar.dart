import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/error_modal.dart';
import 'package:fashon_shop/common/widgets/login_bottom_sheet.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/src/cart/models/create_cart_model.dart';
import 'package:fashon_shop/src/products/controllers/color_size_notifier.dart';
import 'package:fashon_shop/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.price,
    this.onPress,
  });

  final String price;

  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final controller = Provider.of<ColorSizesNotifier>(context);
    final productNotifier = Provider.of<ProductNotifier>(context);

    return Container(
      height: 68.h,
      color: Colors.white.withOpacity(0.6),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 12.w, 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: ReusableText(
                      text: 'Total Price',
                      style: appStyle(14, Kolors.kGray, FontWeight.w400),
                    ),
                  ),
                  ReusableText(
                    text: "\$ $price",
                    style: appStyle(16, Kolors.kDark, FontWeight.w600),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (accessToken == null) {
                  loginBottomSheet(context);
                } else {
                  if (controller.color == '' || controller.size == '') {
                    showErrorPopup(context, AppText.kCartErrorText, 'Error Adding to Cart', true);
                  } else {
                    CreateCartModel data =
                        CreateCartModel(product: productNotifier.product!.id, quantity: 1, color: controller.color, size: int.parse(controller.size));
                    String cartData = createCartModelToJson(data);

                    print(cartData);
                  }
                }
              },
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Kolors.kPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(FontAwesome.shopping_bag, color: Kolors.kWhite, size: 16),
                  SizedBox(width: 8.w),
                  ReusableText(
                    text: 'Add to Cart',
                    style: appStyle(
                      14,
                      Kolors.kWhite,
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
