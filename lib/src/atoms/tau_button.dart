import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import '../foundations/tau_container.dart';
import '../foundations/theme/tau_theme.dart';

/// Button visual variants for tactical terminal UI.
enum TauButtonVariant {
  /// Lime green background with black text (active state).
  /// Example: "CYAG" button in navigation.
  primary,

  /// Grey background with white text (inactive/secondary state).
  /// Example: "NUCAL", "TRAXUS" buttons in navigation.
  secondary,

  /// Transparent background with border only.
  /// Used for subtle actions.
  ghost,

  /// Wide/extended font for emphasis.
  /// Used for prominent actions like "PURCHASE".
  wide,
}

/// TAU NEUE button component with tactical terminal aesthetic.
///
/// Interactive button with onPressed callback for user actions.
/// Supports optional icon sections on left or right side with independent backgrounds.
/// Uses Zen Dots font for wide variant, IBM Plex Mono for others.
///
/// **Pill Shape**: Set `isPill: true` for fully rounded corners (height / 2).
/// This is different from TauPill, which is a non-interactive badge component.
///
/// Example:
/// ```dart
/// TauButton(
///   label: 'UPGRADES',
///   variant: TauButtonVariant.secondary,
///   iconRight: Icon(Icons.arrow_upward, size: 16),
///   iconRightBackground: colors.accentPrimary,
///   onPressed: () => print('Pressed'),
/// )
/// ```
class TauButton extends StatefulWidget {
  const TauButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = TauButtonVariant.primary,
    this.iconLeft,
    this.iconLeftBackground,
    this.iconRight,
    this.iconRightBackground,
    this.width,
    this.height = 40.0,
    this.enabled = true,
    this.isPill = false,
    this.progress,
    this.textAlign = Alignment.center,
  }) : assert(progress == null || (progress >= 0.0 && progress <= 1.0), 'Progress must be between 0.0 and 1.0');

  final String label;
  final VoidCallback? onPressed;
  final TauButtonVariant variant;
  final Widget? iconLeft;
  final Color? iconLeftBackground;
  final Widget? iconRight;
  final Color? iconRightBackground;
  final double? width;
  final double height;
  final bool enabled;
  final bool isPill;

  /// Optional progress value from 0.0 to 1.0.
  /// When provided, shows filled portion in full color and remaining portion darker.
  final double? progress;

  /// Text alignment within the button (default: center).
  /// Use Alignment.centerLeft, Alignment.topLeft, etc. for corner anchoring.
  final Alignment textAlign;

  @override
  State<TauButton> createState() => _TauButtonState();
}

class _TauButtonState extends State<TauButton> {
  bool _pressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onPressed != null) {
      setState(() => _pressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && widget.onPressed != null) {
      setState(() => _pressed = false);
      widget.onPressed!();
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && widget.onPressed != null) {
      setState(() => _pressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Determine colors based on variant and pressed state
    Color backgroundColor;
    Color textColor;
    Color? borderColor;
    TextStyle textStyle;

    if (!widget.enabled) {
      // Disabled state
      backgroundColor = colors.surfaceElevated;
      textColor = colors.textMuted;
      borderColor = colors.borderSubtle;
      textStyle = typography.labelMono;
    } else {
      switch (widget.variant) {
        case TauButtonVariant.primary:
          if (_pressed) {
            backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.2)!;
            textColor = colors.textOnAccent;
          } else {
            backgroundColor = colors.accentPrimary;
            textColor = colors.textOnAccent;
          }
          borderColor = null;
          textStyle = typography.labelMono;
          break;

        case TauButtonVariant.secondary:
          if (_pressed) {
            backgroundColor = Color.lerp(colors.accentSecondary, colors.textOnDark, 0.2)!;
            textColor = colors.textOnDark;
          } else {
            backgroundColor = colors.accentSecondary;
            textColor = colors.textOnDark;
          }
          borderColor = null;
          textStyle = typography.labelMono;
          break;

        case TauButtonVariant.ghost:
          if (_pressed) {
            backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.8)!;
            textColor = colors.accentPrimary;
          } else {
            backgroundColor = const Color(0x00000000);
            textColor = colors.accentPrimary;
          }
          borderColor = colors.accentPrimary;
          textStyle = typography.labelMono;
          break;

        case TauButtonVariant.wide:
          if (_pressed) {
            backgroundColor = Color.lerp(colors.textOnDark, colors.surfaceBase, 0.2)!;
            textColor = colors.surfaceBase;
          } else {
            backgroundColor = colors.textOnDark;
            textColor = colors.surfaceBase;
          }
          borderColor = null;
          textStyle = typography.buttonWide;
          break;
      }
    }

    final hasLeftIcon = widget.iconLeft != null;
    final hasRightIcon = widget.iconRight != null;

    // Calculate border radius: pill uses full height for rounded ends, otherwise 6.0
    final borderRadius = widget.isPill ? widget.height / 2 : 6.0;

    final effectiveProgress = widget.progress ?? 1.0;
    final darkerBackgroundColor = Color.lerp(backgroundColor, const Color(0xFF000000), 0.6)!;

    final buttonContent = ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              // Darker background (unfilled portion) - invisible but reserves space
              TauContainer(
                width: widget.width,
                height: widget.height,
                backgroundColor: darkerBackgroundColor,
                borderColor: borderColor,
                strokeWidth: 1.0,
                borderRadius: borderRadius,
                child: Opacity(
                  opacity: 0.0,
                  child: Row(
                    mainAxisSize: widget.width != null ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      if (hasLeftIcon) SizedBox(width: spacing.spacingBase * 2 + 16),
                      if (widget.width != null)
                        Expanded(child: Text(widget.label, style: textStyle))
                      else
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spacing.spacingBase * 2),
                          child: Text(widget.label, style: textStyle),
                        ),
                      if (hasRightIcon) SizedBox(width: spacing.spacingBase * 2 + 16),
                    ],
                  ),
                ),
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
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              // Content on top
              TauContainer(
                width: widget.width,
                height: widget.height,
                backgroundColor: Colors.transparent,
                borderColor: null,
                strokeWidth: 0.0,
                borderRadius: borderRadius,
                child: Row(
            mainAxisSize: widget.width != null ? MainAxisSize.max : MainAxisSize.min,
            children: [
              // Left icon section
              if (hasLeftIcon)
                Container(
                  decoration: BoxDecoration(
                    color: widget.iconLeftBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.spacingBase,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(
                        color: widget.iconLeftBackground != null
                            ? colors.textOnAccent
                            : textColor,
                      ),
                      child: widget.iconLeft!,
                    ),
                  ),
                ),

              // Label section
              if (widget.width != null)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.spacingBase * 2,
                      vertical: spacing.spacingBase,
                    ),
                    child: Align(
                      alignment: widget.textAlign,
                      child: Text(
                        widget.label,
                        style: textStyle.copyWith(color: textColor),
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.spacingBase * 2,
                    vertical: spacing.spacingBase,
                  ),
                  child: Align(
                    alignment: widget.textAlign,
                    child: Text(
                      widget.label,
                      style: textStyle.copyWith(color: textColor),
                    ),
                  ),
                ),

              // Right icon section
              if (hasRightIcon)
                Container(
                  decoration: BoxDecoration(
                    color: widget.iconRightBackground,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.spacingBase,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(
                        color: widget.iconRightBackground != null
                            ? colors.textOnAccent
                            : textColor,
                      ),
                      child: widget.iconRight!,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );

    return RepaintBoundary(
      child: widget.onPressed != null
          ? GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: buttonContent,
            )
          : buttonContent,
    );
  }
}
