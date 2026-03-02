import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE toggle/switch component with tactical terminal aesthetic.
///
/// Binary switch control with smooth sliding animation.
/// Uses pill-shaped background with mechanical snap motion (150ms).
/// Neon chartreuse accent color for active state.
///
/// Example:
/// ```dart
/// TauToggle(
///   value: true,
///   label: 'SYSTEM ACTIVE',
///   onChanged: (value) => print('Toggle: $value'),
/// )
/// ```
class TauToggle extends StatefulWidget {
  const TauToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.width = 44.0,
    this.height = 24.0,
  });

  /// Current toggle state (true = on, false = off).
  final bool value;

  /// Callback when toggle state changes.
  final ValueChanged<bool>? onChanged;

  /// Optional label text displayed next to toggle.
  final String? label;

  /// Whether the toggle is enabled for interaction.
  final bool enabled;

  /// Width of the toggle switch.
  final double width;

  /// Height of the toggle switch.
  final double height;

  @override
  State<TauToggle> createState() => _TauToggleState();
}

class _TauToggleState extends State<TauToggle>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );

    // Initialize position based on value
    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(TauToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    Color trackColor;
    Color thumbColor;
    Color borderColor;

    if (!widget.enabled) {
      trackColor = colors.surfaceElevated;
      thumbColor = colors.textMuted;
      borderColor = colors.borderSubtle;
    } else if (widget.value) {
      trackColor = _pressed
          ? Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.2)!
          : colors.accentPrimary;
      thumbColor = colors.textOnAccent;
      borderColor = trackColor;
    } else {
      trackColor = _pressed
          ? Color.lerp(colors.surfaceElevated, colors.accentPrimary, 0.1)!
          : colors.surfaceBase;
      thumbColor = _pressed ? colors.accentPrimary : colors.borderAccent;
      borderColor = _pressed ? colors.accentPrimary : colors.borderAccent;
    }

    final thumbSize = widget.height - 6.0;
    final thumbTravel = widget.width - widget.height;

    final toggle = RepaintBoundary(
      child: GestureDetector(
        onTap: _handleTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: trackColor,
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(widget.height / 2),
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 3.0 + (_animation.value * thumbTravel),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    // If no label, return just the toggle
    if (widget.label == null) {
      return toggle;
    }

    // Return toggle with label
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          toggle,
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
