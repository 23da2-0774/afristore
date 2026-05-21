import 'package:afristore/models/category_model.dart';
import 'package:afristore/models/order_model.dart';
import 'package:afristore/models/product_model.dart';
import 'package:afristore/models/user_model.dart';

class AppAssets {
  // General
  static const String logo = 'assets/images/general/logo.png';
  static const String splashBg = 'assets/images/general/splash_bg.png';
  static const String emptyCart = 'assets/images/general/empty_cart.png';
  static const String emptyWishlist = 'assets/images/general/empty_wishlist.png';
  static const String emptyOrders = 'assets/images/general/empty_orders.png';
  static const String avatarPlaceholder = 'assets/images/general/avatar_placeholder.png';

  // Banners
  static const String banner1 = 'assets/images/banners/banner_1.png';
  static const String banner2 = 'assets/images/banners/banner_2.png';
  static const String banner3 = 'assets/images/banners/banner_3.png';

  // Categories
  static const String catMen = 'assets/images/categories/cat_men.png';
  static const String catWomen = 'assets/images/categories/cat_women.png';
  static const String catKids = 'assets/images/categories/cat_kids.png';
  static const String catAccessories = 'assets/images/categories/cat_accessories.png';

  // Products - Men
  static const String mens1 = 'assets/images/products/mens/mens_1.png';
  static const String mens2 = 'assets/images/products/mens/mens_2.png';
  static const String mens3 = 'assets/images/products/mens/mens_3.png';

  // Products - Women
  static const String womens1 = 'assets/images/products/womens/womens_1.png';
  static const String womens2 = 'assets/images/products/womens/womens_2.png';
  static const String womens3 = 'assets/images/products/womens/womens_3.png';

  // Products - Kids
  static const String kids1 = 'assets/images/products/kids/kids_1.png';
  static const String kids2 = 'assets/images/products/kids/kids_2.png';
  static const String kids3 = 'assets/images/products/kids/kids_3.png';

  // Products - Accessories
  static const String acc1 = 'assets/images/products/accessories/acc_1.png';
  static const String acc2 = 'assets/images/products/accessories/acc_2.png';
  static const String acc3 = 'assets/images/products/accessories/acc_3.png';
}

final List<String> banners = [
  AppAssets.banner1,
  AppAssets.banner2,
  AppAssets.banner3,
];

