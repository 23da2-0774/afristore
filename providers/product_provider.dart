import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:afristore/models/product_model.dart';
import 'package:afristore/models/category_model.dart';
import 'package:afristore/core/constants/app_data.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ProductModel> _products = [];
  List<ProductModel> _allProducts = [];
  final List<CategoryModel> _categories = List<CategoryModel>.from(
    allCategories,
  );

  bool _isLoading = false;
  String _error = '';

  List<ProductModel> get products => List.unmodifiable(_products);
  List<CategoryModel> get categories => List.unmodifiable(_categories);
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('products').get();
      _allProducts = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data(), doc.id);
      }).toList();

      _products = List.from(_allProducts);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _allProducts = List.from(allProducts);
      _products = List.from(allProducts);
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterByCategory(String categoryId) {
    if (categoryId == 'all') {
      _products = List.from(_allProducts);
    } else {
      _products = _allProducts
          .where(
            (product) =>
                product.category.toLowerCase() == categoryId.toLowerCase(),
          )
          .toList();
    }
    notifyListeners();
  }
}
