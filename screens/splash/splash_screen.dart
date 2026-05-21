import 'dart:async';

import 'package:afristore/core/constants/app_colors.dart';
import 'package:afristore/core/constants/app_data.dart';
import 'package:afristore/core/constants/app_strings.dart';
import 'package:afristore/core/constants/app_text_styles.dart';
import 'package:afristore/core/routes/app_routes.dart';
import 'package:afristore/widgets/common/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double _horizontalPadding = 32;
  static const double _verticalSpacing = 20;
  static const double _logoSize = 92;
  static const Duration _screenDuration = Duration(seconds: 3);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_screenDuration, _navigate);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigate() {
    if (!mounted) return;
    // Firebase Auth check — login ஆனவர்களை Home-க்கு
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: _verticalSpacing * 2),
              _buildLogo(),
              const SizedBox(height: _verticalSpacing * 2),
              _buildTitle(),
              const SizedBox(height: _verticalSpacing),
              _buildSubtitle(),
              const Spacer(),
              _buildAction(),
              const SizedBox(height: _verticalSpacing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: _logoSize,
      width: _logoSize,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(_logoSize / 4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A2C1810),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Text(
          AppStrings.appName.substring(0, 1),
          style: AppTextStyles.headline.copyWith(
            color: AppColors.primary,
            fontSize: 34,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppStrings.splashTitle,
      style: AppTextStyles.headline.copyWith(
        fontSize: AppTextStyles.headline.fontSize! + 6,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppStrings.splashSubtitle,
      style: AppTextStyles.body.copyWith(
        color: AppColors.textGrey,
        height: 1.6,
      ),
    );
  }

  Widget _buildAction() {
    return CustomButton(label: AppStrings.splashButton, onPressed: _navigate);
  }
}
