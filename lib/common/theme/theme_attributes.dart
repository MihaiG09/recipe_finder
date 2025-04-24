import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_finder/common/theme/typography.dart';

import 'app_colors.dart';

class ThemeAttributes {
  TextTheme get textTheme {
    return TextTheme(
      titleLarge: GoogleFonts.outfit(
        fontSize: Subtitle.sizeBase,
        height: 1.2,
        color: AppColors.black,
        fontWeight: TitlePage.weight,
        letterSpacing: 0,
      ),
      labelLarge: GoogleFonts.outfit(
        fontSize: BodyStyle.sizeMedium,
        height: 1.4,
        color: AppColors.black,
        fontWeight: BodyStyle.weightStrong,
        letterSpacing: 0,
      ),
      labelMedium: GoogleFonts.outfit(
        fontSize: BodyStyle.sizeMedium,
        height: 1,
        color: AppColors.black,
        fontWeight: BodyStyle.weightStrong,
        letterSpacing: 0,
      ),
      labelSmall: GoogleFonts.outfit(
        fontSize: BodyStyle.sizeMedium,
        height: 1.4,
        color: AppColors.black,
        fontWeight: TitlePage.weight,
        letterSpacing: 0,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: Heading.sizeBase,
        height: 1.2,
        color: AppColors.black,
        fontWeight: Heading.weight,
        letterSpacing: -0.02,
      ),
      bodySmall: GoogleFonts.outfit(
        fontSize: BodyStyle.sizeSmall,
        height: 1.4,
        color: AppColors.black,
        fontWeight: BodyStyle.weightRegular,
        letterSpacing: 0,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: BodyStyle.sizeMedium,
        height: 1.4,
        color: AppColors.black,
        fontWeight: BodyStyle.weightRegular,
        letterSpacing: 0,
      ),
    );
  }

  ElevatedButtonThemeData get elevatedButtonStyle => ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      textStyle: WidgetStatePropertyAll(
        textTheme.labelMedium?.copyWith(color: AppColors.white),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      elevation: WidgetStatePropertyAll(0),
    ),
  );
}
