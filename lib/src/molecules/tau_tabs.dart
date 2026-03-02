import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE tabs component with tactical terminal aesthetic.
///
/// Tabbed navigation for switching between content views.
/// Supports horizontal and vertical layouts.
///
/// Example:
/// ```dart
/// TauTabs(
///   tabs: [
///     TauTab(id: 'overview', label: 'OVERVIEW'),
///     TauTab(id: 'details', label: 'DETAILS'),
///     TauTab(id: 'logs', label: 'LOGS'),
///   ],
///   currentTabId: 'overview',
///   onTabSelected: (id) => setState(() => currentTab = id),
/// )
/// ```
class TauTabs extends StatelessWidget {
  const TauTabs({
    super.key,
    required this.tabs,
    required this.currentTabId,
    required this.onTabSelected,
    this.axis = Axis.horizontal,
  });

  /// List of tab definitions.
  final List<TauTab> tabs;

  /// Currently selected tab ID.
  final String currentTabId;

  /// Callback when tab is selected.
  final ValueChanged<String> onTabSelected;

  /// Layout direction (horizontal or vertical).
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    if (axis == Axis.horizontal) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colors.borderSubtle,
              width: 2.0,
            ),
          ),
        ),
        child: Row(
          children: tabs
              .map((tab) => _TauTabButton(
                    tab: tab,
                    isSelected: tab.id == currentTabId,
                    onTap: () => onTabSelected(tab.id),
                    axis: axis,
                    colors: colors,
                    spacing: spacing,
                  ))
              .toList(),
        ),
      );
    } else {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: tabs
              .map((tab) => _TauTabButton(
                    tab: tab,
                    isSelected: tab.id == currentTabId,
                    onTap: () => onTabSelected(tab.id),
                    axis: axis,
                    colors: colors,
                    spacing: spacing,
                  ))
              .toList(),
        ),
      );
    }
  }
}

/// Configuration for a single tab.
class TauTab {
  const TauTab({
    required this.id,
    required this.label,
    this.icon,
    this.enabled = true,
    this.badge,
  });

  /// Unique identifier for this tab.
  final String id;

  /// Display label.
  final String label;

  /// Optional icon.
  final Widget? icon;

  /// Whether this tab is enabled.
  final bool enabled;

  /// Optional badge text (e.g., count).
  final String? badge;
}

/// Internal tab button widget.
class _TauTabButton extends StatefulWidget {
  const _TauTabButton({
    required this.tab,
    required this.isSelected,
    required this.onTap,
    required this.axis,
    required this.colors,
    required this.spacing,
  });

  final TauTab tab;
  final bool isSelected;
  final VoidCallback onTap;
  final Axis axis;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauTabButton> createState() => _TauTabButtonState();
}

class _TauTabButtonState extends State<_TauTabButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final typography = TauTheme.typographyOf(context);

    Color textColor;
    Color? indicatorColor;

    if (!widget.tab.enabled) {
      textColor = widget.colors.textMuted;
      indicatorColor = null;
    } else if (widget.isSelected) {
      textColor = widget.colors.accentPrimary;
      indicatorColor = widget.colors.accentPrimary;
    } else if (_hovered) {
      textColor = widget.colors.textOnDark;
      indicatorColor = null;
    } else {
      textColor = widget.colors.textMuted;
      indicatorColor = null;
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.tab.icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: textColor,
              size: 16.0,
            ),
            child: widget.tab.icon!,
          ),
          SizedBox(width: widget.spacing.spacingBase),
        ],
        Text(
          widget.tab.label,
          style: typography.labelMono.copyWith(
            color: textColor,
            fontSize: 12.0,
            fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
        if (widget.tab.badge != null) ...[
          SizedBox(width: widget.spacing.spacingBase),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.spacing.spacingBase / 2,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              color: widget.colors.accentPrimary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.tab.badge!,
              style: typography.labelMono.copyWith(
                color: widget.colors.textOnAccent,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );

    if (widget.axis == Axis.horizontal) {
      return MouseRegion(
        onEnter: widget.tab.enabled ? (_) => setState(() => _hovered = true) : null,
        onExit: widget.tab.enabled ? (_) => setState(() => _hovered = false) : null,
        cursor: widget.tab.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.tab.enabled ? widget.onTap : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.spacing.spacingBase * 2,
              vertical: widget.spacing.spacingBase * 1.5,
            ),
            decoration: BoxDecoration(
              border: indicatorColor != null
                  ? Border(
                      bottom: BorderSide(
                        color: indicatorColor,
                        width: 3.0,
                      ),
                    )
                  : null,
            ),
            child: content,
          ),
        ),
      );
    } else {
      return MouseRegion(
        onEnter: widget.tab.enabled ? (_) => setState(() => _hovered = true) : null,
        onExit: widget.tab.enabled ? (_) => setState(() => _hovered = false) : null,
        cursor: widget.tab.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.tab.enabled ? widget.onTap : null,
          child: Container(
            padding: EdgeInsets.all(widget.spacing.spacingBase * 2),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? Color.lerp(widget.colors.accentPrimary, widget.colors.surfaceBase, 0.9)
                  : null,
              border: indicatorColor != null
                  ? Border(
                      left: BorderSide(
                        color: indicatorColor,
                        width: 3.0,
                      ),
                    )
                  : null,
            ),
            child: content,
          ),
        ),
      );
    }
  }
}
