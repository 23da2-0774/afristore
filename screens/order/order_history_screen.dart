import 'dart:ui';
import 'package:afristore/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _T {
  static const surface = Color(0xFFFCF9F4);
  static const surfaceContainerLow = Color(0xFFF6F3EE);
  static const surfaceContainerHighest = Color(0xFFE5E2DD);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const primary = Color(0xFF9A4523);
  static const primaryContainer = Color(0xFFE07B54);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF795900);
  static const secondaryFixed = Color(0xFFFFDF9F);
  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);
  static const outlineVariant = Color(0xFFDBC1B8);
  static const hPad = 20.0;
}

TextStyle _serif(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
  FontStyle fontStyle = FontStyle.normal,
}) => GoogleFonts.cormorantGaramond(
  fontSize: size,
  fontWeight: weight,
  color: color,
  fontStyle: fontStyle,
);

TextStyle _sans(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
  double letterSpacing = 0,
}) => GoogleFonts.plusJakartaSans(
  fontSize: size,
  fontWeight: weight,
  color: color,
  letterSpacing: letterSpacing,
);

TextStyle _accent(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
}) => GoogleFonts.nunito(fontSize: size, fontWeight: weight, color: color);

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = [
    "All",
    "Placed",
    "Shipped",
    "Delivered",
    "Cancelled",
  ];

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      appBar: AppBar(
        backgroundColor: _T.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.menu, color: _T.primary),
            ),
            const SizedBox(width: 16),
            Text(
              'Afri Store',
              style: _serif(24, FontWeight.bold, color: _T.onSurface),
            ),
            const Spacer(),
            const Icon(Icons.notifications_outlined, color: _T.primary),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  "My Orders",
                  style: _serif(
                    36,
                    FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _T.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Filter tabs
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _T.primary
                          : _T.surfaceContainerHighest.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _filters[index],
                      style: _sans(
                        14,
                        FontWeight.w600,
                        color: isSelected ? _T.onPrimary : _T.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Orders from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('userId', isEqualTo: _uid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No orders yet",
                          style: _serif(
                            24,
                            FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final orders = snapshot.data!.docs;
                final filtered = _selectedFilter == 0
                    ? orders
                    : orders.where((o) {
                        final status = (o.data() as Map)['status'] ?? '';
                        return status.toLowerCase() ==
                            _filters[_selectedFilter].toLowerCase();
                      }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final data = filtered[index].data() as Map<String, dynamic>;
                    return _OrderCard(order: data);
                  },
                );
              },
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: 3,
        onTap: (i) {
          if (i == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.listing);
          if (i == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (i == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  const _OrderCard({required this.order});

  Color _getStatusColorBg(String s) {
    if (s == 'delivered') return Colors.green[100]!;
    if (s == 'placed') return const Color(0xFFFFDF9F);
    if (s == 'shipped') return Colors.blue[100]!;
    if (s == 'cancelled') return Colors.red[100]!;
    return Colors.grey[100]!;
  }

  Color _getStatusColorText(String s) {
    if (s == 'delivered') return Colors.green[700]!;
    if (s == 'placed') return const Color(0xFF795900);
    if (s == 'shipped') return Colors.blue[700]!;
    if (s == 'cancelled') return Colors.red[700]!;
    return Colors.grey[700]!;
  }

  @override
  Widget build(BuildContext context) {
    final status = order['status'] ?? 'placed';
    final name = order['name'] ?? 'Customer';
    final address = order['address'] ?? '';
    final timestamp = order['timestamp'] as Timestamp?;
    final date = timestamp != null
        ? '${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}'
        : 'Recent';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _T.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F2C1810),
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: _sans(16, FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColorBg(status),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: _sans(
                    10,
                    FontWeight.bold,
                    color: _getStatusColorText(status),
                  ).copyWith(letterSpacing: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: _sans(12, FontWeight.normal, color: _T.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(date, style: _accent(12, FontWeight.normal, color: Colors.grey)),
          const SizedBox(height: 12),
          const Divider(color: _T.surfaceContainerHighest, height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment: ${order['paymentMethod'] ?? 'N/A'}",
                style: _sans(12, FontWeight.w500, color: _T.onSurfaceVariant),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    {'i': Icons.home, 'l': 'Home'},
    {'i': Icons.search, 'l': 'Explore'},
    {'i': Icons.shopping_cart, 'l': 'Cart'},
    {'i': Icons.inventory_2, 'l': 'Orders'},
    {'i': Icons.person, 'l': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xCCFCF9F4),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final icon = _items[i]['i'] as IconData;
              final label = _items[i]['l'] as String;
              final active = i == currentIndex;
              final color = active ? _T.primary : Colors.grey[400]!;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: _accent(10, FontWeight.normal, color: color),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
