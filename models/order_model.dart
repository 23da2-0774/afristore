import 'package:afristore/models/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> items;
  final double total;
  final DateTime date;
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });
}
