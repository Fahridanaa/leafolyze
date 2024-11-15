import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/common/rounded_button.dart';
import 'package:leafolyze/utils/constants.dart';
// Untuk efek blur

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            top: -100,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/petanitomat.png',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          // Bagian konten di bawah dengan kelengkungan lebih estetik
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacingM,
                  vertical: AppSpacing.spacingXL),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppBorderRadius.radiusXL),
                  topRight: Radius.circular(AppBorderRadius.radiusXL),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, -3), // Posisi bayangan
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Jaga Tanamanmu!',
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeXXL,
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingM),
                  Text(
                    'Scan tanamanmu untuk melihat informasi kesehatan tanaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeM,
                      color: AppColors.textMutedColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingM),
                  RoundedButton(
                    text: 'Get Started',
                    onPressed: () {
                      context.go('/register');
                    },
                  ),
                  const SizedBox(height: AppSpacing.spacingM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeMS,
                          color: AppColors.textMutedColor,
                          fontWeight: AppFontWeight.regular,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: AppFontSize.fontSizeMS,
                            color: AppColors.textColor,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
