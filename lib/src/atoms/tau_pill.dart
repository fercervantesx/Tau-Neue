import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE pill badge component.
///
/// Non-interactive informational badge for displaying status, stats, or labels.
/// Rounded pill-shaped badge that can display text, icons, or both.
/// Pills can be composed horizontally using TauPillGroup.
///
/// **Difference from Pill Button:**
/// - **TauPill**: Non-interactive badge/label (no onPressed callback)
///   - Used for: Status indicators, stats displays, informational labels
///   - Example: "O2", "HEALTH 75%", "RANK 2"
/// - **Pill Button**: Interactive TauButton with `isPill: true`
///   - Used for: Clickable actions with rounded button appearance
///   - Example: "PURCHASE", "CONTINUE", "CLOSE"
///
/// Example:
/// ```dart
/// TauPill(
///   label: 'O2',
///   icon: Icon(Icons.circle, size: 12),
///   backgroundColor: colors.accentPrimary,
/// )
/// ```
class TauPill extends StatelessWidget {
  const TauPill({
    super.key,
    this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height = 32.0,
    this.padding,
    this.progress,
  }) : assert(label != null || icon != null, 'Either label or icon must be provided'),
       assert(progress == null || (progress >= 0.0 && progress <= 1.0), 'Progress must be between 0.0 and 1.0');

  /// Text label for the pill.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Background color of the pill.
  final Color? backgroundColor;

  /// Text and icon color.
  final Color? textColor;

  /// Height of the pill.
  final double height;

  /// Custom padding (defaults to horizontal: 12, vertical: 6).
  final EdgeInsetsGeometry? padding;

  /// Optional progress value from 0.0 to 1.0.
  /// When provided, shows filled portion in full color and remaining portion darker.
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final effectiveBackgroundColor = backgroundColor ?? colors.accentSecondary;
    final effectiveTextColor = textColor ?? colors.textOnDark;
    final effectiveProgress = progress ?? 1.0;

    // Darker version of background for unfilled portion
    final darkerBackgroundColor = Color.lerp(effectiveBackgroundColor, const Color(0xFF000000), 0.6)!;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: effectiveTextColor,
              size: height * 0.5,
            ),
            child: icon!,
          ),
          if (label != null) SizedBox(width: spacing.spacingMicro),
        ],
        if (label != null)
          Text(
            label!,
            style: typography.labelMono.copyWith(
              color: effectiveTextColor,
              fontSize: height * 0.375,
              height: 1.0,
            ),
          ),
      ],
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          // Darker background (unfilled portion)
          Container(
            height: height,
            padding: padding ?? EdgeInsets.symmetric(
              horizontal: spacing.spacingBase + spacing.spacingMicro,
              vertical: spacing.spacingMicro + 2,
            ),
            decoration: BoxDecoration(
              color: darkerBackgroundColor,
            ),
            child: content,
          ),
          // Filled portion (progress)
          if (effectiveProgress < 1.0)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: effectiveProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectiveBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          // Content on top (for text visibility)
          Container(
            height: height,
            padding: padding ?? EdgeInsets.symmetric(
              horizontal: spacing.spacingBase + spacing.spacingMicro,
              vertical: spacing.spacingMicro + 2,
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}

/// Container for composing multiple TauPill widgets horizontally.
///
/// Pills are connected together to form a single segmented pill.
/// Only the leftmost pill has left border radius, only the rightmost has right border radius.
///
/// Example:
/// ```dart
/// TauPillGroup(
///   height: 32.0,
///   segments: [
///     TauPillSegment(label: 'O2', icon: Icon(Icons.circle), backgroundColor: colors.accentPrimary),
///     TauPillSegment(label: 'I', backgroundColor: colors.accentSecondary),
///     TauPillSegment(label: '#10/140', backgroundColor: colors.surfaceHighlight),
///   ],
/// )
/// ```
class TauPillGroup extends StatelessWidget {
  const TauPillGroup({
    super.key,
    required this.segments,
    this.height = 32.0,
    this.gap = 0.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  /// List of pill segments to display.
  final List<TauPillSegment> segments;

  /// Height of all segments.
  final double height;

  /// Gap between segments in pixels (default: 0.0 for connected segments).
  final double gap;

  /// Horizontal alignment of pill group.
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final List<Widget> children = [];

    for (int index = 0; index < segments.length; index++) {
      final segment = segments[index];
      final isFirst = index == 0;
      final isLast = index == segments.length - 1;
      final effectiveProgress = segment.progress ?? 1.0;

      // Darker version of background for unfilled portion
      final darkerBackgroundColor = Color.lerp(segment.backgroundColor, const Color(0xFF000000), 0.6)!;

      // When there's a gap, round both sides; otherwise only round edges
      final borderRadius = gap > 0
          ? BorderRadius.circular(height / 2)
          : BorderRadius.only(
              topLeft: isFirst ? Radius.circular(height / 2) : Radius.zero,
              bottomLeft: isFirst ? Radius.circular(height / 2) : Radius.zero,
              topRight: isLast ? Radius.circular(height / 2) : Radius.zero,
              bottomRight: isLast ? Radius.circular(height / 2) : Radius.zero,
            );

      final content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (segment.icon != null) ...[
            IconTheme(
              data: IconThemeData(
                color: segment.textColor,
                size: height * 0.5,
              ),
              child: segment.icon!,
            ),
            if (segment.label != null) SizedBox(width: spacing.spacingMicro),
          ],
          if (segment.label != null)
            Text(
              segment.label!,
              style: typography.labelMono.copyWith(
                color: segment.textColor,
                fontSize: height * 0.375,
                height: 1.0,
              ),
            ),
        ],
      );

      children.add(
        ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              // Darker background (unfilled portion)
              Container(
                height: height,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.spacingBase + spacing.spacingMicro,
                  vertical: spacing.spacingMicro + 2,
                ),
                decoration: BoxDecoration(
                  color: darkerBackgroundColor,
                ),
                child: content,
              ),
              // Filled portion (progress)
              if (effectiveProgress < 1.0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: effectiveProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: segment.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              // Content on top (for text visibility)
              Container(
                height: height,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.spacingBase + spacing.spacingMicro,
                  vertical: spacing.spacingMicro + 2,
                ),
                child: content,
              ),
            ],
          ),
        ),
      );

      // Add gap between segments (but not after the last one)
      if (gap > 0 && !isLast) {
        children.add(SizedBox(width: gap));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}

/// A segment within a TauPillGroup.
class TauPillSegment {
  const TauPillSegment({
    this.label,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    this.progress,
  }) : assert(label != null || icon != null, 'Either label or icon must be provided'),
       assert(progress == null || (progress >= 0.0 && progress <= 1.0), 'Progress must be between 0.0 and 1.0');

  /// Text label for the segment.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Background color of the segment.
  final Color backgroundColor;

  /// Text and icon color.
  final Color textColor;

  /// Optional progress value from 0.0 to 1.0.
  final double? progress;
}
