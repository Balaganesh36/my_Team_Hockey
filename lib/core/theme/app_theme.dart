import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1565C0);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFF00E676);
  static const Color backgroundColorLight = Color(0xFFF5F7FA);
  static const Color backgroundColorDark = Color(0xFF0D1117);
  static const Color cardColorDark = Color(0xFF161B22);
  static const Color surfaceColorDark = Color(0xFF0D1117);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColorLight,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        color: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColorDark,
      ),
      scaffoldBackgroundColor: backgroundColorDark,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            displayMedium: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            displaySmall: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineLarge: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineMedium: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineSmall: GoogleFonts.orbitron(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        color: cardColorDark,
      ),
    );
  }
}
