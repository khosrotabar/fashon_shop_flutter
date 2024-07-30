import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/custom_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fashon_shop/const/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
              autoPlayInterval: 5000,
              isLoop: true,
              indicatorColor: Kolors.kPrimaryLight,
              onPageChanged: (page) {
                print(page);
              },
              children: List.generate(
                images.length,
                (index) => CachedNetworkImage(
                  placeholder: placeholder,
                  errorWidget: errorWidget,
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            child: SizedBox(
              height: ScreenUtil().screenHeight * 0.16,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: AppText.kCollection,
                      style: appStyle(
                        20,
                        Kolors.kDark,
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Discount 50% off \nthe fisrt transaction',
                      style: appStyle(
                        14,
                        Kolors.kDark.withOpacity(0.6),
                        FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GradientBtn(text: 'Shop Now', btnWidth: 100.w)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
