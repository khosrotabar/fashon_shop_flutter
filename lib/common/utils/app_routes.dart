// ignore_for_file: unused_element

import 'package:fashon_shop/src/auth/views/login_screen.dart';
import 'package:fashon_shop/src/auth/views/registration_screen.dart';
import 'package:fashon_shop/src/categories/views/categories_screen.dart';
import 'package:fashon_shop/src/categories/views/category_page.dart';
import 'package:fashon_shop/src/entrypoint/views/entrypoint.dart';
import 'package:fashon_shop/src/notifications/views/notification_screen.dart';
import 'package:fashon_shop/src/onboarding/views/onboarding_screen.dart';
import 'package:fashon_shop/src/products/views/product_screen.dart';
import 'package:fashon_shop/src/profile/views/orders_screen.dart';
import 'package:fashon_shop/src/profile/views/profile_policy_screen.dart';
import 'package:fashon_shop/src/profile/views/shipping_address_screen.dart';
import 'package:fashon_shop/src/search/views/search_screen.dart';
import 'package:fashon_shop/src/splashscreen/views/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => AppEntryPoint(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    // GoRoute(
    //   path: '/review',
    //   builder: (context, state) => const ReviewsPage(),
    // ),
    GoRoute(
      path: '/policy',
      builder: (context, state) => const ProfilePolicyScreen(),
    ),
    // GoRoute(
    //   path: '/verification',
    //   builder: (context, state) => const VerificationPage(),
    // ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    // GoRoute(
    //   path: '/help',
    //   builder: (context, state) => const HelpCenterPage(),
    // ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryPage(),
    ),

    // GoRoute(
    //   path: '/addaddress',
    //   builder: (context, state) => const AddAddress(),
    // ),

    GoRoute(
      path: '/addresses',
      builder: (context, state) => const ShippingAddressScreen(),
    ),

    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),

    //  GoRoute(
    //   path: '/tracking',
    //   builder: (context, state) => const TrackOrderPage(),
    // ),

    // GoRoute(
    //   path: '/checkout',
    //   builder: (context, state) => const CheckoutPage(),
    // ),

    //   GoRoute(
    //   path: '/successful',
    //   builder: (context, state) => const SuccessfulPayment(),
    // ),

    //   GoRoute(
    //   path: '/failed',
    //   builder: (context, state) => const FailedPayment(),
    // ),

    GoRoute(
      path: '/product/:id',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
  ],
);

GoRouter get router => _router;
