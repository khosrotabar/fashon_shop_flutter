import 'package:fashon_shop/common/services/storage.dart';
import 'package:fashon_shop/common/utils/kcolors.dart';
import 'package:fashon_shop/common/utils/kstrings.dart';
import 'package:fashon_shop/common/widgets/app_style.dart';
import 'package:fashon_shop/common/widgets/back_button.dart';
import 'package:fashon_shop/common/widgets/reusable_text.dart';
import 'package:fashon_shop/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashon_shop/src/auth/views/login_screen.dart';
import 'package:fashon_shop/src/cart/controllers/cart_notifier.dart';
import 'package:fashon_shop/src/cart/hooks/fetch_cart.dart';
import 'package:fashon_shop/src/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final cart = results.cart;
    final refetch = results.refetch;
    final isLoding = results.isLoading;

    if (accessToken == null) {
      return const LoginScreen();
    }

    if (isLoding) {
      return const Scaffold(body: ListShimmer());
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(cart.length, (index) {
          final cartItem = cart[index];
          return CartTile(
            cart: cartItem,
            onUpdate: () {
              context.read<CartNotifier>().updateCart(cartItem.id, refetch);
            },
            onDelete: () {
              context.read<CartNotifier>().deleteCart(cartItem.id, refetch);
            },
          );
        }),
      ),
    );
  }
}
