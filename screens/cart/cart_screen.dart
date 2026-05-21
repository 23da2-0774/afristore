import 'dart:ui';
import 'package:afristore/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Design Tokens (Stitch: Editorial Heritage) ──────────────────────────────
class _T {
  static const surface = Color(0xFFFCF9F4);
  static const surfaceContainerLow = Color(0xFFF6F3EE);
  static const surfaceContainerHighest = Color(0xFFE5E2DD);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);

  static const primary = Color(0xFF9A4523);
  static const primaryContainer = Color(0xFFE07B54);
  static const onPrimary = Color(0xFFFFFFFF);
  static const onPrimaryContainer = Color(0xFF581A00);

  static const secondary = Color(0xFF795900);
  static const error = Color(0xFFBA1A1A);

  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);

  static const outlineVariant = Color(0xFFDBC1B8);
  static const hPad = 20.0;
}

// ─── Typography helpers ───────────────────────────────────────────────────────
TextStyle _serif(double size, FontWeight weight, {Color color = _T.onSurface, FontStyle fontStyle = FontStyle.normal}) =>
    GoogleFonts.cormorantGaramond(fontSize: size, fontWeight: weight, color: color, fontStyle: fontStyle);

TextStyle _sans(double size, FontWeight weight, {Color color = _T.onSurface, double letterSpacing = 0}) =>
    GoogleFonts.plusJakartaSans(fontSize: size, fontWeight: weight, color: color, letterSpacing: letterSpacing);

