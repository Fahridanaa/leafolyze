import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.spacingMS,
            horizontal: AppSpacing.spacingL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.radiusXL),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppFontSize.fontSizeM,
            color: AppColors.primaryForegroundColor,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ),
    );
  }
}
