import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF0D0D0D);
  static const Color surfaceColor = Color(0xFF1A1A1A);
  static const Color accentColor = Color(0xFF39FF14); // Electric Green
  static const Color secondaryAccentColor = Color(0xFF00E5FF); // AI Cyan
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: accentColor,
      colorScheme: const ColorScheme.dark(
        primary: accentColor,
        secondary: secondaryAccentColor,
        surface: surfaceColor,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
            headlineLarge: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
            titleLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            bodyLarge: GoogleFonts.inter(color: textPrimary),
            bodyMedium: GoogleFonts.inter(color: textSecondary),
          ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: accentColor.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
