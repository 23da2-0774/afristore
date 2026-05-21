class ProductModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final String description;
  final double rating;
  final String tag;
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.description,
    required this.rating,
    this.tag = '',
    this.stock = 0,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? data['imageurl'] ?? '',
      category: data['category'] ?? '',
      sizes: List<String>.from(data['sizes'] ?? []),
      colors: List<String>.from(data['colors'] ?? []),
      description: data['description'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      tag: data['tag'] ?? '',
      stock: data['stock'] ?? 0,
    );
  }
}
