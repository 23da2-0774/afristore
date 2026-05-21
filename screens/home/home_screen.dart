import 'dart:ui';

import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/core/constants/app_strings.dart';
import 'package:afristore/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Design Tokens (Stitch: Editorial Heritage) ──────────────────────────────
class _T {
  // Surfaces
  static const surface = Color(0xFFFCF9F4);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF6F3EE);
  static const surfaceContainerHigh = Color(0xFFEBE8E3);
  static const surfaceContainerHighest = Color(0xFFE5E2DD);

  // Brand
  static const primary = Color(0xFF9A4523);
  static const primaryContainer = Color(0xFFE07B54);
  static const secondary = Color(0xFF795900);
  static const secondaryContainer = Color(0xFFFECE65);
  static const onPrimary = Color(0xFFFFFFFF);

  // Text
  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);
  static const outlineVariant = Color(0xFFDBC1B8);
  static const outline = Color(0xFF88726B);
  static const onPrimaryFixedVariant = Color(0xFF7B2E0D);
  static const primaryFixedDim = Color(0xFFFFB59A);

  // Shadow
  static const shadowColor = Color(0x0F2C1810);
  static const shadowColorMed = Color(0x182C1810);

  // Spacing
  static const hPad = 20.0;
  static const sectionGap = 32.0;
}

// ─── Typography helpers ───────────────────────────────────────────────────────
TextStyle _serif(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
  double? height,
  FontStyle fontStyle = FontStyle.normal,
}) =>
    GoogleFonts.cormorantGaramond(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontStyle: fontStyle,
    );

TextStyle _sans(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
  double letterSpacing = 0,
  double? height,
}) =>
    GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

