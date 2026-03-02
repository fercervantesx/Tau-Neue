import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE checkbox component with tactical terminal aesthetic.
///
/// Interactive checkbox with onChange callback for user selections.
/// Supports checked, unchecked, and indeterminate states.
/// Uses neon chartreuse accent color for checked state.
///
/// Example:
/// ```dart
/// TauCheckbox(
///   value: true,
///   label: 'ACCEPT TERMS',
///   onChanged: (value) => print('Checkbox: $value'),
/// )
/// ```
class TauCheckbox extends StatefulWidget {
  const TauCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.indeterminate = false,
  });

  /// Current checkbox state (true = checked, false = unchecked).
  final bool value;

  /// Callback when checkbox state changes.
  final ValueChanged<bool>? onChanged;

  /// Optional label text displayed next to checkbox.
  final String? label;

  /// Whether the checkbox is enabled for interaction.
  final bool enabled;

  /// Whether to show indeterminate state (takes precedence over value).
  final bool indeterminate;

  @override
  State<TauCheckbox> createState() => _TauCheckboxState();
}

class _TauCheckboxState extends State<TauCheckbox> {
  bool _pressed = false;

  void _handleTap() {
    if (widget.enabled && widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && widget.onChanged != null) {
      setState(() => _pressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled && widget.onChanged != null) {
      setState(() => _pressed = false);
    }
  }

  void _handleTapCancel() {
    if (widget.enabled && widget.onChanged != null) {
      setState(() => _pressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Determine colors based on state
    Color boxColor;
    Color? checkColor;
    Color borderColor;

    if (!widget.enabled) {
      boxColor = colors.surfaceElevated;
      checkColor = colors.textMuted;
      borderColor = colors.borderSubtle;
    } else if (widget.indeterminate || widget.value) {
      boxColor = _pressed
          ? Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.2)!
          : colors.accentPrimary;
      checkColor = colors.textOnAccent;
      borderColor = boxColor;
    } else {
      boxColor = _pressed
          ? Color.lerp(colors.surfaceElevated, colors.accentPrimary, 0.1)!
          : colors.surfaceBase;
      checkColor = null;
      borderColor = _pressed ? colors.accentPrimary : colors.borderAccent;
    }

    final checkbox = RepaintBoundary(
      child: GestureDetector(
        onTap: _handleTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: checkColor != null
              ? Center(
                  child: widget.indeterminate
                      ? Container(
                          width: 10.0,
                          height: 2.0,
                          color: checkColor,
                        )
                      : CustomPaint(
                          size: const Size(12.0, 12.0),
                          painter: _CheckmarkPainter(color: checkColor),
                        ),
                )
              : null,
        ),
      ),
    );

    // If no label, return just the checkbox
    if (widget.label == null) {
      return checkbox;
    }

    // Return checkbox with label
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkbox,
          SizedBox(width: spacing.spacingBase),
          Text(
            widget.label!,
            style: typography.labelMono.copyWith(
              color: widget.enabled ? colors.textOnDark : colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for checkmark icon.
class _CheckmarkPainter extends CustomPainter {
  _CheckmarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // Draw checkmark: short vertical line, then longer diagonal
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
