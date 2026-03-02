import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE chip component with tactical terminal aesthetic.
///
/// Removable tag/filter chip with optional icon and close button.
///
/// Example:
/// ```dart
/// TauChip(
///   label: 'ACTIVE',
///   onRemove: () => removeTag(),
/// )
/// ```
class TauChip extends StatefulWidget {
  const TauChip({
    super.key,
    required this.label,
    this.icon,
    this.onRemove,
    this.variant = TauChipVariant.default_,
    this.enabled = true,
  });

  /// Chip label.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Callback when close button is tapped.
  /// If null, close button is not shown.
  final VoidCallback? onRemove;

  /// Visual variant.
  final TauChipVariant variant;

  /// Whether the chip is enabled.
  final bool enabled;

  @override
  State<TauChip> createState() => _TauChipState();
}

class _TauChipState extends State<TauChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (!widget.enabled) {
      backgroundColor = colors.surfaceBase;
      textColor = colors.textMuted;
      borderColor = colors.borderSubtle;
    } else if (widget.variant == TauChipVariant.primary) {
      backgroundColor = _hovered
          ? Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.7)!
          : Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.85)!;
      textColor = colors.accentPrimary;
      borderColor = colors.accentPrimary;
    } else {
      backgroundColor = _hovered ? colors.surfaceElevated : colors.surfaceBase;
      textColor = colors.textOnDark;
      borderColor = colors.borderSubtle;
    }

    return MouseRegion(
      onEnter: widget.enabled ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.enabled ? (_) => setState(() => _hovered = false) : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.spacingBase * 1.5,
          vertical: spacing.spacingBase / 2,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            if (widget.icon != null) ...{
              IconTheme(
                data: IconThemeData(
                  color: textColor,
                  size: 14.0,
                ),
                child: widget.icon!,
              ),
              SizedBox(width: spacing.spacingBase / 2),
            },

            // Label
            Text(
              widget.label,
              style: typography.labelMono.copyWith(
                color: textColor,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),

            // Close button
            if (widget.onRemove != null) ...{
              SizedBox(width: spacing.spacingBase / 2),
              GestureDetector(
                onTap: widget.enabled ? widget.onRemove : null,
                child: Icon(
                  const IconData(0xe5cd, fontFamily: 'MaterialIcons'), // close
                  color: textColor,
                  size: 14.0,
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}

/// Variant options for chip.
enum TauChipVariant {
  default_,
  primary,
}
