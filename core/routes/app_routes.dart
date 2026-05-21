import 'package:afristore/screens/auth/login_screen.dart';
import 'package:afristore/screens/auth/register_screen.dart';
import 'package:afristore/screens/cart/cart_screen.dart';
import 'package:afristore/screens/checkout/checkout_screen.dart';
import 'package:afristore/screens/order/order_confirmation_screen.dart';
import 'package:afristore/screens/home/home_screen.dart';
import 'package:afristore/screens/order/order_history_screen.dart';
import 'package:afristore/screens/product/product_detail_screen.dart';
import 'package:afristore/screens/product/product_listing_screen.dart';
import 'package:afristore/screens/profile/profile_screen.dart';
import 'package:afristore/screens/splash/splash_screen.dart';
import 'package:afristore/screens/profile/wishlist_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const listing = '/listing';
  static const detail = '/detail';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const confirmation = '/confirmation';
  static const orders = '/orders';
  static const profile = '/profile';
  static const wishlist = '/wishlist';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    home: (_) => const HomeScreen(),
    listing: (_) => const ProductListingScreen(),
    detail: (_) => const ProductDetailScreen(),
    cart: (_) => const CartScreen(),
    checkout: (_) => const CheckoutScreen(),
    confirmation: (_) => const OrderConfirmationScreen(),
    orders: (_) => const OrderHistoryScreen(),
    profile: (_) => const ProfileScreen(),
    wishlist: (_) => const WishlistScreen(),
  };
}
