import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:fashon_shop/src/onboarding/widgets/onboarding_page_one.dart';
import 'package:fashon_shop/src/onboarding/widgets/onboarding_page_two.dart';
import 'package:fashon_shop/src/onboarding/widgets/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: context.read<OnboardingNotifier>().selectedPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardingNotifier>(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              controller.setSelectedPage = page;
            },
            children: const [
              OnboardingPageOne(),
              OnboardingPageTwo(),
              WelcomeScreen(),
            ],
          ),
          controller.selectedPage == 2
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 50,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: ScreenUtil().screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.selectedPage == 0
                            ? const SizedBox(width: 30)
                            : GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    controller.selectedPage - 1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Icon(AntDesign.leftcircleo, color: Kolors.kPrimary, size: 30),
                              ),
                        SizedBox(
                          width: ScreenUtil().screenWidth * 0.7,
                          height: 50.h,
                          child: PageViewDotIndicator(
                            count: 3,
                            currentItem: controller.selectedPage,
                            unselectedColor: Colors.black26,
                            selectedColor: Kolors.kPrimary,
                            duration: const Duration(milliseconds: 200),
                            onItemClicked: (index) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              controller.selectedPage + 1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Icon(AntDesign.rightcircleo, color: Kolors.kPrimary, size: 30),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