TextStyle _accent(double size, FontWeight weight, {Color color = _T.onSurface}) =>
    GoogleFonts.nunito(fontSize: size, fontWeight: weight, color: color);

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedNavIndex = 2; // Active Tab: Shopping Cart

  // Mock data for cart items
  final List<Map<String, dynamic>> _cartItems = [
    {
      'title': 'Woven Artisan Tote',
      'subtitle': 'Size: Large • Color: Terra',
      'price': '\$120.00',
      'qty': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCPO8rXSiTaYtgXSkrvsotEn-4SJooZyQkYiUmeWiD3BqRK1Dmr9R-45pLGkMEonqnjnfSAg7k5jl04GfaUM_UcUP7NpigsgDiP9WSFedYlqkOVwwcna6BylGsX-rnvqxGjpg9Wy_pmwMfXfb9LTkAKi327VwRh1GqyzfIwau0XVb_CwODtniELbTAS_H5gLL8LV9H5Z1zTIekA7J-_1w967Hnm0YgESO-ulzbhnzwo7sB0Y9MvTp-AvflC2mbVBbppIMlB7YYmYvI4',
    },
    {
      'title': 'Identity Brass Studs',
      'subtitle': 'Size: OS • Color: Gold',
      'price': '\$45.00',
      'qty': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDpbf3vyXDu5SCM-pR1IJcYFz7U0oVx_3GsJQBy3wmykvHA17oe2aOz4KY_ebI3E1H-oNEwsVbRbm0XiDeJfb9Mq5GWrfU9rjdH7yqw4ybMmWsAeiuxH8EqRrEKh0p_60vHbVxH4YeQ0Sn1kW_yhPbkSe04pjItXd6dS-3_xVKYmWJhJGZu2Mm4NuhCow_-qAR8CFf-_K0fUdDFrDarowPKI-KADhMPvtahP63iBVeIJRuaCUmpyZGZQ-lVzAGWYA3u5bM1ZvvtWHeJ',
    },
    {
      'title': 'Indigo Mudcloth Wrap',
      'subtitle': 'Size: 2m • Color: Indigo',
      'price': '\$85.00',
      'qty': 1,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAZNb5R4jP80PSvaQlw5GbN19WxBEU20stvUrh168tKK5yPhGPwmTC4g73ODCRw0hPggy9Ipbssm83MJhrGvqqFYZ872JAbA00L_-lIzzVS78ZzE5ueYCh3JUXXeFNCisHhUmNU1-2KriRlNJpYvi8aEASO_GIm0mm_YPF8pf9Qyr2amVxOBwXVaFkMs23Ewjrq4W_ePLfLBLsFEeFBLlsHLfzAqOZU6MFg1cbdzjSyPYY3hdc_JndFpAUUwX-IUh5BJFYMs9dzxwKk',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: _T.surface,
        elevation: 0,
        automaticallyImplyLeading: false, // HTML has menu
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_T.surface, Color(0x00FCF9F4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.menu, color: _T.onSurface),
            ),
            const SizedBox(width: 16),
            Text('Afri Store', style: _serif(24, FontWeight.bold, color: _T.onSurface)),
            const Spacer(),
            const Icon(Icons.notifications_outlined, color: _T.onSurface),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(_T.hPad, 16, _T.hPad, 120),
        physics: const BouncingScrollPhysics(),
        children: [
          // Header Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text("My Cart", style: _serif(36, FontWeight.w600, color: _T.onSurface)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: _T.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text("3 items", style: _sans(14, FontWeight.bold, color: _T.onPrimaryContainer)),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Cart Items List
          ..._cartItems.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final isFirst = idx == 0;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: _T.surface, // Based on HTML bg-surface
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            item['image'],
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 96,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Text(item['title'], style: _sans(16, FontWeight.bold, color: _T.onSurface), maxLines: 1)),
                                        const Icon(Icons.delete_outline, color: _T.error, size: 20),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(item['subtitle'], style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: _T.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.remove, size: 16, color: _T.onSurfaceVariant),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Text("${item['qty']}", style: _sans(14, FontWeight.bold, color: _T.onSurface)),
                                          ),
                                          const Icon(Icons.add, size: 16, color: _T.onSurfaceVariant),
                                        ],
                                      ),
                                    ),
                                    Text(item['price'], style: _sans(16, FontWeight.bold, color: _T.primary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Swipe Indicator on first item
                if (isFirst)
                  Positioned(
                    right: -8,
                    top: 24,
                    child: Opacity(
                      opacity: 0.3,
                      child: Column(
                        children: [
                          const Icon(Icons.chevron_left, size: 20),
                          Text("SWIPE", style: _sans(8, FontWeight.bold).copyWith(letterSpacing: 2)),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 16),

          // Promo Code
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _T.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text("Promo code", style: _sans(14, FontWeight.normal, color: _T.onSurfaceVariant.withOpacity(0.6))),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: _T.onSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text("Apply", style: _sans(14, FontWeight.bold, color: _T.surface)),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Order Summary Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _T.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _T.outlineVariant.withOpacity(0.1)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F2C1810),
                  blurRadius: 32,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                _SummaryRow("Subtotal", "\$250.00"),
                const SizedBox(height: 12),
                _SummaryRow("Delivery fee", "\$12.00"),
                const SizedBox(height: 12),
                _SummaryRow("Discount", "-\$25.00", isDiscount: true),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: _T.surfaceContainerHighest, height: 1, thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: _serif(20, FontWeight.bold, fontStyle: FontStyle.italic)),
                    Text("\$237.00", style: _sans(24, FontWeight.bold, color: _T.onSurface)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Action Button
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.checkout);
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [_T.primary, _T.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: _T.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                "Proceed to Checkout",
                style: _sans(18, FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: _selectedNavIndex,
        onTap: (i) {
          setState(() => _selectedNavIndex = i);
          if (i == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.listing);
          if (i == 3) Navigator.pushNamed(context, AppRoutes.orders);
          if (i == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _SummaryRow(this.label, this.value, {this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant)),
        Text(value, style: _sans(14, FontWeight.bold, color: isDiscount ? _T.secondary : _T.onSurface)),
      ],
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    Icons.home,
    Icons.search,
    Icons.shopping_cart,
    Icons.inventory_2,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xCCFCF9F4),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.5))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (i) {
                final icon = _items[i];
                final active = i == currentIndex;
                final color = active ? _T.primary : Colors.grey[400]!;
                
                return GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: color, size: 24),
                      const SizedBox(height: 8),
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active ? _T.primary : Colors.transparent,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
