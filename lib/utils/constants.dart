import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const primaryColor = Color(0xFFB4DB46);
  static const primaryColorLight = Color(0xFFF0F8DA);
  static const primaryColorDark = Color(0xFF242C0E);
  static const primaryForegroundColor = Color(0xFF272D20);
  static const textMutedColor = Color(0xFF64748B);
  static const textColor = Color(0xFF020617);
  static const actionTextColor = Color(0xFF5A6D23);
  static const backgroundColor = Colors.white;
  static const errorColor = Color.fromARGB(255, 210, 75, 75);
}

@immutable
class AppTextStyles {
  //heading
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
  static const heading2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
  static const heading3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const headingCard = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColorDark,
  );

  static const headingCard2 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  //subheading
  static const subHeading1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMutedColor,
  );

  static const contentCard = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryForegroundColor,
  );

  static TextStyle contentCard2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white.withOpacity(0.8),
  );

  //text
  static const promptTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.textMutedColor,
  );

  static const actionTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static const actionTextStyle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.actionTextColor,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryForegroundColor,
  );
  static const buttonTextStyle2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.errorColor,
  );

  static const inputErrorTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.errorColor,
  );
}

@immutable
class AppSpacing {
  static const double spacingXXS = 4;
  static const double spacingXS = 6;
  static const double spacingS = 8;
  static const double spacingMS = 12;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
}

class AppBorderRadius {
  static const double radiusXXS = 4;
  static const double radiusXS = 8;
  static const double radiusS = 12;
  static const double radiusM = 16;
  static const double radiusL = 24;
}
