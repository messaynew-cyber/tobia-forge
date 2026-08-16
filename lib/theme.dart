import 'package:flutter/material.dart';

/// TOBIA — THE FORGE design tokens.
/// OLED-black canvas, molten gold + emerald accents, Cinzel-display / mono-data.
class ForgeColors {
  static const Color oled = Color(0xFF000000);
  static const Color panel = Color(0xFF0A0A0F);
  static const Color panel2 = Color(0xFF0D0D14);
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldBright = Color(0xFFF0C94A);
  static const Color goldDim = Color(0xFF8A7420);
  static const Color green = Color(0xFF2EE66A);
  static const Color greenDim = Color(0xFF1A8F45);
  static const Color red = Color(0xFFFF4D4D);
  static const Color text = Color(0xFFE8E6DF);
  static const Color muted = Color(0xFF8A8790);
  static const Color hairline = Color(0x2ED4AF37); // 18% gold
}

/// Emil-grade custom easing — Flutter's curve builder cannot use CSS cubic-bezier,
/// so we use known-good eased curves for entrance + press feedback.
class ForgeCurves {
  // Fast entrance, decelerate hard (easeOutCubic-ish feel)
  static const Curve easeOut = Curves.easeOutCubic;
  // Slight overshoot for celebratory motion
  static const Curve spring = Curves.easeOutBack;
}

ThemeData buildForgeTheme() {
  final base = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ForgeColors.oled,
    colorScheme: const ColorScheme.dark(
      primary: ForgeColors.gold,
      secondary: ForgeColors.green,
      surface: ForgeColors.panel,
      error: ForgeColors.red,
    ),
    fontFamily: 'sans-serif',
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: ForgeColors.text,
      displayColor: ForgeColors.text,
    ),
    cardTheme: CardTheme(
      color: ForgeColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: ForgeColors.hairline),
      ),
      elevation: 0,
    ),
    dividerColor: ForgeColors.hairline,
  );
}

/// Flutter type scale helpers (self-contained, no Theme inits at import time).
class ForgeType {
  static TextStyle serifDisplay(double size, {Color? color}) => TextStyle(
        fontFamily: 'serif',
        fontSize: size,
        fontWeight: FontWeight.w600,
        height: 1.08,
        letterSpacing: 0.4,
        color: color ?? ForgeColors.text,
      );
  static TextStyle mono(double size, {Color? color, double? spacing}) => TextStyle(
        fontFamily: 'monospace',
        fontSize: size,
        letterSpacing: spacing ?? 1.2,
        color: color ?? ForgeColors.muted,
      );
  static TextStyle label() => const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        letterSpacing: 2.8,
        color: ForgeColors.gold,
      );
}
