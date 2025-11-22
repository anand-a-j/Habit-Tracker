import 'package:flutter/material.dart';

mixin AppColorScheme {
  // static const Color primary = Color(0XFF33C75A); //  Green
  static const Color primary = Color(0XFF6FBF73); // Muted Sage Green
  static const Color onPrimary = Color(0XFFFFFFFF); //  Pure White

  static const Color secondary = Color(0XFF000000); // Pure Black
  static const Color secondaryContainer = Color(0XFF252527); // Grey variant
  static const Color secondaryFixed = Color(0xff18181b); // black varaint

  static const Color onSecondary = Color(0XFF0F0F0F); // Black variant
  static const Color onSecondaryContainer =
      Color(0XFF3D3D3D); // for border stoke

  static const Color error = Color(0XFFdc2b31); // Red
  static const Color errorContainer = Color(0XFF7A1E0C); // dark red

  static const Color surface = Color(0XFFB0B0B0);

  static const Color scaffoldBackgroundColor = Color(0XFF000000); // Pure Black

  static const Color primaryTouchEffect = Color(0XFF56d276);

  /// Preset colors for habit selection (used in habit creation UI)
  static const List<Color> habitColorOptions = [
    // Greens & Teals
    Color(0xFF6FBF73), // Fresh Mint Green
    Color(0xFF81C784), // Soft Green
    Color(0xFF388E3C), // Forest Green
    Color(0xFF2E7D32), // Deep Nature Green

    // Blues & Purples
    Color(0xFF64B5F6), // Sky Blue
    Color(0xFF1976D2), // Calm Blue
    Color(0xFF1565C0), // Deep Ocean Blue
    Color(0xFF90CAF9), // Light Steel Blue

    // Pinks & Reds
    Color(0xFF9575CD), // Soft Purple
    Color(0xFF7E57C2), // Muted Purple
    Color(0xFF673AB7), // Deep Purple
    Color(0xFFB39DDB), // Pastel Violet

    // Yellows & Oranges
    Color(0xFFFFB74D), // Muted Orange
    Color(0xFFFFA726), // Warm Orange
    Color(0xFFFFD54F), // Soft Yellow
    Color(0xFFFBC02D), // Golden Yellow
    // Neutrals
    Color(0xFF9E9E9E), // Medium Grey

    Color(0xFF616161), // Deep Grey
  ];
}
