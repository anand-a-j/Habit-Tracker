import 'package:flutter/material.dart';

mixin AppColorScheme {
  // static const Color primary = Color(0XFF33C75A); //  Green
  static const Color primary = Color(0XFF44d62c); // Muted Sage Green
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

  static const Color premiumPrimary = Color(0XFFFECD04);
  static const Color premiumOnPrimary = Color(0XFF8A4001);

  /// Preset colors for habit selection (used in habit creation UI)
  static const List<Color> habitColorOptions = [
    // --- WARM HUES: REDS, PINKS, & MAGENTAS (5) ---
    // Energy, Action, Passion. Ordered from Red to Pink/Violet.
    Color(0xFFFF5252), // 1. Vibrant Red
    Color(0xFFFF6D00), // 2. Deep Sunset Orange (Transition to Orange)
    Color(0xFFF50057), // 3. Deep Hot Pink
    Color(0xFFE040FB), // 4. Bright Magenta
    Color(0xFF7C4DFF), // 5. Electric Violet (Transition to Purple)

    // --- PURPLES & LAVENDERS (3) ---
    // Focus, Creativity, Calm.
    Color(0xFF651FFF), // 6. Deep Purple Punch
    Color(0xFF9C27B0), // 7. Strong Purple
    Color(0xFFD1C4E9), // 8. Light Lavender (Soft touch)

    // --- COOL HUES: BLUES & CYANS (5) ---
    // Calm, Logic, Focus. Ordered from Deep to Bright.
    Color(0xFF2962FF), // 9. Deep Electric Blue
    Color(0xFF448AFF), // 10. Electric Blue
    Color(0xFF03A9F4), // 11. Vibrant Sky Blue
    Color(0xFF00BCD4), // 12. Aqua
    Color(0xFF18FFFF), // 13. Super Bright Cyan

    // --- EARTH & GROWTH: GREENS & TEALS (6) ---
    // Health, Growth, Balance. Ordered from Dark Teal to Neon.
    Color(0xFF26A69A), // 14. Strong Teal
    Color(0xFF00B8D4), // 15. Bright Teal
    Color(0xFF4CAF50), // 16. Standard Bright Green
    Color(0xFF8BC34A), // 17. Lime Green
    Color(0xFF69F0AE), // 18. Mint Green
    Color(0xFF00FF7F), // 19. Spring Green (Neon)

    // --- WARM ACCENTS: YELLOWS & ORANGES (4) ---
    // Alertness, Energy, Creativity. Ordered from Dark to Light.
    Color(0xFFFF9800), // 20. True Orange
    Color(0xFFFFC107), // 21. Vibrant Gold
    Color(0xFFFFEA00), // 22. Electric Yellow

    // --- NEUTRAL ACCENT (1) ---
    // For tasks that don't need a mood assigned.
    Color(0xFFCD9A9D), // 23. Dusty Rose (A soft, near-neutral accent)

    // --- SOFT BLUE ACCENT (1) ---
    // Soft, calming default.
    Color(0xFF9FA8DA), // 24. Lavender Blue (Softer touch)
  ];
}
