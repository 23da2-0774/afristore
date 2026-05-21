import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistCount = sampleUser.wishlist.length;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.wishlistTitle)),
      body: Center(child: Text('Wishlist Screen - $wishlistCount items')),
    );
  }
}
