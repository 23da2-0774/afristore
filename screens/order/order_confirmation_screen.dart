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
  static const secondaryContainer = Color(0xFFFECE65);
  static const onSecondaryContainer = Color(0xFF755700);

  static const onSurface = Color(0xFF1C1C19);
  static const onSurfaceVariant = Color(0xFF55433C);

  static const outlineVariant = Color(0xFFDBC1B8);
  static const hPad = 24.0;
}

// ─── Typography helpers ───────────────────────────────────────────────────────
TextStyle _serif(double size, FontWeight weight, {Color color = _T.onSurface, FontStyle fontStyle = FontStyle.normal}) =>
    GoogleFonts.cormorantGaramond(fontSize: size, fontWeight: weight, color: color, fontStyle: fontStyle);

TextStyle _sans(double size, FontWeight weight, {Color color = _T.onSurface, double letterSpacing = 0}) =>
    GoogleFonts.plusJakartaSans(fontSize: size, fontWeight: weight, color: color, letterSpacing: letterSpacing);

TextStyle _accent(double size, FontWeight weight, {Color color = _T.onSurface}) =>
    GoogleFonts.nunito(fontSize: size, fontWeight: weight, color: color);

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.surface,
      body: Stack(
        children: [
          // Background Pattern (Subtle Mudcloth Influence - opacity 0.03)
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.network(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCPrBapf2in5gsyOMFtjaF-wNW85lloVj24FUCzbSKp0pv7WHTjigwg7ckZ1Ol1S2BqsNriINCE1L48BesPgaJ6dvNZ8uYTH6DW_a2q5J1PQ6fXOdW4KMGpuLD3Os-YMqi9OciL3rGNOxB99eYtESmB7JYIgH0BVttDW6d66s9F7d-oQldR_Z0NIZb7S6EkbtEybuWoAQ45ylEdRuLMGsdsoCFQhpTqMoHHqxDzt7uTrEQ7NkzJro7UhvFZW2XQYGi2IPFLd41MzCEZ",
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          // Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text("Afri Store", style: _serif(24, FontWeight.bold)),
              ),
            ),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: _T.hPad),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60), // Room for header

                  // Animated Checkmark Container
                  SizedBox(
                    width: 128, height: 128,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Abstract Rings
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: _T.secondary.withOpacity(0.1)),
                          ),
                        ),
                        Container(
                          width: 150, height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: _T.secondary.withOpacity(0.1)),
                          ),
                        ),
                        // Inner circle
                        Container(
                          width: 128, height: 128,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: _T.secondaryContainer,
                            boxShadow: [
                              BoxShadow(color: Color(0x0F2C1810), blurRadius: 32, offset: Offset(0, 12)),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.check_circle, size: 64, color: _T.onSecondaryContainer),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text("Order Placed!", style: _serif(48, FontWeight.bold, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    width: 280,
                    child: Text(
                      "Thank you for supporting authentic African craftsmanship. Your journey begins.",
                      textAlign: TextAlign.center,
                      style: _accent(16, FontWeight.normal, color: _T.onSurfaceVariant).copyWith(height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Order Information Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _T.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Color(0x0F2C1810), blurRadius: 32, offset: Offset(0, 12)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ORDER ID", style: _sans(12, FontWeight.bold, color: _T.onSurfaceVariant).copyWith(letterSpacing: 2)),
                            Text("#AS-9284-KNT", style: _accent(14, FontWeight.bold, color: _T.onSurface)),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: _T.surfaceContainerHighest, height: 1, thickness: 1),
                        ),
                        Text("ESTIMATED DELIVERY", style: _sans(12, FontWeight.bold, color: _T.onSurfaceVariant).copyWith(letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.local_shipping, size: 16, color: _T.secondary),
                            const SizedBox(width: 8),
                            Text("Oct 24 - Oct 27, 2023", style: _accent(14, FontWeight.bold, color: _T.onSurface)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Abstract Editorial Image
                  const SizedBox(height: 16),
                  Transform.rotate(
                    angle: -0.035, // approx -2 degrees
                    child: Container(
                      width: double.infinity,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Color(0x0F2C1810), blurRadius: 32, offset: Offset(0, 12)),
                        ],
                        image: const DecorationImage(
                          image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAbFB0SxgtdTquM3ef8E1I7ZkOleDFUVEB6KMhiTLY9CyADM3_ai55NLFQxR6hS_KCyfwEyW2EgRcs3Omsh4fNAvN-_1vjMruutaDKfEyKpX_h2J6cZwVNBDBu8ViRNBR2Lx4gPis0ka1ij8JuP25JDdgSuDdnixSdoRXX__RW9XuFQSsD6I9rGYHppMx25hR3os2zPRfe689ZIA1RrlDUdyVtjpJrSkNLt1ALjLevIIQp8GHn2st0F4fV9sqsJL22Qgpo4xTJNw-re"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Action Buttons
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [_T.primary, _T.primaryContainer],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(color: _T.primary.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text("Continue Shopping", style: _accent(16, FontWeight.bold, color: _T.onPrimary)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _T.outlineVariant.withOpacity(0.3), width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text("Track Order", style: _accent(16, FontWeight.bold, color: _T.primary)),
                    ),
                  ),

                  // Footer Support Link
                  const SizedBox(height: 48),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: _T.outlineVariant.withOpacity(0.4))),
                    ),
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      "NEED HELP? CONTACT SUPPORT",
                      style: _sans(12, FontWeight.normal, color: _T.onSurfaceVariant).copyWith(letterSpacing: 2),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
