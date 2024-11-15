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

  static const borderColor = Color(0xFFBFC2C8);
  static const borderColorLight = Color(0xFFF1F5F9);
  static const borderColorDark = Color(0xFF1E293B);

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
class AppLineHeight {
  static const double lineHeightXS = 1.25;
  static const double lineHeightS = 1.5;
  static const double lineHeightM = 2;
  static const double lineHeightL = 2.5;
  static const double lineHeightXL = 3;
  static const double lineHeightXXL = 3.5;
}

@immutable
class AppSpacing {
  static const double spacingXXXS = 2;
  static const double spacingXXS = 4;
  static const double spacingXS = 6;
  static const double spacingS = 8;
  static const double spacingMS = 12;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
}

@immutable
class AppBorderRadius {
  static const double radiusXXS = 4;
  static const double radiusXS = 8;
  static const double radiusS = 12;
  static const double radiusM = 16;
  static const double radiusL = 24;
  static const double radiusXL = 32;
}

@immutable
class AppIconSize {
  static const double iconXXXS = 14;
  static const double iconXXS = 16;
  static const double iconXS = 20;
  static const double iconS = 24;
  static const double iconM = 28;
  static const double iconL = 32;
  static const double iconXL = 36;
}
