import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom colors
class AppColors {
  // Light Theme Colors
  static const lightPrimary = Color(0xFF00ADB5);
  static const lightBackground = Color(0xFFEEEEEE);
  static const lightSurface = Colors.white;
  static const lightText = Color(0xFF222831);

  // Dark Theme Colors
  static const darkPrimary = Color(0xFF00ADB5);
  static const darkBackground = Color(0xFF222831);
  static const darkSurface = Color(0xFF393E46);
  static const darkText = Color(0xFFEEEEEE);

  // Common Colors
  static const accent = Color(0xFF00ADB5);
  static const error = Color(0xFFFF5252);
}

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: AppColors.lightPrimary,
  scaffoldBackgroundColor: AppColors.lightBackground,
  
  colorScheme: const ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.accent,
    surface: AppColors.lightSurface,
    background: AppColors.lightBackground,
    error: AppColors.error,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightPrimary,
    foregroundColor: AppColors.lightBackground,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.lightBackground,
    ),
  ),

  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: AppColors.lightText,
    displayColor: AppColors.lightText,
  ),

  cardTheme: CardTheme(
    color: AppColors.lightSurface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightPrimary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightPrimary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.lightPrimary,
    unselectedItemColor: Colors.grey,
  ),

  iconTheme: const IconThemeData(
    color: AppColors.lightPrimary,
  ),
);

// dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.accent,
    surface: AppColors.darkSurface,
    background: AppColors.darkBackground,
    error: AppColors.error,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkText,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
  ),

  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: AppColors.darkText,
    displayColor: AppColors.darkText,
  ),

  cardTheme: CardTheme(
    color: AppColors.darkSurface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkPrimary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkPrimary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.darkPrimary,
    unselectedItemColor: Colors.grey,
  ),

  iconTheme: const IconThemeData(
    color: AppColors.darkPrimary,
  ),
);
