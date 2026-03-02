import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE alert component with tactical terminal aesthetic.
///
/// Inline notification message with variant-based styling.
/// Supports info, success, warning, and error states.
///
/// Example:
/// ```dart
/// TauAlert(
///   variant: TauAlertVariant.success,
///   title: 'MISSION COMPLETE',
///   message: 'All objectives achieved.',
/// )
/// ```
class TauAlert extends StatelessWidget {
  const TauAlert({
    super.key,
    required this.variant,
    this.title,
    required this.message,
    this.icon,
    this.onClose,
    this.showIcon = true,
  }) : assert(title != null || message != '', 'Either title or message must be provided');

  /// Alert variant for color coding.
  final TauAlertVariant variant;

  /// Optional title text (bold).
  final String? title;

  /// Message text.
  final String message;

  /// Optional custom icon (overrides default variant icon).
  final Widget? icon;

  /// Optional close callback (shows close button if provided).
  final VoidCallback? onClose;

  /// Whether to show the variant icon.
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Determine colors based on variant
    Color backgroundColor;
    Color borderColor;
    Color iconColor;

    switch (variant) {
      case TauAlertVariant.info:
        backgroundColor = Color.lerp(colors.accentInfo, colors.surfaceBase, 0.9)!;
        borderColor = colors.accentInfo;
        iconColor = colors.accentInfo;
        break;
      case TauAlertVariant.success:
        backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.9)!;
        borderColor = colors.accentPrimary;
        iconColor = colors.accentPrimary;
        break;
      case TauAlertVariant.warning:
        backgroundColor = Color.lerp(colors.accentCritical, colors.surfaceBase, 0.95)!;
        borderColor = colors.accentCritical;
        iconColor = colors.accentCritical;
        break;
      case TauAlertVariant.error:
        backgroundColor = Color.lerp(colors.accentCritical, colors.surfaceBase, 0.9)!;
        borderColor = colors.accentCritical;
        iconColor = colors.accentCritical;
        break;
    }

    return Container(
      padding: EdgeInsets.all(spacing.spacingBase * 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          if (showIcon) ...[
            IconTheme(
              data: IconThemeData(
                color: iconColor,
                size: 20.0,
              ),
              child: icon ?? _getDefaultIcon(variant),
            ),
            SizedBox(width: spacing.spacingBase * 2),
          ],
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: typography.labelMono.copyWith(
                      color: colors.textOnDark,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase / 2),
                ],
                Text(
                  message,
                  style: typography.bodyMono.copyWith(
                    color: colors.textOnDark,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          // Close button
          if (onClose != null) ...[
            SizedBox(width: spacing.spacingBase * 2),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                IconData(0xe5cd, fontFamily: 'MaterialIcons'), // close
                size: 16.0,
                color: colors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _getDefaultIcon(TauAlertVariant variant) {
    IconData iconData;
    switch (variant) {
      case TauAlertVariant.info:
        iconData = const IconData(0xe88f, fontFamily: 'MaterialIcons'); // info
        break;
      case TauAlertVariant.success:
        iconData = const IconData(0xe86c, fontFamily: 'MaterialIcons'); // check_circle
        break;
      case TauAlertVariant.warning:
        iconData = const IconData(0xe002, fontFamily: 'MaterialIcons'); // warning
        break;
      case TauAlertVariant.error:
        iconData = const IconData(0xe000, fontFamily: 'MaterialIcons'); // error
        break;
    }
    return Icon(iconData);
  }
}

/// Alert variant for semantic color coding.
enum TauAlertVariant {
  /// Informational message (blue).
  info,

  /// Success message (chartreuse green).
  success,

  /// Warning message (orange).
  warning,

  /// Error message (orange/red).
  error,
}
