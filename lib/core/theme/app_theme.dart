import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF0B0D0F);
  static const Color surfaceColor = Color(0xFF141719);
  static const Color cardColor = Color(0xFF191D20);
  static const Color accentColor = Color(0xFF39FF14); // Electric Green
  static const Color aiAccentColor = Color(0xFF00E5FF); // AI Cyan
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8); // Soft gray
  static const Color errorColor = Color(0xFFEF4444); // Professional Red

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: accentColor,
      colorScheme: const ColorScheme.dark(
        primary: accentColor,
        secondary: aiAccentColor,
        surface: surfaceColor,
        onSurface: textPrimary,
        error: errorColor,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w800,
              color: textPrimary,
              fontSize: 32,
            ),
            headlineLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: textPrimary,
              fontSize: 24,
            ),
            titleLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: textPrimary,
              fontSize: 18,
            ),
            bodyLarge: GoogleFonts.inter(color: textPrimary, fontSize: 16),
            bodyMedium: GoogleFonts.inter(color: textSecondary, fontSize: 14),
            labelSmall: GoogleFonts.inter(
              color: textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              fontSize: 10,
            ),
          ),
      cardTheme: CardThemeData(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white10, width: 1),
        ),
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: accentColor.withValues(alpha: 0.1),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: accentColor);
          }
          return const IconThemeData(color: textSecondary);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accentColor,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          );
        }),
      ),
    );
  }
}
