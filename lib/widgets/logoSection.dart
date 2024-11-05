import 'package:flutter/material.dart';
import 'package:leafolyze/constants/color.dart';

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'lib/assets/images/logo.png',
          height: 90,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'leaf',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.GreenLogodanButton,
                  fontFamily: 'Nunito Sans',
                ),
              ),
              TextSpan(
                text: 'olyze',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.logoRed, // Change this to your desired color
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
