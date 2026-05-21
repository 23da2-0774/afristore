import 'package:flutter/foundation.dart';

import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = List<OrderModel>.from(sampleOrders);

  List<OrderModel> get orders => List.unmodifiable(_orders);

  void addOrder(OrderModel order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}
