import 'package:flutter/material.dart';

/// TAU NEUE spacing token system.
///
/// Adheres to strict 8-pixel base unit system with 4-pixel sub-grid
/// for high-density typographic clustering and micro-alignments.
class TauSpacingTokens extends ThemeExtension<TauSpacingTokens> {
  const TauSpacingTokens({
    required this.spacingMicro,
    required this.spacingBase,
    required this.spacingMacro,
    required this.strokeWeightBase,
  });

  /// Inner element padding, monospace data clustering (4px).
  final double spacingMicro;

  /// Standard component padding, internal list tile separation (8px).
  final double spacingBase;

  /// Major section divisions, architectural negative space (32px).
  final double spacingMacro;

  /// Default thickness for boundaries and lines (1px for tactical aesthetic).
  final double strokeWeightBase;

  /// Default spacing configuration following 8-pixel grid system.
  static const TauSpacingTokens standard = TauSpacingTokens(
    spacingMicro: 4.0,
    spacingBase: 8.0,
    spacingMacro: 32.0,
    strokeWeightBase: 1.0,
  );

  @override
  TauSpacingTokens copyWith({
    double? spacingMicro,
    double? spacingBase,
    double? spacingMacro,
    double? strokeWeightBase,
  }) {
    return TauSpacingTokens(
      spacingMicro: spacingMicro ?? this.spacingMicro,
      spacingBase: spacingBase ?? this.spacingBase,
      spacingMacro: spacingMacro ?? this.spacingMacro,
      strokeWeightBase: strokeWeightBase ?? this.strokeWeightBase,
    );
  }

  @override
  TauSpacingTokens lerp(ThemeExtension<TauSpacingTokens>? other, double t) {
    if (other is! TauSpacingTokens) {
      return this;
    }
    return TauSpacingTokens(
      spacingMicro: _lerpDouble(spacingMicro, other.spacingMicro, t),
      spacingBase: _lerpDouble(spacingBase, other.spacingBase, t),
      spacingMacro: _lerpDouble(spacingMacro, other.spacingMacro, t),
      strokeWeightBase:
          _lerpDouble(strokeWeightBase, other.strokeWeightBase, t),
    );
  }

  /// Helper to linearly interpolate double values.
  static double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
