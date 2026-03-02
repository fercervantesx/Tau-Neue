import 'dart:math' show sin;

import 'package:flutter/material.dart';

/// TAU NEUE motion token system.
///
/// Mechanical reactivity with 0-200ms duration window.
/// Sudden acceleration followed by sharp deceleration.
class TauMotionTokens extends ThemeExtension<TauMotionTokens> {
  const TauMotionTokens({
    required this.snapInstant,
    required this.snapMechanical,
    required this.glitchFrequency,
  });

  /// Instant feedback for hover, press, tooltip (50ms, linear).
  final Duration snapInstant;

  /// Modal snapping, route transitions, drawer slides (150ms, easeOutExpo).
  final Duration snapMechanical;

  /// Error states, critical notifications, transaction completion (100ms).
  final Duration glitchFrequency;

  /// Default motion configuration.
  static const TauMotionTokens standard = TauMotionTokens(
    snapInstant: Duration(milliseconds: 50),
    snapMechanical: Duration(milliseconds: 150),
    glitchFrequency: Duration(milliseconds: 100),
  );

  @override
  TauMotionTokens copyWith({
    Duration? snapInstant,
    Duration? snapMechanical,
    Duration? glitchFrequency,
  }) {
    return TauMotionTokens(
      snapInstant: snapInstant ?? this.snapInstant,
      snapMechanical: snapMechanical ?? this.snapMechanical,
      glitchFrequency: glitchFrequency ?? this.glitchFrequency,
    );
  }

  @override
  TauMotionTokens lerp(ThemeExtension<TauMotionTokens>? other, double t) {
    if (other is! TauMotionTokens) {
      return this;
    }
    return TauMotionTokens(
      snapInstant: _lerpDuration(snapInstant, other.snapInstant, t),
      snapMechanical: _lerpDuration(snapMechanical, other.snapMechanical, t),
      glitchFrequency: _lerpDuration(glitchFrequency, other.glitchFrequency, t),
    );
  }

  Duration _lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      microseconds:
          (a.inMicroseconds + (b.inMicroseconds - a.inMicroseconds) * t)
              .round(),
    );
  }
}

/// Custom easing curves for TAU NEUE motion language.
class TauCurves {
  TauCurves._();

  /// Sharp mechanical deceleration (easeOutExpo approximation).
  static const Curve mechanical = Curves.easeOutExpo;

  /// Instant linear motion for immediate feedback.
  static const Curve instant = Curves.linear;

  /// Custom oscillating curve for glitch effects.
  static const Curve glitch = _GlitchCurve();
}

/// Custom oscillating curve for glitch effects.
class _GlitchCurve extends Curve {
  const _GlitchCurve();

  @override
  double transformInternal(double t) {
    // Oscillating sine wave with decay
    return (1.0 - t) * (0.5 + 0.5 * sin(t * 10.0));
  }
}
