import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ---
/// /// [AppTheme] define el sistema de diseño visual rediseñado para la aplicación.
/// ///
/// /// Implementa la nueva paleta de colores y la tipografía 'Poppins' para
/// /// lograr un aspecto moderno, limpio y profesional. Define temas explícitos
/// /// para widgets comunes como AppBar, Card, ElevatedButton y TextFormField
/// /// para garantizar la consistencia visual en toda la aplicación.
/// ---
class AppTheme {
  // --- TEMA CLARO ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.accentLight,
      surface: AppColors.cardLight,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.fontTitleLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.fontTitleLight),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.fontTitleLight,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      color: AppColors.cardLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: AppColors.primaryLight.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.fontSubtitleLight),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold, color: AppColors.fontTitleLight),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: AppColors.fontTitleLight),
      bodyMedium: TextStyle(color: AppColors.fontBodyLight, height: 1.5),
      labelSmall: TextStyle(color: AppColors.fontSubtitleLight),
    ),
  );

  // --- TEMA OSCURO --- (Añadiremos esto más adelante para enfocarnos primero en el claro)
  static final ThemeData darkTheme = lightTheme; // Temporal
}