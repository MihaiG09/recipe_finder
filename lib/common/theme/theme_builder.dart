import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'theme_attributes.dart';

class ThemeBuilder {
  static ThemeData getThemeData() {
    var attributes = ThemeAttributes();
    return ThemeData(
      textTheme: attributes.textTheme,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary,
        surface: AppColors.white,
      ),
      elevatedButtonTheme: attributes.elevatedButtonStyle,
    );
  }
}
