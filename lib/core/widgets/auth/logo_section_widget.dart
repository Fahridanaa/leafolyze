import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 50,
          height: 40,
        ),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'leafolyze',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