TextStyle _accent(
  double size,
  FontWeight weight, {
  Color color = _T.onSurface,
  double letterSpacing = 0,
  double? height,
}) =>
    GoogleFonts.nunito(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

// ─── Home Screen ─────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;
  final _searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Men',
    'Women',
    'Kids',
    'Accessories',
    'New In'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ────────────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: _T.surface,
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,
            toolbarHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_T.surface, Color(0x00FCF9F4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.menu, color: _T.onSurface),
                ),
                const SizedBox(width: 12),
                Text(
                  'Afri Store',
                  style: _serif(24, FontWeight.bold, color: _T.onSurface),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart_outlined,
                          color: _T.primaryContainer),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: _T.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.notifications_outlined,
                      color: _T.primaryContainer),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Greeting ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(_T.hPad, 16, _T.hPad, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: _accent(14, FontWeight.w400,
                            color: _T.onSurfaceVariant, letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Hello, Amara 👋',
                        style: _serif(30, FontWeight.bold,
                            color: _T.onSurface, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Search Bar ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: _T.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A2C1810),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ]),
                    child: TextField(
                      controller: _searchController,
                      style: _sans(16, FontWeight.w400, color: _T.onSurface),
                      decoration: InputDecoration(
                        hintText: "Search fashion...",
                        hintStyle: _sans(16, FontWeight.w400,
                            color: _T.onSurfaceVariant.withOpacity(0.6)),
                        prefixIcon:
                            const Icon(Icons.search, color: _T.outline),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ── Hero Banner Carousel ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: _HeroBanner(
                    onShopNow: () =>
                        Navigator.pushNamed(context, AppRoutes.listing),
                  ),
                ),

                const SizedBox(height: _T.sectionGap),

                // ── Category Chips ──────────────────────────────────────────
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final isActive = _selectedCategoryIndex == i;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategoryIndex = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            color: isActive
                                ? _T.primary
                                : _T.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            categories[i],
                            style: _sans(
                              14,
                              isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive
                                  ? _T.onPrimary
                                  : _T.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: _T.sectionGap),

                // ── Featured Products ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text("Featured Products",
                            style: _serif(24, FontWeight.bold,
                                color: _T.onSurface)),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.listing),
                        child: Text(
                          "VIEW ALL",
                          style: _sans(12, FontWeight.bold,
                              color: _T.primary, letterSpacing: 2.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.55,
                    children: [
                      _FeaturedProductCard(
                        imageUrl:
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuBPcllzmY0sWci5VzZxd3DX1mr0nxtstM3Me5hEy3Q3yhN0bfhzJlJ_6XIkiACUWZoFyJ5DSRhY2-iRBdz-wKhmgcRxN6uTcA472EvwqX_xG2MrBoK6-fiVXLAm00R0_eM5UIUoNEJXIn2CilCw7HerBnj7FFTkatWwEkXPphN6xFY7BwB1CZRLhFlwz6Or9Of_biHAc0dRVP1IBZ5sF3L_X5TrUhAnN5bbDYTv6B9vodM-rDSx8QmlGAoP-myXIroFdrzi2jQKvVGr",
                        tag: "Lagos Luxe",
                        title: "Indigo Geometric Wrap",
                        price: "₦42,500",
                        activeFavorite: false,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.detail),
                      ),
                      _FeaturedProductCard(
                        imageUrl:
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuDT0RsMECoFdCOmYwLKnsVBOETuC3qQ4fGItoUZdoZrO1YCunO2FX3vjiEIKxn20u1cHL0laIWURPTYis2_5yuvLZ377ZCbEsWHOd62SJxZlCoR78j4J44BpaOP4GBzWtIkE8hqu8NbORKzDFR8WzGSjEsV1DUFN_nMRORURcRfX9bXYiKvboZskyGiDwsJZTJVx-KggsYQ1J88nwHZAzSVHKPN1HkVojYeSU4fEWWRAzuoTirHYtnTeEfg1oEgJxg-6Nh18pcAMx6L",
                        tag: "Savannah Craft",
                        title: "Nomad Raffia Satchel",
                        price: "₦28,000",
                        activeFavorite: false,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.detail),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: _T.sectionGap),

                // ── New Arrivals ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text("New Arrivals",
                            style: _serif(24, FontWeight.bold,
                                color: _T.onSurface)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 340,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                    children: [
                      _NewArrivalCard(
                        imageUrl:
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuAmYT1VsrRQOj2sgzl-sIGMff34opuPS2d6FKPwUxu1srAXarKvHVGbuRu7DrjFwWQ7PVc_hpKkd-ibHnaZZRaHSmY6lq_KmVzZ9QW3RnSuUBlbml1DsGtb16ixBtkUqwz1Ys7ZOoYFJPpI2e8tY3E0mzm37BCm2SggI-s7fMDWMeEqCSKCXeMe6IJ8I6O792BmB4qUZXhPlP6LRwVurUhsGctIItR1_AEERAKbNA8D9XISP0RNbQDvLTvwdbeuKWr4vKNbo8z0ag4Y",
                        tag: "Accessories",
                        title: "Sun-God Gold Earrings",
                        price: "₦15,000",
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.detail),
                      ),
                      const SizedBox(width: 24),
                      _NewArrivalCard(
                        imageUrl:
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuCku1p4FEilUqJrI4iFBS8eKQdzDa94ppW8__ichQkMBf5j407uB72u0N693faMoITbeIjMw2bQxURo-H_-mTq0r5KYaFIUL0iohGE4xvRqWfEaZ4FzLRO0LF9G5JPB452zcm1kF6L1Og5Fa9pC5trw04G6KOqiRDsN3CqMMfxob5PXR8YtoHgusSa2pSVMx0N5dDCAB6uwewiYqjAGRsu2EZskbpsSE0xQstgx_UPXivAacvKva9gXHGugJg44DeTpvC5qgS-q7To3",
                        tag: "Textiles",
                        title: "Ochre Earth Mudcloth",
                        price: "₦85,000",
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.detail),
                      ),
                    ],
                  ),
                ),

                // Bottom padding for floating nav
                const SizedBox(height: 110),
              ],
            ),
          ),
        ],
      ),
      // ── Floating Bottom Nav ──────────────────────────────────────────────
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: _selectedNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() => _selectedNavIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.listing);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.cart);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.orders);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }
}

