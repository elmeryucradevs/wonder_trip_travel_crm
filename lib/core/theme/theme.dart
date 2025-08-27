import 'package:flutter/material.dart';

/// ---
/// /// [AppTheme] define el sistema de diseño visual para la aplicación "Wonder Trip Travel".
/// ///
/// /// Proporciona dos temas: [lightTheme] y [darkTheme], que aseguran una
/// /// apariencia consistente y profesional. La paleta de colores ha sido elegida
/// /// para evocar una sensación de elegancia y confianza, propia de una agencia de
/// /// viajes premium.
/// ///
/// /// Los colores primarios y de acento se utilizan para guiar la atención del
/// /// usuario hacia las acciones más importantes.
/// ---
class AppTheme {
  // --- Paleta de Colores ---
  static const Color primaryColor = Color(0xFF0D47A1); // Un azul profundo y profesional
  static const Color accentColor = Color(0xFFFFA000); // Un ámbar vibrante para acciones
  static const Color backgroundColorLight = Color(0xFFF5F5F5); // Un gris muy claro
  static const Color cardColorLight = Colors.white;

  static const Color backgroundColorDark = Color(0xFF121212); // Negro estándar para modo oscuro
  static const Color cardColorDark = Color(0xFF1E1E1E); // Un gris oscuro para superficies
  static const Color primaryColorDark = Color(0xFF42A5F5); // Un azul más claro para contraste en oscuro

  /// ---
  /// /// [lightTheme]: El [ThemeData] para el modo claro de la aplicación.
  /// ///
  /// /// Configura los colores, la tipografía y los estilos de widgets para
  /// /// una interfaz de usuario clara y legible durante el día.
  /// ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      background: backgroundColorLight,
      surface: cardColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColorLight,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: primaryColor),
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),
  );

  /// ---
  /// /// [darkTheme]: El [ThemeData] para el modo oscuro de la aplicación.
  /// ///
  /// /// Optimizado para condiciones de baja luz, reduce la fatiga visual y ahorra
  /// /// batería en pantallas OLED. Mantiene la misma jerarquía visual que el tema claro.
  /// ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryColorDark,
      secondary: accentColor,
      background: backgroundColorDark,
      surface: cardColorDark,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardColorDark,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColorDark,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: primaryColorDark),
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),
  );
}