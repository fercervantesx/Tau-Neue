import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE sidebar component with tactical terminal aesthetic.
///
/// Collapsible sidebar navigation for application layouts.
/// Supports expanded/collapsed states with smooth transitions.
///
/// Example:
/// ```dart
/// TauSidebar(
///   isExpanded: _isExpanded,
///   currentItemId: 'missions',
///   items: [
///     TauSidebarItem(
///       id: 'dashboard',
///       label: 'DASHBOARD',
///       icon: Icon(Icons.dashboard),
///     ),
///     TauSidebarItem(
///       id: 'missions',
///       label: 'MISSIONS',
///       icon: Icon(Icons.assignment),
///     ),
///   ],
///   onItemSelected: (id) => navigateTo(id),
///   onToggle: () => setState(() => _isExpanded = !_isExpanded),
/// )
/// ```
class TauSidebar extends StatefulWidget {
  const TauSidebar({
    super.key,
    required this.items,
    this.isExpanded = true,
    this.currentItemId,
    this.onItemSelected,
    this.onToggle,
    this.expandedWidth = 240.0,
    this.collapsedWidth = 64.0,
    this.header,
    this.footer,
    this.showHeaderDivider = true,
  });

  /// List of sidebar items.
  final List<TauSidebarItem> items;

  /// Whether the sidebar is expanded.
  final bool isExpanded;

  /// Currently selected item ID.
  final String? currentItemId;

  /// Callback when item is selected.
  final ValueChanged<String>? onItemSelected;

  /// Callback when sidebar is toggled.
  final VoidCallback? onToggle;

  /// Width when expanded.
  final double expandedWidth;

  /// Width when collapsed.
  final double collapsedWidth;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Whether to show divider below header.
  final bool showHeaderDivider;

  @override
  State<TauSidebar> createState() => _TauSidebarState();
}

