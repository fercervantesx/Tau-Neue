import 'package:flutter/material.dart';

/// TAU NEUE tactical terminal color token system.
///
/// Vibrant neon palette with chartreuse, hot pink, blue, and orange on black.
class TauColorTokens extends ThemeExtension<TauColorTokens> {
  const TauColorTokens({
    required this.accentPrimary,
    required this.accentSecondary,
    required this.accentCritical,
    required this.accentInfo,
    required this.surfaceBase,
    required this.surfaceElevated,
    required this.surfaceHighlight,
    required this.textOnDark,
    required this.textOnAccent,
    required this.textMuted,
    required this.borderSubtle,
    required this.borderAccent,
  });

  /// Neon chartreuse for active/primary states (buttons, headers, highlights).
  final Color accentPrimary;

  /// Hot pink for secondary/alternate states (tabs, alternate buttons).
  final Color accentSecondary;

  /// Bright orange for errors, warnings, destructive actions.
  final Color accentCritical;

  /// Electric blue for informational states, links, notifications.
  final Color accentInfo;

  /// Pure black for base surfaces (cards, panels).
  final Color surfaceBase;

  /// Slightly lighter black for elevated surfaces.
  final Color surfaceElevated;

  /// Neon chartreuse for highlighted surfaces (active card headers).
  final Color surfaceHighlight;

  /// White/light text on dark backgrounds.
  final Color textOnDark;

  /// Black text on neon backgrounds (chartreuse, pink, orange).
  final Color textOnAccent;

  /// Grey text for muted/secondary information.
  final Color textMuted;

  /// Dark grey borders for subtle panel separations.
  final Color borderSubtle;

  /// Lime green borders for active/accent elements.
  final Color borderAccent;

  /// Standard theme: neon colors on black with vibrant accents.
  static const TauColorTokens standard = TauColorTokens(
    accentPrimary: Color(0xFFC0FC04),       // Neon chartreuse (#c0fc04)
    accentSecondary: Color(0xFFEA027E),     // Hot pink (#ea027e)
    accentCritical: Color(0xFFFF5500),      // Bright orange (#ff5500)
    accentInfo: Color(0xFF3601FB),          // Electric blue (#3601fb)
    surfaceBase: Color(0xFF000000),         // Pure black (#000000)
    surfaceElevated: Color(0xFF1A1A1A),     // Slightly lighter black
    surfaceHighlight: Color(0xFFC0FC04),    // Neon chartreuse (#c0fc04)
    textOnDark: Color(0xFFFFFFFF),          // White
    textOnAccent: Color(0xFF000000),        // Black
    textMuted: Color(0xFF8E8E8E),           // Grey
    borderSubtle: Color(0xFF2A2A2A),        // Dark grey
    borderAccent: Color(0xFFC0FC04),        // Neon chartreuse (#c0fc04)
  );

  @override
  TauColorTokens copyWith({
    Color? accentPrimary,
    Color? accentSecondary,
    Color? accentCritical,
    Color? accentInfo,
    Color? surfaceBase,
    Color? surfaceElevated,
    Color? surfaceHighlight,
    Color? textOnDark,
    Color? textOnAccent,
    Color? textMuted,
    Color? borderSubtle,
    Color? borderAccent,
  }) {
    return TauColorTokens(
      accentPrimary: accentPrimary ?? this.accentPrimary,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      accentCritical: accentCritical ?? this.accentCritical,
      accentInfo: accentInfo ?? this.accentInfo,
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      textOnDark: textOnDark ?? this.textOnDark,
      textOnAccent: textOnAccent ?? this.textOnAccent,
      textMuted: textMuted ?? this.textMuted,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderAccent: borderAccent ?? this.borderAccent,
    );
  }

  @override
  TauColorTokens lerp(ThemeExtension<TauColorTokens>? other, double t) {
    if (other is! TauColorTokens) {
      return this;
    }
    return TauColorTokens(
      accentPrimary: Color.lerp(accentPrimary, other.accentPrimary, t)!,
      accentSecondary: Color.lerp(accentSecondary, other.accentSecondary, t)!,
      accentCritical: Color.lerp(accentCritical, other.accentCritical, t)!,
      accentInfo: Color.lerp(accentInfo, other.accentInfo, t)!,
      surfaceBase: Color.lerp(surfaceBase, other.surfaceBase, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceHighlight: Color.lerp(surfaceHighlight, other.surfaceHighlight, t)!,
      textOnDark: Color.lerp(textOnDark, other.textOnDark, t)!,
      textOnAccent: Color.lerp(textOnAccent, other.textOnAccent, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderAccent: Color.lerp(borderAccent, other.borderAccent, t)!,
    );
  }
}
