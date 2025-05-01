import 'package:flutter/material.dart';

class CAMPtoGoColors {
  // Primary colors
  static const Color primaryGreen = Color(0xFF3B5249);
  static const Color secondaryGreen = Color(0xFF4A6855);
  static const Color lightGreen = Color(0xFF6B8A76);

  // Neutral colors
  static const Color white = Colors.white;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xFF757575);
  static const Color black = Colors.black;

  // Additional colors
  static const Color background = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);

  // Create theme color scheme
  static ColorScheme get colorScheme => const ColorScheme(
    primary: primaryGreen,
    primaryContainer: secondaryGreen,
    secondary: lightGreen,
    secondaryContainer: lightGreen,
    surface: white,
    background: background,
    error: error,
    onPrimary: white,
    onSecondary: white,
    onSurface: black,
    onBackground: black,
    onError: white,
    brightness: Brightness.light,
  );

  // Dark theme color scheme
  static ColorScheme get darkColorScheme => const ColorScheme(
    primary: primaryGreen,
    primaryContainer: secondaryGreen,
    secondary: lightGreen,
    secondaryContainer: lightGreen,
    surface: Color(0xFF121212),
    background: Color(0xFF121212),
    error: error,
    onPrimary: white,
    onSecondary: white,
    onSurface: white,
    onBackground: white,
    onError: white,
    brightness: Brightness.dark,
  );
}

// Example usage in your MaterialApp
ThemeData buildLightTheme() {
  return ThemeData(
    fontFamily: 'Arial',
    colorScheme: CAMPtoGoColors.colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: CAMPtoGoColors.primaryGreen,
      foregroundColor: CAMPtoGoColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CAMPtoGoColors.primaryGreen,
        foregroundColor: CAMPtoGoColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CAMPtoGoColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: CAMPtoGoColors.primaryGreen),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: CAMPtoGoColors.primaryGreen),
    ),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    colorScheme: CAMPtoGoColors.darkColorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: CAMPtoGoColors.primaryGreen,
      foregroundColor: CAMPtoGoColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CAMPtoGoColors.primaryGreen,
        foregroundColor: CAMPtoGoColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: CAMPtoGoColors.primaryGreen),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: CAMPtoGoColors.lightGreen),
    ),
  );
}

// Usage example in your main.dart:
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPtoGo',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const LoginScreen(),
    );
  }
}
*/
