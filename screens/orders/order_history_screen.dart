import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCount = sampleOrders.length;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.ordersTitle)),
      body: Center(
        child: Text('Order History Screen - $orderCount past orders'),
      ),
    );
  }
}
