import 'dart:ui';
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


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isDescriptionExpanded = true;
  String _selectedSize = 'M';
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Custom back button used
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black38, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Row(
          children: [
            _GlassButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),
            _GlassButton(icon: Icons.favorite, onTap: () {}),
            const SizedBox(width: 8),
            _GlassButton(icon: Icons.share, onTap: () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Leave space for bottom bar
            child: Column(
              children: [
                // Hero Product Image
                SizedBox(
                  height: 442,
                  width: double.infinity,
                  child: Image.network(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDAiO8TPHnFpOpQBbCaV6UqFCmoxPs3sFRmbHuvFTUMibMxqVoLs-9D3JK2KFn3PJOqgOVUaM678Rj4hkv4pWbz-Ftb-Hgzv_LqLuW7PL8T4MuvV0hJNU37YFfGg0hysCKgKltokxL0BmnB9mcrF7YAGB_POxM6smTOspsarf0wx0Fgfcg9xWhIebUGdHnx0r2oJs5NPcIxOobczwK3YCMNCqb5xhYwdUn1Y8umlZL_w3LOlSgKtSE2u5297_Z_7dZ57bNcpthTc4oR",
                    fit: BoxFit.cover,
                  ),
                ),
                // Floating Info Card
                Transform.translate(
                  offset: const Offset(0, -48),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: _T.surfaceContainerLowest,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0F2C1810),
                            blurRadius: 32,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AYANFE HERITAGE", style: _accent(12, FontWeight.bold, color: _T.onSurfaceVariant).copyWith(letterSpacing: 1.5)),
                          const SizedBox(height: 4),
                          Text(
                            "Oshogbo Indigo Caftan",
                            style: _serif(36, FontWeight.bold, color: _T.onSurface).copyWith(height: 1.1),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.star, color: _T.secondary, size: 16),
                                  Icon(Icons.star, color: _T.secondary, size: 16),
                                  Icon(Icons.star, color: _T.secondary, size: 16),
                                  Icon(Icons.star, color: _T.secondary, size: 16),
                                  Icon(Icons.star_border, color: _T.secondary, size: 16),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Text("4.8 (124 Reviews)", style: _sans(14, FontWeight.w500, color: _T.onSurfaceVariant)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text("\$245.00", style: _serif(30, FontWeight.w600, color: _T.primary)),
                          const SizedBox(height: 32),

                          // Size Selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select Size", style: _sans(14, FontWeight.bold, color: _T.onSurface)),
                              Text("Size Guide", style: _sans(12, FontWeight.bold, color: _T.primary).copyWith(decoration: TextDecoration.underline, decorationColor: _T.primary)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                              final isSelected = _selectedSize == size;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedSize = size),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected ? _T.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected ? _T.primary : _T.outlineVariant.withOpacity(0.4),
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    size,
                                    style: _sans(14, FontWeight.bold, color: isSelected ? _T.onPrimary : _T.onSurfaceVariant),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 32),

                          // Color Palette
                          Text("Color Palette", style: _sans(14, FontWeight.bold, color: _T.onSurface)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _ColorSelector(color: const Color(0xFF1c2e4a), isSelected: true),
                              const SizedBox(width: 16),
                              _ColorSelector(color: const Color(0xFF4a2e1c), isSelected: false),
                              const SizedBox(width: 16),
                              _ColorSelector(color: const Color(0xFF2e4a1c), isSelected: false),
                              const SizedBox(width: 16),
                              _ColorSelector(color: const Color(0xFFe5e2dd), isSelected: false),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Quantity and Detail
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: _T.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_quantity > 1) setState(() => _quantity--);
                                      },
                                      child: const SizedBox(width: 40, height: 40, child: Icon(Icons.remove, color: _T.onSurface)),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        "$_quantity",
                                        textAlign: TextAlign.center,
                                        style: _sans(14, FontWeight.bold, color: _T.onSurface),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(() => _quantity++),
                                      child: const SizedBox(width: 40, height: 40, child: Icon(Icons.add, color: _T.onSurface)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Text("Only 4 left in stock", style: _accent(14, FontWeight.normal, color: _T.onSurfaceVariant).copyWith(fontStyle: FontStyle.italic)),
                            ],
                          ),
                          const SizedBox(height: 40),

                          const Divider(color: _T.outlineVariant, height: 1, thickness: 0.5),
                          const SizedBox(height: 24),

                          // Expandable Description
                          GestureDetector(
                            onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Product Description", style: _sans(16, FontWeight.bold, color: _T.onSurface)),
                                Icon(_isDescriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: _T.onSurface),
                              ],
                            ),
                          ),
                          if (_isDescriptionExpanded) ...[
                            const SizedBox(height: 12),
                            Text(
                              "Each caftan is hand-dyed in the ancient pits of Oshogbo using traditional indigo fermentation techniques. The organic cotton is sourced directly from small-holder farms in Nigeria, ensuring a soft, breathable drape that honors the artisan's touch.",
                              style: _sans(14, FontWeight.normal, color: _T.onSurfaceVariant).copyWith(height: 1.6),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),

                // Related Items (Editorial Bento Grid)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Complete the Look", style: _serif(24, FontWeight.bold, color: _T.onSurface)),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _BentoItem(
                              imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuA43tiG9KwVgZAmXie9LSeB2ofV0jHMJydH4pxNQ-jHKhzFJD4vCw_I4ZBwqF7N9bHqLLMyUxO23pI_YQ4x9YGLjM6fYtS2QLyY--yhjNkrZv7FO62FPa3lDnzhoj3XyUisQqdoy4KZWKOv9HLXvgSOx27TSxSJzykN3-KSgMf22mgXCqZQhD1Z7iADZB9hKQ8p7XxTRDdzivs3VgoisE-F0vuWCOT4-610j760VPCrafccBCHY_xs89BjIXEFQl5pZ0FQw0Q1P4nkL",
                              category: "JEWELRY",
                              name: "Sun-Eye Beads",
                              aspectRatio: 1,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: _BentoItem(
                                imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDLb0UlDXeOtCN0nqtQwniIhT10ZPAFsnAaY2SEUsLmuVhM71MR3QLe3ZcgvBdIqjpopgc6bAZ6ntczPQ7ceeM1fsvKb9Gp5ci7T_CyDyc4OKoXMZXvw_3_MiI-QEV00-aLUDNABx74qD9UCr2H2SuM-rHxRqBXH2iHnRuw-vceoXlp-dhYWQvFA3sZh3wDohEj6cu0dQwWcehkFjrvcJK_Dp6_D8k5ud2Q5OwNcsUT7wsD9tUaNd8vNOPGbSSA5qqq226kOCf4PnWK",
                                category: "FOOTWEAR",
                                name: "Linen Steps",
                                aspectRatio: 3/4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sticky Bottom Bar
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: _T.hPad, vertical: 24),
                  decoration: BoxDecoration(
                    color: _T.surface.withOpacity(0.8),
                    boxShadow: const [
                      BoxShadow(color: Color(0x0F2C1810), blurRadius: 32, offset: Offset(0, -12)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _T.primary, width: 2),
                        ),
                        child: const Icon(Icons.shopping_bag_outlined, color: _T.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [_T.primary, _T.primaryContainer],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Buy Now",
                            style: _sans(16, FontWeight.bold, color: _T.onPrimary).copyWith(letterSpacing: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _T.surface.withOpacity(0.8),
            ),
            child: Icon(icon, color: _T.onSurface, size: 20),
          ),
        ),
      ),
    );
  }
}

class _ColorSelector extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const _ColorSelector({required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: _T.primary, width: 2) : null,
      ),
    );
  }
}

class _BentoItem extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String name;
  final double aspectRatio;

  const _BentoItem({
    required this.imageUrl, required this.category, required this.name, required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _T.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(category, style: _sans(10, FontWeight.bold, color: _T.primary)),
          const SizedBox(height: 4),
          Text(name, style: _sans(14, FontWeight.bold, color: _T.onSurface)),
        ],
      ),
    );
  }
}
