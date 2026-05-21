import 'package:afristore/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.confirmationTitle)),
      body: const Center(child: Text('Order Confirmation Screen')),
    );
  }
}
