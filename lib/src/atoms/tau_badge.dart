import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE badge component.
///
/// Simple rectangular badge with minimal padding for counts and labels.
/// Perfect for use alongside text elements like "Notes(3)" or status indicators.
///
/// Example:
/// ```dart
/// Row(
///   children: [
///     Text('NOTES'),
///     SizedBox(width: 4),
///     TauBadge(label: '3'),
///   ],
/// )
/// ```
class TauBadge extends StatelessWidget {
  const TauBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius = 4.0,
  });

  /// Text label to display in the badge.
  final String label;

  /// Background color of the badge (defaults to accentPrimary).
  final Color? backgroundColor;

  /// Text color (defaults to textOnAccent for contrast).
  final Color? textColor;

  /// Custom padding (defaults to horizontal: 6, vertical: 2).
  final EdgeInsetsGeometry? padding;

  /// Border radius (defaults to 4.0 for subtle rounding).
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final effectiveBackgroundColor = backgroundColor ?? colors.accentPrimary;
    final effectiveTextColor = textColor ?? colors.textOnAccent;
    final effectivePadding = padding ?? EdgeInsets.symmetric(
      horizontal: spacing.spacingMicro + 2,
      vertical: 2.0,
    );

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        label,
        style: typography.labelMono.copyWith(
          color: effectiveTextColor,
          fontSize: 10.0,
          height: 1.0,
        ),
      ),
    );
  }
}

/// TAU NEUE decal component.
///
/// Non-interactive decorative element for visual flair.
/// Similar to badge but optimized for larger graphics.
class TauDecal extends StatelessWidget {
  const TauDecal({
    super.key,
    required this.child,
    this.width = 48.0,
    this.height = 48.0,
    this.opacity = 1.0,
  });

  final Widget child;
  final double width;
  final double height;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
