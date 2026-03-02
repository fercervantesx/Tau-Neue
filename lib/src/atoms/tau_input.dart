import 'package:flutter/material.dart';
import '../foundations/tau_container.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE input field component with tactical terminal aesthetic.
///
/// Clean rounded input with monospace text and block cursor.
/// Supports single and multi-line input (textarea mode).
///
/// For single-line input:
/// ```dart
/// TauInput(
///   placeholder: 'Enter command',
///   onSubmitted: (value) => print('Submitted: $value'),
/// )
/// ```
///
/// For multi-line textarea:
/// ```dart
/// TauInput.textarea(
///   placeholder: 'Enter description',
///   minLines: 3,
///   maxLines: 10,
///   onChanged: (value) => print('Changed: $value'),
/// )
/// ```
class TauInput extends StatefulWidget {
  const TauInput({
    super.key,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.keyboardType,
  }) : assert(minLines == null || minLines > 0, 'minLines must be positive'),
       assert(maxLines > 0, 'maxLines must be positive'),
       assert(minLines == null || minLines <= maxLines, 'minLines must be <= maxLines'),
       assert(!expands || (minLines == null && maxLines == 1), 'Cannot specify minLines/maxLines with expands');

  /// Factory constructor for textarea mode with reasonable defaults.
  const TauInput.textarea({
    super.key,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.minLines = 3,
    this.maxLines = 10,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.keyboardType,
  }) : obscureText = false,
       expands = false;

  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;

  /// Maximum number of lines to display.
  /// Set to null for unlimited lines (with expands: true).
  final int maxLines;

  /// Minimum number of lines to display (creates auto-expanding textarea).
  final int? minLines;

  /// Whether the input should expand to fill available space.
  final bool expands;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final TextInputType? keyboardType;

  @override
  State<TauInput> createState() => _TauInputState();
}

class _TauInputState extends State<TauInput> {
  late final TextEditingController _controller;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Disabled state: use different colors and reduced opacity
    final effectiveBackgroundColor = widget.enabled
        ? (widget.backgroundColor ?? colors.surfaceBase)
        : colors.surfaceElevated;
    final effectiveBorderColor = widget.enabled
        ? (widget.borderColor ?? (_focused ? colors.borderAccent : colors.borderSubtle))
        : colors.borderSubtle;
    final effectiveTextColor = widget.enabled
        ? (widget.textColor ?? colors.textOnDark)
        : colors.textMuted;

    return Opacity(
      opacity: widget.enabled ? 1.0 : 0.5,
      child: TauContainer(
        backgroundColor: effectiveBackgroundColor,
        borderColor: effectiveBorderColor,
        strokeWidth: 1.0,
        borderRadius: 6.0,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.spacingBase * 2,
          vertical: spacing.spacingBase,
        ),
        child: TextField(
        controller: _controller,
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        maxLines: widget.expands ? null : widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        keyboardType: widget.keyboardType,
        style: typography.bodyMono.copyWith(
          color: effectiveTextColor,
        ),
        cursorColor: colors.accentPrimary,
        cursorWidth: 2.0,
        cursorRadius: Radius.zero, // Block cursor
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: typography.bodyMono.copyWith(
            color: colors.textMuted,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onTap: () => setState(() => _focused = true),
        onTapOutside: (_) => setState(() => _focused = false),
        ),
      ),
    );
  }
}
