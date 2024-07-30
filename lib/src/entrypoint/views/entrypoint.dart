import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/src/cart/views/cart_screen.dart';
import 'package:fashon_shop/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashon_shop/src/home/views/home_screen.dart';
import 'package:fashon_shop/src/profile/views/profile_screen.dart';
import 'package:fashon_shop/src/whishlist/views/whishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = [
    const HomeScreen(),
    const WhislistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TabIndexNotifier>(context);

    return Scaffold(
      body: Stack(
        children: [
          pageList[controller.index],
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Kolors.kOffWhite),
              child: BottomNavigationBar(
                selectedFontSize: 12,
                elevation: 0,
                currentIndex: controller.index,
                backgroundColor: Kolors.kOffWhite,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: Kolors.kPrimary,
                unselectedItemColor: Kolors.kGray,
                selectedLabelStyle: appStyle(9, Kolors.kPrimary, FontWeight.w500),
                onTap: (index) {
                  controller.setIndex = index;
                },
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(AntDesign.home, size: 24),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(controller.index == 1 ? Ionicons.heart : Ionicons.heart_outline, size: 24),
                    label: "Whishlist",
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                        label: const Text('9'),
                        child: Icon(controller.index == 2 ? MaterialCommunityIcons.shopping : MaterialCommunityIcons.shopping_outline, size: 24)),
                    label: "Cart",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(EvilIcons.user, size: 34),
                    label: "Profile",
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
