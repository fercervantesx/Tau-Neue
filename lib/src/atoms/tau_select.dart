import 'package:flutter/material.dart' show Material;
import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE select/dropdown component with tactical terminal aesthetic.
///
/// Dropdown menu for selecting a single option from a list.
/// Uses industrial border styling matching TauInput.
/// Dropdown overlay animates with mechanical snap (150ms).
///
/// Example:
/// ```dart
/// TauSelect<String>(
///   value: 'option1',
///   options: [
///     TauSelectOption(value: 'option1', label: 'ALPHA'),
///     TauSelectOption(value: 'option2', label: 'BETA'),
///   ],
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class TauSelect<T> extends StatefulWidget {
  const TauSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder = 'SELECT...',
    this.enabled = true,
    this.width,
    this.height = 40.0,
  });

  /// Currently selected value.
  final T? value;

  /// List of selectable options.
  final List<TauSelectOption<T>> options;

  /// Callback when selection changes.
  final ValueChanged<T>? onChanged;

  /// Placeholder text when no value is selected.
  final String placeholder;

  /// Whether the select is enabled for interaction.
  final bool enabled;

  /// Width of the select button.
  final double? width;

  /// Height of the select button.
  final double height;

  @override
  State<TauSelect<T>> createState() => _TauSelectState<T>();
}

class _TauSelectState<T> extends State<TauSelect<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  String get _displayText {
    if (widget.value == null) {
      return widget.placeholder;
    }
    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () => TauSelectOption(value: widget.value as T, label: widget.placeholder),
    );
    return selectedOption.label;
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _handleOptionSelected(T value) {
    widget.onChanged?.call(value);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 4.0,
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 4.0),
                child: _TauSelectDropdown<T>(
                  options: widget.options,
                  onOptionSelected: _handleOptionSelected,
                  width: size.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final borderColor = widget.enabled
        ? (_isOpen ? colors.accentPrimary : colors.borderAccent)
        : colors.borderSubtle;

    final textColor = widget.enabled
        ? (widget.value != null ? colors.textOnDark : colors.textMuted)
        : colors.textMuted;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: colors.surfaceBase,
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.spacingBase * 2,
            vertical: spacing.spacingBase,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  _displayText,
                  style: typography.labelMono.copyWith(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: spacing.spacingBase),
              CustomPaint(
                size: const Size(8.0, 6.0),
                painter: _ChevronPainter(
                  color: borderColor,
                  direction: _isOpen ? _ChevronDirection.up : _ChevronDirection.down,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Configuration for a single select option.
class TauSelectOption<T> {
  const TauSelectOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  /// Value represented by this option.
  final T value;

  /// Display label for this option.
  final String label;

  /// Whether this option is selectable.
  final bool enabled;
}

/// Dropdown menu overlay widget.
class _TauSelectDropdown<T> extends StatefulWidget {
  const _TauSelectDropdown({
    required this.options,
    required this.onOptionSelected,
    required this.width,
  });

  final List<TauSelectOption<T>> options;
  final ValueChanged<T> onOptionSelected;
  final double width;

  @override
  State<_TauSelectDropdown<T>> createState() => _TauSelectDropdownState<T>();
}

class _TauSelectDropdownState<T> extends State<_TauSelectDropdown<T>>
    with SingleTickerProviderStateMixin {
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
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Limit dropdown height to 5 items max
    final maxHeight = 40.0 * 5 + spacing.spacingBase * 2;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 0.95 + (_animation.value * 0.05),
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
      child: Material(
        color: const Color(0x00000000),
        child: Container(
          width: widget.width,
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            border: Border.all(
              color: colors.accentPrimary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.map((option) {
                  return _TauSelectOption<T>(
                    option: option,
                    onTap: () => widget.onOptionSelected(option.value),
                    typography: typography,
                    colors: colors,
                    spacing: spacing,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual option in the dropdown.
class _TauSelectOption<T> extends StatefulWidget {
  const _TauSelectOption({
    required this.option,
    required this.onTap,
    required this.typography,
    required this.colors,
    required this.spacing,
  });

  final TauSelectOption<T> option;
  final VoidCallback onTap;
  final dynamic typography;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauSelectOption<T>> createState() => _TauSelectOptionState<T>();
}

class _TauSelectOptionState<T> extends State<_TauSelectOption<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _hovered
        ? Color.lerp(widget.colors.accentPrimary, widget.colors.surfaceBase, 0.9)!
        : widget.colors.surfaceElevated;

    final textColor = widget.option.enabled
        ? widget.colors.textOnDark
        : widget.colors.textMuted;

    return GestureDetector(
      onTap: widget.option.enabled ? widget.onTap : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(
            horizontal: widget.spacing.spacingBase * 2,
            vertical: widget.spacing.spacingBase,
          ),
          color: backgroundColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.option.label,
              style: widget.typography.labelMono.copyWith(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

/// Direction for chevron icon.
enum _ChevronDirection { up, down }

/// Custom painter for chevron icon.
class _ChevronPainter extends CustomPainter {
  _ChevronPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final _ChevronDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    if (direction == _ChevronDirection.down) {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChevronPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}
