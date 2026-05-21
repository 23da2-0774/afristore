import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:afristore/models/cart_item_model.dart';
import 'package:afristore/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);
  double get totalPrice =>
      _items.fold(0, (total, item) => total + item.totalPrice);

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // Firestore-ல் இருந்து cart fetch
  Future<void> fetchCart() async {
    if (_uid == null) return;
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cart')
          .get();

      _items.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final product = ProductModel(
          id: doc.id,
          name: data['name'] ?? '',
          brand: data['brand'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          imageUrl: data['imageUrl'] ?? '',
          category: data['category'] ?? '',
          sizes: List<String>.from(data['sizes'] ?? []),
          colors: List<String>.from(data['colors'] ?? []),
          description: data['description'] ?? '',
          rating: (data['rating'] ?? 0).toDouble(),
          tag: data['tag'] ?? '',
          stock: data['stock'] ?? 0,
        );
        final item = CartItemModel(product: product);
        item.quantity = data['quantity'] ?? 1;
        _items.add(item);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Cart fetch error: $e');
    }
  }

  // Cart-ல் product add
  Future<void> addToCart(ProductModel product) async {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItemModel(product: product));
    }
    notifyListeners();
    await _saveToFirestore(product);
  }

  // Cart-ல் இருந்து remove
  Future<void> removeFromCart(ProductModel product) async {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
    if (_uid == null) return;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(product.id)
        .delete();
  }

  // Cart clear
  Future<void> clearCart() async {
    _items.clear();
    notifyListeners();
    if (_uid == null) return;
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  // Firestore-ல் save
  Future<void> _saveToFirestore(ProductModel product) async {
    if (_uid == null) return;
    final qty = _items.firstWhere((i) => i.product.id == product.id).quantity;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(product.id)
        .set({
          'name': product.name,
          'brand': product.brand,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'category': product.category,
          'sizes': product.sizes,
          'colors': product.colors,
          'description': product.description,
          'rating': product.rating,
          'tag': product.tag,
          'stock': product.stock,
          'quantity': qty,
        });
  }
}
