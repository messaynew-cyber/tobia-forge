import 'package:flutter/material.dart';

/// TOBIA FORGE 2.0 — 2026 design canon.
/// Dark-with-depth, glassmorphism 2.0, kinetic type, micro-interaction physics.
class ForgeColors {
  // Base dark layers — DEPTH, not flat black
  static const Color bg0 = Color(0xFF07070A);   // deepest
  static const Color bg1 = Color(0xFF0D0D12);  // surface step 1
  static const Color bg2 = Color(0xFF13131A);  // surface step 2
  static const Color bg3 = Color(0xFF1A1A23);  // raised

  // Glass 2.0 tints
  static const Color glass = Color(0x1FFFFFFF);      // 12% white base
  static const Color glassBorder = Color(0x26FFFFFF); // 15% white hairline
  static const Color glassHighlight = Color(0x3DFFFFFF); // 24% white top edge

  // Brand — saturated strategic accents
  static const Color gold = Color(0xFFF2C14E);
  static const Color goldBright = Color(0xFFFFD97A);
  static const Color goldDeep = Color(0xFFB07D2A);
  static const Color emerald = Color(0xFF3BE38B);
  static const Color emeraldDeep = Color(0xFF1E9E5F);
  static const Color crimson = Color(0xFFFF5A63);
  static const Color sky = Color(0xFF58A6FF);

  static const Color text = Color(0xFFF0EEE8);
  static const Color textSoft = Color(0xFFB8B5AE);
  static const Color muted = Color(0xFF8A8680);
  static const Color faint = Color(0xFF5A5752);
}

/// Motion system — every interaction is physics-based (springs, not tween-only).
class ForgeMotion {
  /// Bouncy, tactile press. For cards, buttons, tappable tiles.
  static const SpringDescription press = SpringDescription(
    mass: 1.2, stiffness: 620, damping: 34,
  );
  /// Proud, celebratory entrance.
  static const SpringDescription enter = SpringDescription(
    mass: 0.8, stiffness: 300, damping: 26,
  );
  /// Calm, premium settle for larger panels.
  static const SpringDescription settle = SpringDescription(
    mass: 1.0, stiffness: 230, damping: 30,
  );
}

ThemeData buildForgeTheme() {
  final base = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: ForgeColors.gold,
      secondary: ForgeColors.emerald,
      surface: ForgeColors.bg1,
      error: ForgeColors.crimson,
    ),
    scaffoldBackgroundColor: ForgeColors.bg0,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: ForgeColors.text,
      displayColor: ForgeColors.text,
    ),
    splashFactory: InkRipple.splashFactory,
  );
}

/// Typography scale — kinetic-friendly (tracks style), editorial mix.
class ForgeType {
  /// Big kinetic hero — letterspaced, weight-shifted display.
  static TextStyle hero(double size, {Color? color}) => TextStyle(
    fontFamily: 'sans-serif',
    fontSize: size,
    fontWeight: FontWeight.w800,
    height: 0.98,
    letterSpacing: -1.2,
    color: color ?? ForgeColors.text,
  );
  /// Serif display accent (the sculptural moments).
  static TextStyle serif(double size, {Color? color}) => TextStyle(
    fontFamily: 'serif',
    fontSize: size,
    fontWeight: FontWeight.w600,
    height: 1.05,
    letterSpacing: 0.2,
    color: color ?? ForgeColors.goldBright,
  );
  /// Ultra-tracked kicker / label.
  static TextStyle kicker({Color? color, double size = 11}) => TextStyle(
    fontFamily: 'monospace',
    fontSize: size,
    letterSpacing: 3.4,
    fontWeight: FontWeight.w600,
    color: color ?? ForgeColors.muted,
  );
  /// Data / mono readout.
  static TextStyle mono(double size, {Color? color, double spacing = 1.4}) =>
    TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      letterSpacing: spacing,
      fontWeight: FontWeight.w600,
      color: color ?? ForgeColors.text,
    );
  /// Soft body text.
  static TextStyle body({Color? color, double size = 14}) => TextStyle(
    fontFamily: 'sans-serif',
    fontSize: size,
    height: 1.5,
    color: color ?? ForgeColors.textSoft,
  );
}
