import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE radio button group component with tactical terminal aesthetic.
///
/// Manages a group of mutually exclusive radio button options.
/// Supports vertical and horizontal layout modes.
/// Uses neon chartreuse accent color for selected state.
///
/// Example:
/// ```dart
/// TauRadioGroup<String>(
///   value: 'option1',
///   options: [
///     TauRadioOption(value: 'option1', label: 'ALPHA'),
///     TauRadioOption(value: 'option2', label: 'BETA'),
///     TauRadioOption(value: 'option3', label: 'GAMMA'),
///   ],
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class TauRadioGroup<T> extends StatelessWidget {
  const TauRadioGroup({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.enabled = true,
    this.axis = Axis.vertical,
    this.spacing = 12.0,
  });

  /// Currently selected value.
  final T? value;

  /// List of radio button options.
  final List<TauRadioOption<T>> options;

  /// Callback when selection changes.
  final ValueChanged<T>? onChanged;

  /// Whether the radio group is enabled for interaction.
  final bool enabled;

  /// Layout direction (vertical or horizontal).
  final Axis axis;

  /// Spacing between radio buttons.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < options.length; i++) {
      final option = options[i];
      final isEnabled = enabled && option.enabled;

      children.add(
        TauRadio<T>(
          value: option.value,
          groupValue: value,
          label: option.label,
          enabled: isEnabled,
          onChanged: onChanged,
        ),
      );

      // Add spacing between options (but not after the last one)
      if (i < options.length - 1) {
        if (axis == Axis.vertical) {
          children.add(SizedBox(height: spacing));
        } else {
          children.add(SizedBox(width: spacing));
        }
      }
    }

    if (axis == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

/// Configuration for a single radio button option.
class TauRadioOption<T> {
  const TauRadioOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  /// Value represented by this option.
  final T value;

  /// Label text for this option.
  final String label;

  /// Whether this option is enabled.
  final bool enabled;
}

/// Individual radio button component.
class TauRadio<T> extends StatefulWidget {
  const TauRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.label,
    required this.onChanged,
    this.enabled = true,
  });

  /// Value represented by this radio button.
  final T value;

  /// Currently selected value in the group.
  final T? groupValue;

  /// Optional label text.
  final String? label;

  /// Callback when this radio is selected.
  final ValueChanged<T>? onChanged;

  /// Whether this radio is enabled.
  final bool enabled;

  @override
  State<TauRadio<T>> createState() => _TauRadioState<T>();
}

class _TauRadioState<T> extends State<TauRadio<T>> {
  bool _pressed = false;

  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (widget.enabled && widget.onChanged != null) {
      widget.onChanged!(widget.value);
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
    Color outerCircleColor;
    Color? innerCircleColor;
    Color borderColor;

    if (!widget.enabled) {
      outerCircleColor = colors.surfaceElevated;
      innerCircleColor = _isSelected ? colors.textMuted : null;
      borderColor = colors.borderSubtle;
    } else if (_isSelected) {
      outerCircleColor = _pressed
          ? Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.2)!
          : colors.accentPrimary;
      innerCircleColor = colors.textOnAccent;
      borderColor = outerCircleColor;
    } else {
      outerCircleColor = _pressed
          ? Color.lerp(colors.surfaceElevated, colors.accentPrimary, 0.1)!
          : colors.surfaceBase;
      innerCircleColor = null;
      borderColor = _pressed ? colors.accentPrimary : colors.borderAccent;
    }

    final radio = RepaintBoundary(
      child: GestureDetector(
        onTap: _handleTap,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: outerCircleColor,
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
            shape: BoxShape.circle,
          ),
          child: innerCircleColor != null
              ? Center(
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: innerCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );

    // If no label, return just the radio
    if (widget.label == null) {
      return radio;
    }

    // Return radio with label
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio,
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
