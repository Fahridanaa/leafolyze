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
class AppFontSize {
  static const double fontSizeXXL = 24;
  static const double fontSizeXL = 20;
  static const double fontSizeL = 18;
  static const double fontSizeM = 16;
  static const double fontSizeMS = 14;
  static const double fontSizeS = 12;
  static const double fontSizeXS = 10;
  static const double fontSizeXXS = 8;
}

@immutable
class AppFontWeight {
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight light = FontWeight.w300;
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
