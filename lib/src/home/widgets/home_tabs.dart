import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/tab_widget.dart';
import 'package:fashon_shop/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: Kolors.kPrimary,
          borderRadius: BorderRadius.circular(25),
        ),
        labelPadding: EdgeInsets.zero,
        labelColor: Kolors.kWhite,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelStyle: appStyle(11, Kolors.kPrimary, FontWeight.w600),
        unselectedLabelStyle: appStyle(11, Kolors.kGray, FontWeight.normal),
        tabs: List.generate(
          homeTabs.length,
          (index) => Tab(
            child: TabWidget(text: homeTabs[index]),
          ),
        ),
      ),
    );
  }
}
