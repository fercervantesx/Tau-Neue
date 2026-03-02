import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE button group component with tactical terminal aesthetic.
///
/// Grouped button controls with single or multi-select modes.
/// Buttons are visually connected with shared borders.
///
/// Example:
/// ```dart
/// TauButtonGroup(
///   items: [
///     TauButtonGroupItem(id: 'list', label: 'LIST'),
///     TauButtonGroupItem(id: 'grid', label: 'GRID'),
///   ],
///   selectedIds: {'list'},
///   onSelectionChanged: (ids) => updateView(ids),
/// )
/// ```
class TauButtonGroup extends StatelessWidget {
  const TauButtonGroup({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onSelectionChanged,
    this.allowMultiple = false,
    this.axis = Axis.horizontal,
  });

  /// List of button items.
  final List<TauButtonGroupItem> items;

  /// Set of currently selected item IDs.
  final Set<String> selectedIds;

  /// Callback when selection changes.
  final ValueChanged<Set<String>> onSelectionChanged;

  /// Whether multiple items can be selected.
  final bool allowMultiple;

  /// Layout direction.
  final Axis axis;

  void _handleTap(String id) {
    final newSelection = Set<String>.from(selectedIds);

    if (newSelection.contains(id)) {
      if (allowMultiple || newSelection.length > 1) {
        newSelection.remove(id);
      }
    } else {
      if (!allowMultiple) {
        newSelection.clear();
      }
      newSelection.add(id);
    }

    onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isSelected = selectedIds.contains(item.id);
      final isFirst = i == 0;
      final isLast = i == items.length - 1;

      children.add(
        _TauButtonGroupItemWidget(
          item: item,
          isSelected: isSelected,
          isFirst: isFirst,
          isLast: isLast,
          axis: axis,
          onTap: () => _handleTap(item.id),
          colors: colors,
          spacing: spacing,
          typography: typography,
        ),
      );
    }

    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

/// Configuration for a button group item.
class TauButtonGroupItem {
  const TauButtonGroupItem({
    required this.id,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  /// Unique identifier.
  final String id;

  /// Display label.
  final String label;

  /// Optional icon.
  final Widget? icon;

  /// Whether this item is enabled.
  final bool enabled;
}

/// Internal button group item widget.
class _TauButtonGroupItemWidget extends StatefulWidget {
  const _TauButtonGroupItemWidget({
    required this.item,
    required this.isSelected,
    required this.isFirst,
    required this.isLast,
    required this.axis,
    required this.onTap,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauButtonGroupItem item;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final Axis axis;
  final VoidCallback onTap;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  State<_TauButtonGroupItemWidget> createState() => _TauButtonGroupItemWidgetState();
}

class _TauButtonGroupItemWidgetState extends State<_TauButtonGroupItemWidget> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (!widget.item.enabled) {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
    } else if (widget.isSelected) {
      backgroundColor = widget.colors.accentPrimary;
      textColor = widget.colors.textOnAccent;
    } else if (_pressed) {
      backgroundColor = Color.lerp(
        widget.colors.surfaceElevated,
        widget.colors.accentPrimary,
        0.3,
      )!;
      textColor = widget.colors.textOnDark;
    } else if (_hovered) {
      backgroundColor = widget.colors.surfaceElevated;
      textColor = widget.colors.textOnDark;
    } else {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
    }

    BorderRadius? borderRadius;
    if (widget.axis == Axis.horizontal) {
      if (widget.isFirst && widget.isLast) {
        borderRadius = BorderRadius.circular(6.0);
      } else if (widget.isFirst) {
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(6.0),
          bottomLeft: Radius.circular(6.0),
        );
      } else if (widget.isLast) {
        borderRadius = const BorderRadius.only(
          topRight: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        );
      }
    } else {
      if (widget.isFirst && widget.isLast) {
        borderRadius = BorderRadius.circular(6.0);
      } else if (widget.isFirst) {
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(6.0),
          topRight: Radius.circular(6.0),
        );
      } else if (widget.isLast) {
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        );
      }
    }

    return MouseRegion(
      onEnter: widget.item.enabled ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.item.enabled
          ? (_) => setState(() {
                _hovered = false;
                _pressed = false;
              })
          : null,
      cursor: widget.item.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: widget.item.enabled ? (_) => setState(() => _pressed = true) : null,
        onTapUp: widget.item.enabled ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: widget.item.enabled ? () => setState(() => _pressed = false) : null,
        onTap: widget.item.enabled ? widget.onTap : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.spacing.spacingBase * 2,
            vertical: widget.spacing.spacingBase,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: widget.colors.borderSubtle,
              width: 1.0,
            ),
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.item.icon != null) ...{
                IconTheme(
                  data: IconThemeData(
                    color: textColor,
                    size: 16.0,
                  ),
                  child: widget.item.icon!,
                ),
                SizedBox(width: widget.spacing.spacingBase),
              },
              Text(
                widget.item.label,
                style: widget.typography.labelMono.copyWith(
                  color: textColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
