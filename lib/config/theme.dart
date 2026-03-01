import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Vocalia Premium Design System
/// Accessibility-first: High contrast, large touch targets, clear typography
/// Visual excellence: Gradients, glassmorphism, depth, premium feel
class VocaliaTheme {
  // ─── Brand Colors — Rich, vibrant, premium ───
  static const Color primary = Color(0xFF7B61FF);       // Electric violet
  static const Color primaryLight = Color(0xFFA78BFA);   // Soft lavender
  static const Color primaryDark = Color(0xFF5B3FD9);    // Deep purple
  static const Color secondary = Color(0xFFFF6B9D);      // Hot coral-pink
  static const Color secondaryDark = Color(0xFFE8457A);  // Deep pink
  static const Color accent = Color(0xFF00D4AA);          // Bright teal
  static const Color accentDark = Color(0xFF00B894);     // Deep teal
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF00E676);

  // ─── Category Colors — For visual distinction ───
  static const List<Color> categoryColors = [
    Color(0xFFFFB300),  // Básico — gold (core words first!)
    Color(0xFFFF6B9D),  // Emociones — pink
    Color(0xFFFFD54F),  // Acciones — yellow
    Color(0xFFFF8A65),  // Comida — orange
    Color(0xFF4FC3F7),  // Bebidas — blue
    Color(0xFF81C784),  // Lugares — green
    Color(0xFFBA68C8),  // Personas — purple
    Color(0xFFEF5350),  // Cuerpo — red
    Color(0xFF4DD0E1),  // Tiempo — cyan
    Color(0xFF90A4AE),  // Objetos — grey-blue
    Color(0xFF7E57C2),  // Adjetivos — indigo
    Color(0xFF26A69A),  // Social — teal
  ];

  // ─── Gradient Presets ───
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7B61FF), Color(0xFFFF6B9D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF0EDFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient speakButtonGradient = LinearGradient(
    colors: [Color(0xFF7B61FF), Color(0xFF5B3FD9), Color(0xFF3A1FA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── Surfaces ───
  static const Color bgLight = Color(0xFFF5F3FF);        // Warm violet tint
  static const Color bgDark = Color(0xFF0F0F1A);          // Deep space
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E32);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2A2A45);

  // ─── Text ───
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF8B8FA3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFFF0F0FF);
  static const Color textDarkSecondary = Color(0xFF9CA3AF);

  // ─── Accessibility: Minimum touch target ───
  static const double minTouchTarget = 64.0;
  static const double pictogramSize = 80.0;
  static const double pictogramSizeLarge = 100.0;

  // ─── Border Radius ───
  static const double radiusSm = 14.0;
  static const double radiusMd = 20.0;
  static const double radiusLg = 28.0;
  static const double radiusXl = 36.0;

  // ─── Spacing ───
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // ─── Shadows ───
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primary.withAlpha(15),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withAlpha(8),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: primary.withAlpha(40),
      blurRadius: 24,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primary.withAlpha(8),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withAlpha(5),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  // ─── Light Theme ───
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        primary: primary,
        secondary: secondary,
        surface: surfaceLight,
        error: error,
      ),
      scaffoldBackgroundColor: bgLight,
      textTheme: _textTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shadowColor: primary.withAlpha(25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textOnPrimary,
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: textOnPrimary,
        elevation: 8,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceLight,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ─── Dark Theme ───
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
        primary: primaryLight,
        secondary: secondary,
        surface: surfaceDark,
        error: error,
      ),
      scaffoldBackgroundColor: bgDark,
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: bgDark,
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        foregroundColor: bgDark,
        elevation: 8,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryLight,
        unselectedItemColor: textDarkSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final color = brightness == Brightness.light ? textPrimary : textDark;
    return TextTheme(
      displayLarge: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.w800, color: color),
      displayMedium: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w700, color: color),
      headlineLarge: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w700, color: color),
      headlineMedium: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600, color: color),
      titleLarge: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: color),
      titleMedium: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: color),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: color),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: color),
      labelLarge: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }
}
