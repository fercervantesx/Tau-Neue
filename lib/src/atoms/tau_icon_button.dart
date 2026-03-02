import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE icon button component with tactical terminal aesthetic.
///
/// Icon-only button with multiple size and variant options.
///
/// Example:
/// ```dart
/// TauIconButton(
///   icon: Icon(Icons.settings),
///   onPressed: () => openSettings(),
///   size: TauIconButtonSize.medium,
/// )
/// ```
class TauIconButton extends StatefulWidget {
  const TauIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = TauIconButtonVariant.secondary,
    this.size = TauIconButtonSize.medium,
    this.enabled = true,
  });

  /// Icon widget.
  final Widget icon;

  /// Callback when button is pressed.
  final VoidCallback onPressed;

  /// Visual variant.
  final TauIconButtonVariant variant;

  /// Button size.
  final TauIconButtonSize size;

  /// Whether the button is enabled.
  final bool enabled;

  @override
  State<TauIconButton> createState() => _TauIconButtonState();
}

class _TauIconButtonState extends State<TauIconButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);

    final sizeValue = widget.size == TauIconButtonSize.small
        ? 32.0
        : widget.size == TauIconButtonSize.medium
            ? 40.0
            : 48.0;

    final iconSize = widget.size == TauIconButtonSize.small
        ? 16.0
        : widget.size == TauIconButtonSize.medium
            ? 20.0
            : 24.0;

    Color backgroundColor;
    Color iconColor;
    Color borderColor;

    if (!widget.enabled) {
      backgroundColor = colors.surfaceBase;
      iconColor = colors.textMuted;
      borderColor = colors.borderSubtle;
    } else if (widget.variant == TauIconButtonVariant.primary) {
      if (_pressed) {
        backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.3)!;
        iconColor = colors.textOnAccent;
        borderColor = colors.accentPrimary;
      } else if (_hovered) {
        backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.2)!;
        iconColor = colors.textOnAccent;
        borderColor = colors.accentPrimary;
      } else {
        backgroundColor = colors.accentPrimary;
        iconColor = colors.textOnAccent;
        borderColor = colors.accentPrimary;
      }
    } else if (widget.variant == TauIconButtonVariant.secondary) {
      if (_pressed) {
        backgroundColor = Color.lerp(colors.surfaceHighlight, colors.accentPrimary, 0.2)!;
        iconColor = colors.textOnDark;
        borderColor = colors.borderSubtle;
      } else if (_hovered) {
        backgroundColor = colors.surfaceHighlight;
        iconColor = colors.textOnDark;
        borderColor = colors.borderSubtle;
      } else {
        backgroundColor = colors.surfaceElevated;
        iconColor = colors.textMuted;
        borderColor = colors.borderSubtle;
      }
    } else {
      // ghost
      if (_pressed) {
        backgroundColor = Color.lerp(colors.surfaceBase, colors.accentPrimary, 0.2)!;
        iconColor = colors.textOnDark;
        borderColor = colors.borderSubtle;
      } else if (_hovered) {
        backgroundColor = colors.surfaceElevated;
        iconColor = colors.textOnDark;
        borderColor = colors.borderSubtle;
      } else {
        backgroundColor = const Color(0x00000000);
        iconColor = colors.textMuted;
        borderColor = const Color(0x00000000);
      }
    }

    return MouseRegion(
      onEnter: widget.enabled ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.enabled
          ? (_) => setState(() {
                _hovered = false;
                _pressed = false;
              })
          : null,
      cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: widget.enabled ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: widget.enabled ? () => setState(() => _pressed = false) : null,
        onTap: widget.enabled ? widget.onPressed : null,
        child: Container(
          width: sizeValue,
          height: sizeValue,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(
                color: iconColor,
                size: iconSize,
              ),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}

/// Variant options for icon button.
enum TauIconButtonVariant {
  primary,
  secondary,
  ghost,
}

/// Size options for icon button.
enum TauIconButtonSize {
  small,
  medium,
  large,
}
