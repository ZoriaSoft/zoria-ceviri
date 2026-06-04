import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.interTightTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.fraunces(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        height: 1.05,
        letterSpacing: -0.02,
        color: AppColors.ink,
      ),
      displayMedium: GoogleFonts.fraunces(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.08,
        letterSpacing: -0.015,
        color: AppColors.ink,
      ),
      headlineMedium: GoogleFonts.fraunces(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      ),
      titleLarge: GoogleFonts.interTight(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      titleMedium: GoogleFonts.interTight(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      bodyLarge: GoogleFonts.interTight(
        fontSize: 16,
        height: 1.5,
        color: AppColors.ink,
      ),
      bodyMedium: GoogleFonts.interTight(
        fontSize: 14,
        height: 1.45,
        color: AppColors.ink,
      ),
      bodySmall: GoogleFonts.interTight(
        fontSize: 12,
        color: AppColors.inkMute,
        letterSpacing: 0.02,
      ),
      labelLarge: GoogleFonts.interTight(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.04,
        color: AppColors.ink,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        primary: AppColors.amber,
        onPrimary: AppColors.background,
        secondary: AppColors.ember,
        onSecondary: AppColors.ink,
        error: AppColors.ember,
        onError: AppColors.ink,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
          letterSpacing: -0.01,
        ),
        iconTheme: const IconThemeData(color: AppColors.ink, size: 22),
      ),
      dividerColor: AppColors.hairline,
      iconTheme: const IconThemeData(color: AppColors.ink, size: 22),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.amber),
          foregroundColor: const WidgetStatePropertyAll(AppColors.background),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
          shape: const WidgetStatePropertyAll(StadiumBorder()),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.interTight(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.02,
            ),
          ),
          overlayColor: const WidgetStatePropertyAll(Color(0x14FFFFFF)),
        ).copyWith(
          // Press feedback: scale 0.97 (Emil: "buttons must feel responsive")
          // Implemented via a custom MaterialState wrapper.
          // We use a state-property based no-op to leave room for future ripple tuning.
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.ink),
          side: const WidgetStatePropertyAll(BorderSide(color: AppColors.border)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          shape: const WidgetStatePropertyAll(StadiumBorder()),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.interTight(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          overlayColor: const WidgetStatePropertyAll(Color(0x0AF4EFE3)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.amber),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.interTight(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          overlayColor: const WidgetStatePropertyAll(Color(0x14E0A85B)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceRaised,
        contentTextStyle: GoogleFonts.interTight(color: AppColors.ink),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  static ThemeData light() {
    // Editorial-mobile register is dark-first. Light is a graceful fallback
    // used only if the system forces it before settings resolve.
    return ThemeData.light(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: const Color(0xFFFAF7F0),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFB58841),
        secondary: Color(0xFFC46A3F),
        surface: Color(0xFFF1ECE0),
        onSurface: Color(0xFF1B1815),
      ),
      textTheme: GoogleFonts.interTightTextTheme(
        ThemeData.light(useMaterial3: true).textTheme,
      ),
    );
  }
}