final List<ProductModel> allProducts = [
  ProductModel(
    id: 'p1',
    name: 'Sahara Wrap Dress',
    brand: 'Nomad Vogue',
    price: 69.99,
    imageUrl: AppAssets.womens1,
    category: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['#E07B54', '#D4A843', '#FFFFFF'],
    description:
        'Flowy wrap dress inspired by African silhouettes and warm terracotta tones.',
    rating: 4.7,
  ),
  ProductModel(
    id: 'p2',
    name: 'Kente Street Jacket',
    brand: 'Afri Luxe',
    price: 129.99,
    imageUrl: AppAssets.mens1,
    category: 'Men',
    sizes: ['M', 'L', 'XL'],
    colors: ['#2C1810', '#8B8B8B', '#FAF7F2'],
    description:
        'Bold streetwear jacket with a modern Kente-inspired pattern and luxe tailoring.',
    rating: 4.8,
  ),
  ProductModel(
    id: 'p3',
    name: 'Sunrise Beaded Hoop',
    brand: 'AdornCo',
    price: 24.99,
    imageUrl: AppAssets.acc1,
    category: 'Accessories',
    sizes: ['One Size'],
    colors: ['#D4A843', '#FFFFFF'],
    description:
        'Handmade beaded hoops in warm gold tones, perfect for statement dressing.',
    rating: 4.5,
  ),
  ProductModel(
    id: 'p4',
    name: 'Savanna Linen Set',
    brand: 'EarthThreads',
    price: 89.99,
    imageUrl: AppAssets.womens2,
    category: 'Women',
    sizes: ['S', 'M', 'L'],
    colors: ['#FAF7F2', '#E07B54'],
    description:
        'Relaxed linen top and trousers in earthy tones for effortless elevated comfort.',
    rating: 4.6,
  ),
  ProductModel(
    id: 'p5',
    name: 'Mini Safari Tee',
    brand: 'Cocoa Kids',
    price: 29.99,
    imageUrl: AppAssets.kids1,
    category: 'Kids',
    sizes: ['2Y', '4Y', '6Y', '8Y'],
    colors: ['#D4A843', '#E07B54', '#2C1810'],
    description:
        'Soft cotton tee with playful safari graphics for adventurous little ones.',
    rating: 4.4,
  ),
  ProductModel(
    id: 'p6',
    name: 'Nile Day Bag',
    brand: 'Maji Bags',
    price: 54.99,
    imageUrl: AppAssets.acc2,
    category: 'Accessories',
    sizes: ['One Size'],
    colors: ['#2C1810', '#FFFFFF'],
    description:
        'Structured daily tote with leather details and an elegant neutral palette.',
    rating: 4.9,
  ),
  ProductModel(
    id: 'p7',
    name: 'Dune Knit Sweater',
    brand: 'Coastline Wear',
    price: 79.99,
    imageUrl: AppAssets.womens3,
    category: 'Women',
    sizes: ['S', 'M', 'L'],
    colors: ['#E07B54', '#D4A843'],
    description:
        'Cozy knit sweater in terracotta and gold shades for fall-ready styling.',
    rating: 4.6,
  ),
  ProductModel(
    id: 'p8',
    name: 'Savanna Cargo Shorts',
    brand: 'TrailNomad',
    price: 49.99,
    imageUrl: AppAssets.mens2,
    category: 'Men',
    sizes: ['M', 'L', 'XL'],
    colors: ['#FAF7F2', '#2C1810'],
    description:
        'Utility-inspired cargo shorts with easy styling for summer city and safari looks.',
    rating: 4.3,
  ),
  ProductModel(
    id: 'p9',
    name: 'Golden Spiral Sandals',
    brand: 'SoleStory',
    price: 39.99,
    imageUrl: AppAssets.womens1,
    category: 'Women',
    sizes: ['6', '7', '8', '9'],
    colors: ['#D4A843', '#FFFFFF'],
    description:
        'Elegant sandals with metallic gold straps and a comfortable footbed.',
    rating: 4.7,
  ),
  ProductModel(
    id: 'p10',
    name: 'Indigo Kids Hoodie',
    brand: 'Bright Roots',
    price: 34.99,
    imageUrl: AppAssets.kids2,
    category: 'Kids',
    sizes: ['2Y', '4Y', '6Y', '8Y'],
    colors: ['#2C1810', '#FFFFFF'],
    description:
        'Soft hoodie with playful indigo details and a comfortable relaxed fit.',
    rating: 4.5,
  ),
];

final List<CategoryModel> allCategories = [
  CategoryModel(id: 'all', name: 'All', image: ''),
  CategoryModel(id: 'men', name: 'Men', image: AppAssets.catMen),
  CategoryModel(id: 'women', name: 'Women', image: AppAssets.catWomen),
  CategoryModel(id: 'kids', name: 'Kids', image: AppAssets.catKids),
  CategoryModel(id: 'accessories', name: 'Accessories', image: AppAssets.catAccessories),
  CategoryModel(id: 'new_in', name: 'New In', image: ''),
];

final List<OrderModel> sampleOrders = [
  OrderModel(
    id: 'o1',
    items: [allProducts[0], allProducts[2]],
    total: 94.98,
    date: DateTime.now().subtract(const Duration(days: 9)),
    status: 'Delivered',
  ),
  OrderModel(
    id: 'o2',
    items: [allProducts[1], allProducts[5], allProducts[8]],
    total: 224.97,
    date: DateTime.now().subtract(const Duration(days: 21)),
    status: 'Shipped',
  ),
  OrderModel(
    id: 'o3',
    items: [allProducts[3], allProducts[7]],
    total: 139.98,
    date: DateTime.now().subtract(const Duration(days: 30)),
    status: 'Delivered',
  ),
];

final UserModel sampleUser = UserModel(
  id: 'u1',
  name: 'Ama Agyemang',
  email: 'ama@afristore.com',
  avatarUrl: AppAssets.avatarPlaceholder,
  wishlist: [allProducts[0], allProducts[4], allProducts[8]],
);
