import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/custom_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Kolors.kWhite,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Image.asset(
              R.ASSETS_IMAGES_GETSTARTED_PNG,
            ),
            SizedBox(height: 30.h),
            Text(
              AppText.kWelcomeHeader,
              textAlign: TextAlign.center,
              style: appStyle(
                24,
                Kolors.kPrimary,
                FontWeight.bold,
              ),
            ),
            SizedBox(
              width: ScreenUtil().screenWidth - 100,
              child: Text(
                AppText.kWelcomeMessage,
                textAlign: TextAlign.center,
                style: appStyle(
                  11,
                  Kolors.kGray,
                  FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            GradientBtn(
              text: AppText.kGetStarted,
              btnHieght: 35,
              radius: 20,
              btnWidth: ScreenUtil().screenWidth - 100,
              onTap: () {
                // Storage().setBool('firstOpen', true);

                context.go('/home');
              },
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                  text: 'Already have an account?',
                  style: appStyle(12, Kolors.kDark, FontWeight.normal),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: Text(
                    'Sign In',
                    style: appStyle(12, Colors.blue, FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}