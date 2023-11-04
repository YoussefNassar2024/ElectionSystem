import 'package:flutter/material.dart';

class CustomStyle {
  static final _ColorPalette colorPalette = _ColorPalette();
  static final _FontSizes fontSizes = _FontSizes();
  static const boldFont = 'Inter-Bold';
  static const lightFont = 'Inter-Light';
  static const meduimFont = 'Inter-Medium';
  static const regularFont = 'Inter-Regular';
  static const semiBoldFont = 'Inter-SemiBold';
}

class _ColorPalette {
  Color purple = Color(0xFF455EEF);
  Color lightPurple = Color(0xFFAEC3F7);
  Color darkPurple = Color(0xFF040032);
  Color green = Color(0xFF11D861);
  Color white = Color(0xFFFFFFFF);
  Color red = Color(0xFFD51818);
}

class _FontSizes {
  double smallFont = 12;
  double subMediumFont = 15;
  double mediumFont = 18;
  double largeFont = 20;
  double codeFont = 14;
}