// ─── Hero Banner Widget ───────────────────────────────────────────────────────
class _HeroBanner extends StatelessWidget {
  final VoidCallback onShopNow;

  const _HeroBanner({required this.onShopNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCTzLJt7AmVtWsHthaqgMSxK3EjGPe8Q5DbckIvCNMcqo8-GtD7HZIKWC7GXLPP-3LjGhK-0O8d11x4UjPOlzfNE5_m3_lN79TjY7MxOaADNJUj2Jur2wnnCFd17JdnNzLFN3h13FeWr6pp8ozxvH3qsntW7WrtV9Cf1TcDwlCFHbffYeGmSCGYA3p9b3kxWwHbFoSOdvYpfQTXXfg9khGRdeYWuVIrvhXzCXAJl9xUjSgBil5oVQUNMBhA_BRBaAsGoVpeGJ1gsCkz",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xCC1C1C19),
                  Color(0x331C1C19),
                  Colors.transparent
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NEW SEASON",
                  style: _sans(12, FontWeight.bold,
                      color: _T.onPrimaryFixedVariant, letterSpacing: 2.4),
                ),
                const SizedBox(height: 8),
                Text(
                  "The Heritage\nCollection",
                  style: _serif(36, FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      height: 1.1),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: onShopNow,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_T.primary, _T.primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Shop Now",
                            style: _sans(14, FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Carousel Indicators
          Positioned(
            right: 24,
            top: 210,
            child: Column(
              children: [
                Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                Container(
                    width: 4,
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                Container(
                    width: 4,
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FeaturedProductCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;
  final String price;
  final bool activeFavorite;
  final VoidCallback onTap;

  const _FeaturedProductCard({
    required this.imageUrl,
    required this.tag,
    required this.title,
    required this.price,
    required this.activeFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _T.surfaceContainerLow,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: activeFavorite
                            ? Colors.white.withOpacity(0.8)
                            : Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: activeFavorite
                            ? _T.primary
                            : _T.onSurfaceVariant,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _T.onSurface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(tag,
              style: _sans(10, FontWeight.bold,
                  color: _T.onSurfaceVariant.withOpacity(0.6),
                  letterSpacing: 1.0)),
          const SizedBox(height: 4),
          Text(title,
              style: _accent(16, FontWeight.bold, color: _T.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(price,
              style: _sans(16, FontWeight.bold, color: _T.primary)),
        ],
      ),
    );
  }
}

class _NewArrivalCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;
  final String price;
  final VoidCallback onTap;

  const _NewArrivalCard({
    required this.imageUrl,
    required this.tag,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xE61C1C19), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tag.toUpperCase(),
                      style: _sans(10, FontWeight.bold,
                          color: _T.primaryFixedDim, letterSpacing: 1.0)),
                  const SizedBox(height: 4),
                  Text(title,
                      style: _serif(20, FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price,
                          style: _sans(16, FontWeight.bold,
                              color: Colors.white)),
                      const Icon(Icons.arrow_outward,
                          color: Colors.white54, size: 20),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ─── Floating Bottom Nav ──────────────────────────────────────────────────────
class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav(
      {required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(
      icon: Icons.home,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.search,
      label: 'Explore',
    ),
    _NavItem(
      icon: Icons.shopping_cart,
      label: 'Cart',
    ),
    _NavItem(
      icon: Icons.inventory_2,
      label: 'Orders',
    ),
    _NavItem(
      icon: Icons.person,
      label: 'Profile',
    ),
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
              border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.5))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (i) {
                final item = _items[i];
                final active = i == currentIndex;
                final color = active ? _T.primary : Colors.grey[400]!;

                return GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon, color: color, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: _accent(10, FontWeight.normal,
                            color: color, letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 4,
                        height: 4,
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

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
