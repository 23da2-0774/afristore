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

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': uid,
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'postalCode': _postalController.text.trim(),
        'paymentMethod': _selectedPaymentMethod == 0
            ? 'Card'
            : _selectedPaymentMethod == 1
            ? 'Wallet'
            : 'Cash on Delivery',
        'status': 'placed',
        'timestamp': Timestamp.now(),
      });

      if (mounted) {
        Navigator.pushNamed(context, AppRoutes.confirmation);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Order failed: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(color: _T.surface.withOpacity(0.8)),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Icon(Icons.arrow_back, color: _T.onSurface),
                ),
              ),
            ),
            Text(
              "Checkout",
              style: _serif(24, FontWeight.bold, color: _T.onSurface),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              top: 100,
              left: _T.hPad,
              right: _T.hPad,
              bottom: 180,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 32),
              Text(
                "Delivery Details",
                style: _serif(24, FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),

              _buildInputLabel("Full name"),
              _buildTextInput("Kofi Mensah", controller: _nameController),
              const SizedBox(height: 20),

              _buildInputLabel("Phone number"),
              _buildTextInput(
                "+233 24 000 0000",
                controller: _phoneController,
                isPhone: true,
              ),
              const SizedBox(height: 20),

              _buildInputLabel("Shipping address"),
              _buildTextInput(
                "House No. 12, Street",
                controller: _addressController,
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("City"),
                        _buildTextInput("Accra", controller: _cityController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("Postal code"),
                        _buildTextInput(
                          "GA-183",
                          controller: _postalController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              Text(
                "Payment Method",
                style: _serif(24, FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),

              _buildPaymentMethod(
                index: 0,
                title: "Credit / Debit Card",
                subtitle: "Visa, Mastercard, Amex",
                icon: Icons.credit_card,
                iconColor: _T.primary,
                bgColor: _T.primary.withOpacity(0.05),
              ),
              const SizedBox(height: 12),
              _buildPaymentMethod(
                index: 1,
                title: "Mobile Wallet",
                subtitle: "MTN MoMo, AirtelTigo Money",
                icon: Icons.account_balance_wallet,
                iconColor: _T.secondary,
                bgColor: _T.secondary.withOpacity(0.05),
              ),
              const SizedBox(height: 12),
              _buildPaymentMethod(
                index: 2,
                title: "Cash on Delivery",
                subtitle: "Pay when you receive",
                icon: Icons.payments,
                iconColor: _T.onSurfaceVariant,
                bgColor: Colors.grey[200]!,
              ),
            ],
          ),

          // Bottom Sticky Area
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: _T.surface,
              padding: const EdgeInsets.fromLTRB(_T.hPad, 16, _T.hPad, 20),
              child: GestureDetector(
                onTap: _isLoading ? null : _placeOrder,
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
                      BoxShadow(
                        color: _T.primary.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Place Order",
                          style: _sans(
                            16,
                            FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: _sans(
          11,
          FontWeight.bold,
          color: _T.onSurfaceVariant.withOpacity(0.8),
        ).copyWith(letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildTextInput(
    String hint, {
    TextEditingController? controller,
    bool isPhone = false,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _T.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _T.outlineVariant.withOpacity(0.5)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: _sans(14, FontWeight.normal, color: _T.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _sans(14, FontWeight.normal, color: Colors.grey[400]!),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: isPhone
              ? Icon(Icons.call, color: Colors.grey[300])
              : null,
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    final isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _T.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _T.primary : _T.outlineVariant.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _sans(14, FontWeight.bold, color: _T.onSurface),
                  ),
                  Text(
                    subtitle,
                    style: _sans(
                      12,
                      FontWeight.normal,
                      color: Colors.grey[500]!,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? _T.primary : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _T.primary,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
