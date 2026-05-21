import 'dart:ui';
import 'package:afristore/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Design Tokens (Stitch: Editorial Heritage) ──────────────────────────────
class _T {
  static const surface = Color(0xFFFCF9F4);
  static const surfaceContainerLow = Color(0xFFF6F3EE);
  static const surfaceContainerHigh = Color(0xFFEBE8E3);
  static const surfaceContainerHighest = Color(0xFFE5E2DD);

  static const primary = Color(0xFF9A4523);
  static const primaryContainer = Color(0xFFE07B54);
  static const onPrimary = Color(0xFFFFFFFF);

  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);

  static const hPad = 20.0;
}

// ─── Typography helpers ───────────────────────────────────────────────────────
TextStyle _serif(double size, FontWeight weight, {Color color = _T.onSurface, FontStyle fontStyle = FontStyle.normal}) =>
    GoogleFonts.cormorantGaramond(fontSize: size, fontWeight: weight, color: color, fontStyle: fontStyle);

TextStyle _sans(double size, FontWeight weight, {Color color = _T.onSurface, double letterSpacing = 0}) =>
    GoogleFonts.plusJakartaSans(fontSize: size, fontWeight: weight, color: color, letterSpacing: letterSpacing);

TextStyle _accent(double size, FontWeight weight, {Color color = _T.onSurface}) =>
    GoogleFonts.nunito(fontSize: size, fontWeight: weight, color: color);

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  int _selectedNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: _T.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                onTap: () {
                    Navigator.pop(context);
                },
                child: const Icon(Icons.menu, color: _T.primaryContainer),
            ),
            const SizedBox(width: 16),
            Text('Afri Store', style: _serif(24, FontWeight.bold, color: _T.onSurface)),
            const Spacer(),
            const Icon(Icons.search, color: _T.primaryContainer),
            const SizedBox(width: 16),
            const Icon(Icons.notifications_outlined, color: _T.primaryContainer),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: _T.hPad, right: _T.hPad, top: 12, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Women's Collection", style: _serif(36, FontWeight.normal, color: _T.onSurface, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 4),
                  Text("124 ITEMS CURATED FOR YOU", style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant, letterSpacing: 1.4)),
                ],
              ),
            ),
          ),

          // Sticky Filter & Chips
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyFilterDelegate(),
          ),

          // 2-Column Product Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(_T.hPad, 16, _T.hPad, 100),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 32,
              childAspectRatio: 0.55,
              children: [
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuD2xpdieObKtDbAWtr4dmPLO73AwRq5rni6MS_up-nIJeD4N6NPnhYE733Bcs4TBmRRW4vdPKQOYn-rL1RGYZhu5K3lrmj-0uLSqz_oQpL3Pa9LaUSe-Kkxcp3-HskqFBlLHVO45gjts-BjYZ6YAVr-XkZmSqwVRxsA1EqVVyrBdtvnN7D9rWRJ7DcC6z91GGkkpDQVb3s6KDornwv_w2MEUyTWKQLfr8UdEIXxEuEfw751yX01f9g_ZwXAyfybrcH_DO3pJKqpoV4b",
                  brand: "Amina Craft",
                  name: "Sun-Kissed Silk Wrap Dress",
                  price: "\$185.00",
                  isFavorite: true,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuD8c16Njzmiv8_AcI_AGnPnYB1mMbEbi8rjNtiat0cdSdbSH5Co-iAajM85d7yXuGVxOEceaWteZj2t_kdxSWT2nGhHezYA5VeQE64XRrtXlMD4bGlwKkCzILFPt2czq3xzT_otk11s5oLW4RCOJsPU5Svn2TgksgreHEpWAIpA1_OLSQClFsIyh2_hSWyE3aT834SEpOiGQYWlB0XbXXyAmiOGKEG1YRGfRYY8Ij5-c3fO1vrEF0YjnQpdwQJik5ZBbDt788HSe_pR",
                  brand: "Kente Modern",
                  name: "Traditional Weaver Maxi",
                  price: "\$220.00",
                  isFavorite: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCMSORBlySVBTyIkeSDXcsT6g9yJDSY_cEXlZjkqf0f4LZG1wYYVhfolLBYchQJiAqo03tslEzstepK5NzjXklM_q1H4EjTs2nJeeho31nGPfhE0k5SaY7_IKX64rslvEzWk4JCRs3NJhLXtnVTceolDqGdFiro-2QIG7AqBvMGE_XxJ5iPoloIlRE4hxiGotkCWt65nixgUuOnA1eyribLnsZxuh6rt--2SYDSfIQVP4Kj1FEdcP8EEDKSaKmrP1AzOD0SrVIf0OAM",
                  brand: "Dakar Studio",
                  name: "Sahara Linen Blouse",
                  price: "\$95.00",
                  isFavorite: false,
                  limited: true,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCRnm0pMcnd34rvTX4WCYQRgSK1hMm699Plf2Erl6VE75ExKHFZFD_B4iOWxZOstEuA7Xl_2gs-TE0VIPyqeJb4V_1oiSvf-vr684vfa6NbGxiWZ4QG934ZLOnfVxGJF0HlJyhw-STfRqigojl1KBh8hs6Xf3xdp7aldkNqyHaCrBqowAt2vBKjSuaeJDS7BlK5kiQ51DP1iIBV8UzRodN7nNuvyo3pyDuOS8nnJdSu-13gHqEOC62lyWj1x_PgU5FZYEqC7JWrJje6",
                  brand: "Mansa Wear",
                  name: "Royal Mudcloth Kaftan",
                  price: "\$275.00",
                  isFavorite: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBkPpwoWkVrw1duYr6tV69ITWC06WgaW3ANh4Stpy7ZYMqDiKLFGSn7_Mu9uzChQWMDcBmaKBj6Pp7ZkIAKj1bjCNUSDNpGZjnEn5eIt4B5275MKK1fvQHAfvEssHTAI8oZKmkFFi7MX6eC6RQsez03yPQuQISw8NgTo_7Myb59I1kkyxOmfchE2R49-nWfbgkmJ3mlLuxFfR7EcdiCK_hP_QxFd9bHAuIcufaYkjQ5huNx2jEz-jNPX0yGT2qt-mhEfScaRN8f8TRk",
                  brand: "Heritage Hub",
                  name: "Sunset Pleated Midi",
                  price: "\$160.00",
                  isFavorite: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
                _ProductCard(
                  imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuB7L2L-LwrUsratP7DzOdaMA03p_fhMVAnBmgunuaugope_MZt755KzwuONNueyrfx6MAaso9edYOdpoN1RfUCp8eBT49jPDs_kPXYSONR-CCoVfFfZfb7WSn5Ryhtc-BBB2zMMKsejP72kL10k9tIToUh2HlgmXYSOckV4uj8MtWuPRg8GwpnfJDUfAm4blJlGjtPkJ9O6o02lXdeWt2azgeyx_kZx-DHIuyZcCtJu5M1FoicUh6CqlR4YiRQskrA-Fh41PFSq_tK8",
                  brand: "Indigo Studio",
                  name: "Earth Layered Tunic",
                  price: "\$130.00",
                  isFavorite: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: _selectedNavIndex,
        onTap: (i) {
          setState(() => _selectedNavIndex = i);
          if (i == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (i == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (i == 3) Navigator.pushNamed(context, AppRoutes.orders);
          if (i == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
    );
  }
}

class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100.0;
  @override
  double get maxExtent => 100.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: _T.surface.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _T.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list, size: 16, color: _T.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Text("Filter", style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("Sort: ", style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant)),
                        Text("Newest", style: _sans(14, FontWeight.bold, color: _T.primary)),
                        const Icon(Icons.expand_more, size: 16, color: _T.primary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 28,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  children: const [
                    _FilterChipItem("Dresses", active: true, closable: true),
                    SizedBox(width: 8),
                    _FilterChipItem("Terracotta", active: true, closable: true),
                    SizedBox(width: 8),
                    _FilterChipItem("Size: M", active: false, closable: false),
                    SizedBox(width: 8),
                    _FilterChipItem("Price: Low to High", active: false, closable: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool active;
  final bool closable;

  const _FilterChipItem(this.label, {required this.active, required this.closable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? _T.primary : _T.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: _sans(12, FontWeight.w600, color: active ? _T.onPrimary : _T.onSurfaceVariant),
          ),
          if (closable) ...[
            const SizedBox(width: 6),
            Icon(Icons.close, size: 14, color: active ? _T.onPrimary : _T.onSurfaceVariant),
          ]
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String name;
  final String price;
  final bool isFavorite;
  final bool limited;
  final VoidCallback onTap;

  const _ProductCard({
    required this.imageUrl,
    required this.brand,
    required this.name,
    required this.price,
    required this.isFavorite,
    this.limited = false,
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
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  Positioned(
                    top: 12, right: 12,
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: _T.surface.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite, size: 20, color: isFavorite ? _T.primary : Colors.grey[400]),
                    ),
                  ),
                  if (limited)
                    Positioned(
                      bottom: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _T.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text("LIMITED", style: _sans(10, FontWeight.bold, color: _T.onPrimary)),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(brand.toUpperCase(), style: _sans(10, FontWeight.w500, color: _T.onSurfaceVariant, letterSpacing: 1.0)),
          const SizedBox(height: 4),
          Text(name, style: _accent(14, FontWeight.bold, color: _T.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(price, style: _sans(14, FontWeight.bold, color: _T.primary)),
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
