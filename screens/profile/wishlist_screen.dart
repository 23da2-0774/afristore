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

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'category': 'Accessories',
        'name': 'Artisanal Raffia Tote',
        'price': '₦45,000',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuClnhkv8HCJHD0rgdq1E3tcHpWl3JuoFzrJ6RuWR-AXE4Xyled5zdIMBzSPL85hmi6yfd2xn5ZiKGB2OZJQJ8sTXl8Uln6s5ygENM64ty6FY3oEMwayvvFjUKFrs2lFtUGyX9ZDPd6HrUcQvOSfdIqMoms3iyUg5ajsuJ73D9N3cAlIRZmpk07JGNOCcDoSmzNdjq_CEyu-Iksj6LW03urjGIpXmW1yga1CQZQrfCZaHiyNRegaqCarcGlBB5_AO_yxN35T2u1j7oCQ',
      },
      {
        'category': 'Apparel',
        'name': 'Indigo Adire Tunic',
        'price': '₦32,500',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC5id0d4uqWjp_wK0BMLU-QjTJ8AAY7h8Hpo1gW3mGbfin77267uyyhAiZIL4k4L97XOIPFC_ZjmKN5198dGXXmsYhNDxLxJwDzjU0EjPpwv907PYD39Mnee0ldaKVua5Pcx6wVa4MaGQVmOb4AsGDkVnRB0WMO9rgNA9ac_GIc52WBImklOfqT5w0vWmSlaG3CoXuswT6SScpdDaQKilo2sUrzQ_u-1VocVdQbxdIr5aTvghSOfRZRSTilegtMjWN0AZNFXkePtMK6',
      },
      {
        'category': 'Jewelry',
        'name': 'Royal Beaded Collar',
        'price': '₦18,000',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDhl01k_o7vsXZIITZ0Hj1dKhHa0kQurJWeEilJGynyCBF5QcfQFsUCfmHz3TQs9Bc4J6Ndk0dPl6mFDRayK8nBSaYM5LQciy3pV2q_BFOng6lBwdLJYXw6DQ8KCgmn4124yyf51b-jjG3S2Md7_WzbMwKfR0gCVDgSDEAMF8UiIgqy6Ckdq0_qMktbuSuLozwq5GObV1nWaBAYmtxqFeyGh97--xDYsSvMmEbsnSY-qvI-USjqQQYKe0r22oifREoHcOMo2y72DMMZ',
      },
      {
        'category': 'Beauty',
        'name': 'Nurture Shea Ritual',
        'price': '₦12,000',
        'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBNamFBEOQQEjp8c6qC0f1D4fRz0Wl9uneBH_qFg15r8BnJIo4KspzkonmiKx-oT6cpkqC6PGH-LTjsT9lEcZ1ViQ-4yKYpjDi9iiQgYpQUy9f0yiP95ltGRr54kLk09aHNLog0h6Sqgwz8MbZ0g9kIRm7Uo07WyMlAYIzRR8OhGFGeloEqdp2ciCRSPAOJxeYlvXUsxIarG2MxSk6jFlFG9Amr3S0CJVDwC5OhKfC2tSS8N6oVgtQHiGIo0ODJp18aR8Yr8skQCpXa',
      },
    ];

    return Scaffold(
      backgroundColor: _T.surface,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_T.surface, Color(0x00FCF9F4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.menu, color: _T.primary)
            ),
            const SizedBox(width: 16),
            Text('Afri Store', style: _serif(24, FontWeight.bold, color: _T.onSurface)),
            const Spacer(),
            const Icon(Icons.notifications_outlined, color: _T.primary),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 100, bottom: 120, left: _T.hPad, right: _T.hPad),
        physics: const BouncingScrollPhysics(),
        children: [
          // Header
          Text("My Wishlist", style: _serif(36, FontWeight.bold, fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text("6 ITEMS SAVED", style: _sans(12, FontWeight.bold, color: _T.primary).copyWith(letterSpacing: 2)),
              const SizedBox(width: 8),
              Expanded(
                child: Container(height: 1, color: _T.outlineVariant.withOpacity(0.3)),
              )
            ],
          ),
          const SizedBox(height: 32),

          // Grid
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.52,
              crossAxisSpacing: 16,
              mainAxisSpacing: 32,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _WishlistCard(item: items[index]);
            },
          ),
        ],
      ),
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: 2, // favorite active
        onTap: (i) {
          if (i == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.listing);
          if (i == 3) Navigator.pushNamed(context, AppRoutes.orders);
          if (i == 4) Navigator.pushNamed(context, AppRoutes.profile);
        },
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _WishlistCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: _T.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12, right: 12,
                child: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: const Center(
                        child: Icon(Icons.favorite, color: _T.error, size: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(item['category'].toString().toUpperCase(), style: _sans(10, FontWeight.bold, color: Colors.grey[500]!).copyWith(letterSpacing: 2)),
        const SizedBox(height: 4),
        Text(item['name'], style: _accent(14, FontWeight.bold, color: _T.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text(item['price'], style: _sans(14, FontWeight.bold, color: _T.primary)),
        const SizedBox(height: 12),
        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [_T.primary, _T.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [BoxShadow(color: _T.primary.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            alignment: Alignment.center,
            child: Text("Add to Cart", style: _sans(12, FontWeight.bold, color: _T.onPrimary)),
          ),
        ),
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
    Icons.favorite,
    Icons.inventory_2,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(color: Colors.transparent),
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
                      if (active) ...[
                        const SizedBox(height: 8),
                        Container(
                          width: 4, height: 4,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: _T.primary),
                        ),
                      ]
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
