import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Cairo", // تقدر تغير للخط اللي يناسبك
  primaryColor: const Color(0xFFD32F2F), // أحمر
  scaffoldBackgroundColor: Colors.grey[100], // خلفية خفيفة
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFD32F2F), // اللون الأساسي الأحمر
    primary: const Color(0xFFD32F2F), // أحمر
    secondary: const Color(0xFF1976D2), // أزرق فاتح
    tertiary: const Color(0xFFFFC107), // ذهبي
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.black,
    onBackground: Colors.black87,
    onSurface: Colors.black87,
  ),
  
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFD32F2F), // الأحمر للأزرار الأساسية
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1976D2), // الأزرق
      side: const BorderSide(color: Color(0xFF1976D2)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Colors.black45),
  ),
);