class _TauSidebarState extends State<TauSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _updateAnimation();

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(TauSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    if (oldWidget.expandedWidth != widget.expandedWidth ||
        oldWidget.collapsedWidth != widget.collapsedWidth) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    _widthAnimation = Tween<double>(
      begin: widget.collapsedWidth,
      end: widget.expandedWidth,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));
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

    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        final currentWidth = _widthAnimation.value;
        final isTransitioning = _controller.isAnimating;
        final showLabels = widget.isExpanded || isTransitioning;

        return Container(
          width: currentWidth,
          decoration: BoxDecoration(
            color: colors.surfaceBase,
            border: Border(
              right: BorderSide(
                color: colors.borderSubtle,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            children: [
              // Header
              if (widget.header != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spacing.spacingBase * 2),
                      alignment: Alignment.centerLeft,
                      child: widget.header,
                    ),
                    if (widget.showHeaderDivider)
                      Container(
                        height: 1.0,
                        color: colors.borderSubtle,
                      ),
                  ],
                ),

              // Navigation items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: spacing.spacingBase),
                  children: widget.items
                      .map((item) => _TauSidebarItemWidget(
                            item: item,
                            isSelected: item.id == widget.currentItemId,
                            isExpanded: widget.isExpanded,
                            showLabels: showLabels,
                            onTap: widget.onItemSelected != null
                                ? () => widget.onItemSelected!(item.id)
                                : null,
                            colors: colors,
                            spacing: spacing,
                            typography: typography,
                          ))
                      .toList(),
                ),
              ),

              // Toggle button
              if (widget.onToggle != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colors.borderSubtle,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: _TauSidebarToggleButton(
                    isExpanded: widget.isExpanded,
                    onToggle: widget.onToggle!,
                    colors: colors,
                    spacing: spacing,
                  ),
                ),

              // Footer
              if (widget.footer != null)
                Container(
                  padding: EdgeInsets.all(spacing.spacingBase * 2),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colors.borderSubtle,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: widget.footer,
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Configuration for a sidebar item.
class TauSidebarItem {
  const TauSidebarItem({
    required this.id,
    required this.label,
    this.icon,
    this.badge,
    this.enabled = true,
  });

  /// Unique identifier for this item.
  final String id;

  /// Display label.
  final String label;

  /// Optional icon (recommended for collapsed mode).
  final Widget? icon;

  /// Optional badge text.
  final String? badge;

  /// Whether this item is enabled.
  final bool enabled;
}

/// Internal sidebar item widget.
class _TauSidebarItemWidget extends StatefulWidget {
  const _TauSidebarItemWidget({
    required this.item,
    required this.isSelected,
    required this.isExpanded,
    required this.showLabels,
    required this.onTap,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauSidebarItem item;
  final bool isSelected;
  final bool isExpanded;
  final bool showLabels;
  final VoidCallback? onTap;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  State<_TauSidebarItemWidget> createState() => _TauSidebarItemWidgetState();
}

class _TauSidebarItemWidgetState extends State<_TauSidebarItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onTap != null && widget.item.enabled;

    // Determine colors
    Color backgroundColor;
    Color textColor;

    if (!widget.item.enabled) {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
    } else if (widget.isSelected) {
      backgroundColor = Color.lerp(
        widget.colors.accentPrimary,
        widget.colors.surfaceBase,
        0.85,
      )!;
      textColor = widget.colors.accentPrimary;
    } else if (_hovered) {
      backgroundColor = widget.colors.surfaceElevated;
      textColor = widget.colors.textOnDark;
    } else {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
    }

    final content = Container(
      margin: EdgeInsets.only(
        top: widget.spacing.spacingBase / 4,
        bottom: widget.spacing.spacingBase / 4,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isExpanded ? widget.spacing.spacingBase * 2 : widget.spacing.spacingBase,
        vertical: widget.spacing.spacingBase * 1.5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: widget.isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          // Icon
          if (widget.item.icon != null)
            IconTheme(
              data: IconThemeData(
                color: textColor,
                size: 20.0,
              ),
              child: widget.item.icon!,
            ),

          // Label (with fade transition)
          if (widget.showLabels) ...{
            if (widget.item.icon != null) SizedBox(width: widget.spacing.spacingBase * 1.5),
            Expanded(
              child: Opacity(
                opacity: widget.isExpanded ? 1.0 : 0.0,
                child: Text(
                  widget.item.label,
                  style: widget.typography.labelMono.copyWith(
                    color: textColor,
                    fontSize: 12.0,
                    fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          },

          // Badge
          if (widget.item.badge != null && widget.isExpanded) ...{
            SizedBox(width: widget.spacing.spacingBase),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.spacing.spacingBase,
                vertical: widget.spacing.spacingBase / 2,
              ),
              decoration: BoxDecoration(
                color: widget.colors.accentPrimary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.item.badge!,
                style: widget.typography.labelMono.copyWith(
                  color: widget.colors.textOnAccent,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          },
        ],
      ),
    );

    if (!isInteractive) {
      return content;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: content,
      ),
    );
  }
}

/// Internal toggle button widget.
class _TauSidebarToggleButton extends StatefulWidget {
  const _TauSidebarToggleButton({
    required this.isExpanded,
    required this.onToggle,
    required this.colors,
    required this.spacing,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauSidebarToggleButton> createState() => _TauSidebarToggleButtonState();
}

class _TauSidebarToggleButtonState extends State<_TauSidebarToggleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovered ? widget.colors.textOnDark : widget.colors.textMuted;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: Container(
          padding: EdgeInsets.all(widget.spacing.spacingBase * 2),
          child: Center(
            child: Icon(
              widget.isExpanded
                  ? const IconData(0xe5c4, fontFamily: 'MaterialIcons') // chevron_left
                  : const IconData(0xe5c8, fontFamily: 'MaterialIcons'), // chevron_right
              color: color,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
