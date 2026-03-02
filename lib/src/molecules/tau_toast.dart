import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE toast notification component with tactical terminal aesthetic.
///
/// Temporary notification message with auto-dismiss or manual close.
/// Use with Flutter's Overlay for positioning.
///
/// Example:
/// ```dart
/// TauToast(
///   variant: TauToastVariant.success,
///   message: 'Operation completed successfully',
///   onDismiss: () => removeToast(),
/// )
/// ```
class TauToast extends StatefulWidget {
  const TauToast({
    super.key,
    required this.variant,
    required this.message,
    this.title,
    this.icon,
    this.onDismiss,
    this.autoDismiss = true,
    this.duration = const Duration(seconds: 4),
  });

  /// Toast variant for color coding.
  final TauToastVariant variant;

  /// Message text.
  final String message;

  /// Optional title text.
  final String? title;

  /// Optional custom icon.
  final Widget? icon;

  /// Callback when toast is dismissed.
  final VoidCallback? onDismiss;

  /// Whether to auto-dismiss after duration.
  final bool autoDismiss;

  /// Duration before auto-dismiss (if enabled).
  final Duration duration;

  @override
  State<TauToast> createState() => _TauToastState();
}

class _TauToastState extends State<TauToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -20.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    if (widget.autoDismiss) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    if (mounted) {
      widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Determine colors based on variant
    Color backgroundColor;
    Color borderColor;
    Color iconColor;

    switch (widget.variant) {
      case TauToastVariant.info:
        backgroundColor = Color.lerp(colors.accentInfo, colors.surfaceBase, 0.85)!;
        borderColor = colors.accentInfo;
        iconColor = colors.accentInfo;
        break;
      case TauToastVariant.success:
        backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.85)!;
        borderColor = colors.accentPrimary;
        iconColor = colors.accentPrimary;
        break;
      case TauToastVariant.warning:
        backgroundColor = Color.lerp(colors.accentCritical, colors.surfaceBase, 0.9)!;
        borderColor = colors.accentCritical;
        iconColor = colors.accentCritical;
        break;
      case TauToastVariant.error:
        backgroundColor = Color.lerp(colors.accentCritical, colors.surfaceBase, 0.85)!;
        borderColor = colors.accentCritical;
        iconColor = colors.accentCritical;
        break;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(spacing.spacingBase * 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000),
              offset: const Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            IconTheme(
              data: IconThemeData(
                color: iconColor,
                size: 20.0,
              ),
              child: widget.icon ?? _getDefaultIcon(widget.variant),
            ),
            SizedBox(width: spacing.spacingBase * 2),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.title != null) ...[
                    Text(
                      widget.title!,
                      style: typography.labelMono.copyWith(
                        color: colors.textOnDark,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spacing.spacingBase / 2),
                  ],
                  Text(
                    widget.message,
                    style: typography.bodyMono.copyWith(
                      color: colors.textOnDark,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            // Close button
            SizedBox(width: spacing.spacingBase * 2),
            GestureDetector(
              onTap: _dismiss,
              child: Icon(
                const IconData(0xe5cd, fontFamily: 'MaterialIcons'), // close
                size: 16.0,
                color: colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDefaultIcon(TauToastVariant variant) {
    IconData iconData;
    switch (variant) {
      case TauToastVariant.info:
        iconData = const IconData(0xe88f, fontFamily: 'MaterialIcons'); // info
        break;
      case TauToastVariant.success:
        iconData = const IconData(0xe86c, fontFamily: 'MaterialIcons'); // check_circle
        break;
      case TauToastVariant.warning:
        iconData = const IconData(0xe002, fontFamily: 'MaterialIcons'); // warning
        break;
      case TauToastVariant.error:
        iconData = const IconData(0xe000, fontFamily: 'MaterialIcons'); // error
        break;
    }
    return Icon(iconData);
  }
}

/// Toast variant for semantic color coding.
enum TauToastVariant {
  /// Informational message (blue).
  info,

  /// Success message (chartreuse green).
  success,

  /// Warning message (orange).
  warning,

  /// Error message (orange/red).
  error,
}

/// Helper to show a toast notification using Flutter's Overlay.
///
/// Example:
/// ```dart
/// showTauToast(
///   context: context,
///   variant: TauToastVariant.success,
///   message: 'File uploaded successfully',
/// )
/// ```
void showTauToast({
  required BuildContext context,
  required TauToastVariant variant,
  required String message,
  String? title,
  Widget? icon,
  Duration duration = const Duration(seconds: 4),
  bool autoDismiss = true,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 16.0,
      left: 16.0,
      right: 16.0,
      child: Center(
        child: TauToast(
          variant: variant,
          message: message,
          title: title,
          icon: icon,
          duration: duration,
          autoDismiss: autoDismiss,
          onDismiss: () {
            overlayEntry.remove();
          },
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
}
