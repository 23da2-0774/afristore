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
  static const primaryFixedDim = Color(0xFFFFB59A);
  static const onPrimary = Color(0xFFFFFFFF);
  static const secondary = Color(0xFF795900);
  static const error = Color(0xFFBA1A1A);
  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);
  static const outlineVariant = Color(0xFFDBC1B8);
  static const outline = Color(0xFF88726B);
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _user = FirebaseAuth.instance.currentUser;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(_user?.uid)
            .get(),
        builder: (context, snapshot) {
          String name = _user?.email ?? 'User';
          String email = _user?.email ?? '';

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            name = data['name'] ?? name;
            email = data['email'] ?? email;
          }

          return ListView(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 120,
              left: _T.hPad,
              right: _T.hPad,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              // User Header
              Column(
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _T.primary,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F2C1810),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: _serif(48, FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    name,
                    style: _serif(30, FontWeight.bold, color: _T.onSurface),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: _sans(
                      14,
                      FontWeight.normal,
                      color: _T.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Account Settings
              Text(
                "Account Settings",
                style: _serif(20, FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: _T.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _T.outlineVariant.withOpacity(0.2)),
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
                    _buildMenuItem(
                      "My Orders",
                      Icons.inventory_2,
                      _T.primary,
                      _T.primaryFixedDim.withOpacity(0.3),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.orders),
                    ),
                    _buildMenuItem(
                      "My Wishlist",
                      Icons.favorite,
                      _T.primary,
                      _T.primaryFixedDim.withOpacity(0.3),
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.wishlist),
                    ),
                    _buildMenuItem(
                      "Delivery Addresses",
                      Icons.location_on,
                      _T.primary,
                      _T.primaryFixedDim.withOpacity(0.3),
                    ),
                    _buildMenuItem(
                      "Payment Methods",
                      Icons.payments,
                      _T.primary,
                      _T.primaryFixedDim.withOpacity(0.3),
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Support
              Text(
                "Support",
                style: _serif(20, FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: _T.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _T.outlineVariant.withOpacity(0.2)),
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
                    _buildMenuItem(
                      "Notifications",
                      Icons.notifications,
                      _T.onSurfaceVariant,
                      _T.surfaceContainerHighest,
                    ),
                    _buildMenuItem(
                      "Help & Support",
                      Icons.help,
                      _T.onSurfaceVariant,
                      _T.surfaceContainerHighest,
                    ),
                    _buildMenuItem(
                      "Privacy Policy",
                      Icons.policy,
                      _T.onSurfaceVariant,
                      _T.surfaceContainerHighest,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Logout
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE8E7),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _T.error.withOpacity(0.1)),
                ),
                child: _buildMenuItem(
                  "Logout",
                  Icons.logout,
                  _T.error,
                  _T.error.withOpacity(0.1),
                  isLast: true,
                  textColor: _T.error,
                  onTap: _logout,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: 4,
        onTap: (i) {
          if (i == 0) Navigator.pushNamed(context, AppRoutes.home);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.listing);
          if (i == 2) Navigator.pushNamed(context, AppRoutes.cart);
          if (i == 3) Navigator.pushNamed(context, AppRoutes.orders);
        },
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    Color iconColor,
    Color iconBgColor, {
    bool isLast = false,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: _accent(
                      16,
                      FontWeight.bold,
                      color: textColor ?? _T.onSurface,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: _T.outline),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: _T.outlineVariant.withOpacity(0.2),
            height: 1,
            indent: 20,
            endIndent: 20,
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
