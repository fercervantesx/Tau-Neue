import 'package:flutter/material.dart';
import '../tokens/tau_color_tokens.dart';
import '../tokens/tau_spacing_tokens.dart';
import '../tokens/tau_typography_tokens.dart';
import '../tokens/tau_motion_tokens.dart';

/// TAU NEUE theme factory and accessor utilities.
///
/// Provides strongly-typed theme construction and convenient
/// accessor methods for design tokens.
class TauTheme {
  TauTheme._();

  /// Builds a complete ThemeData with TAU NEUE design tokens.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   theme: TauTheme.buildTheme(
  ///     colorTokens: TauColorTokens.standard,
  ///     typographyTokens: TauTypographyTokens.standard,
  ///   ),
  /// );
  /// ```
  static ThemeData buildTheme({
    required TauColorTokens colorTokens,
    TauSpacingTokens spacingTokens = TauSpacingTokens.standard,
    TauTypographyTokens? typographyTokens,
    TauMotionTokens motionTokens = TauMotionTokens.standard,
  }) {
    final typography = typographyTokens ?? TauTypographyTokens.standard;
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: colorTokens.surfaceBase,
      colorScheme: ColorScheme.dark(
        surface: colorTokens.surfaceBase,
        primary: colorTokens.accentPrimary,
        error: colorTokens.accentCritical,
      ),
      textTheme: TextTheme(
        displayLarge: typography.titleSerif.copyWith(
          color: colorTokens.textOnDark,
        ),
        displayMedium: typography.headingSerif.copyWith(
          color: colorTokens.textOnDark,
        ),
        bodyLarge: typography.bodyMono.copyWith(
          color: colorTokens.textOnDark,
        ),
        bodyMedium: typography.dataMono.copyWith(
          color: colorTokens.textMuted,
        ),
      ),
      extensions: [
        colorTokens,
        spacingTokens,
        typography,
        motionTokens,
      ],
    );
  }

  /// Convenience accessor for TauColorTokens from BuildContext.
  static TauColorTokens colorsOf(BuildContext context) {
    return Theme.of(context).extension<TauColorTokens>() ??
        TauColorTokens.standard;
  }

  /// Convenience accessor for TauSpacingTokens from BuildContext.
  static TauSpacingTokens spacingOf(BuildContext context) {
    return Theme.of(context).extension<TauSpacingTokens>() ??
        TauSpacingTokens.standard;
  }

  /// Convenience accessor for TauTypographyTokens from BuildContext.
  static TauTypographyTokens typographyOf(BuildContext context) {
    return Theme.of(context).extension<TauTypographyTokens>() ??
        TauTypographyTokens.standard;
  }

  /// Convenience accessor for TauMotionTokens from BuildContext.
  static TauMotionTokens motionOf(BuildContext context) {
    return Theme.of(context).extension<TauMotionTokens>() ??
        TauMotionTokens.standard;
  }
}
