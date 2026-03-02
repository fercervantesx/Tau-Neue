import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Material;
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE dropdown component with tactical terminal aesthetic.
///
/// Dropdown menu overlay with selectable items.
/// Supports icons, dividers, and disabled states.
///
/// Example:
/// ```dart
/// TauDropdown(
///   items: [
///     TauDropdownItem(
///       label: 'EDIT',
///       icon: Icon(Icons.edit),
///       onTap: () => edit(),
///     ),
///     TauDropdownDivider(),
///     TauDropdownItem(
///       label: 'DELETE',
///       icon: Icon(Icons.delete),
///       onTap: () => delete(),
///     ),
///   ],
///   child: TauButton(label: 'ACTIONS', onPressed: () {}),
/// )
/// ```
class TauDropdown extends StatefulWidget {
  const TauDropdown({
    super.key,
    required this.items,
    required this.child,
    this.width,
  });

  /// List of dropdown items and dividers.
  final List<TauDropdownEntry> items;

  /// Trigger widget.
  final Widget child;

  /// Width of the dropdown menu.
  /// If null, sizes to content with minimum 180px.
  final double? width;

  @override
  State<TauDropdown> createState() => _TauDropdownState();
}

class _TauDropdownState extends State<TauDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => _TauDropdownOverlay(
        layerLink: _layerLink,
        items: widget.items,
        width: widget.width,
        onDismiss: _closeDropdown,
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: widget.child,
      ),
    );
  }
}

/// Base class for dropdown entries.
abstract class TauDropdownEntry {}

/// Dropdown menu item.
class TauDropdownItem extends TauDropdownEntry {
  TauDropdownItem({
    required this.label,
    this.icon,
    this.shortcut,
    this.enabled = true,
    this.onTap,
  });

  /// Item label.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Optional keyboard shortcut display.
  final String? shortcut;

  /// Whether the item is enabled.
  final bool enabled;

  /// Callback when item is tapped.
  final VoidCallback? onTap;
}

/// Dropdown divider.
class TauDropdownDivider extends TauDropdownEntry {}

/// Internal dropdown overlay widget.
class _TauDropdownOverlay extends StatefulWidget {
  const _TauDropdownOverlay({
    required this.layerLink,
    required this.items,
    required this.width,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final List<TauDropdownEntry> items;
  final double? width;
  final VoidCallback onDismiss;

  @override
  State<_TauDropdownOverlay> createState() => _TauDropdownOverlayState();
}

class _TauDropdownOverlayState extends State<_TauDropdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
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

    return Stack(
      children: [
        // Backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: Container(color: const Color(0x00000000)),
          ),
        ),

        // Dropdown menu
        CompositedTransformFollower(
          link: widget.layerLink,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 4),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              color: const Color(0x00000000),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: widget.width ?? 180.0,
                  maxWidth: widget.width ?? 320.0,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceElevated,
                  border: Border.all(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: spacing.spacingBase / 2),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final entry = widget.items[index];
                    if (entry is TauDropdownItem) {
                      return _TauDropdownItemWidget(
                        item: entry,
                        onDismiss: widget.onDismiss,
                        colors: colors,
                        spacing: spacing,
                      );
                    } else if (entry is TauDropdownDivider) {
                      return Container(
                        height: 1.0,
                        margin: EdgeInsets.symmetric(vertical: spacing.spacingBase / 2),
                        color: colors.borderSubtle,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Internal dropdown item widget.
class _TauDropdownItemWidget extends StatefulWidget {
  const _TauDropdownItemWidget({
    required this.item,
    required this.onDismiss,
    required this.colors,
    required this.spacing,
  });

  final TauDropdownItem item;
  final VoidCallback onDismiss;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauDropdownItemWidget> createState() => _TauDropdownItemWidgetState();
}

class _TauDropdownItemWidgetState extends State<_TauDropdownItemWidget> {
  bool _hovered = false;

  void _handleTap() {
    if (widget.item.enabled && widget.item.onTap != null) {
      widget.item.onTap!();
      widget.onDismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final typography = TauTheme.typographyOf(context);

    Color backgroundColor;
    Color textColor;

    if (!widget.item.enabled) {
      backgroundColor = widget.colors.surfaceElevated;
      textColor = widget.colors.textMuted;
    } else if (_hovered) {
      backgroundColor = widget.colors.accentPrimary;
      textColor = widget.colors.textOnAccent;
    } else {
      backgroundColor = widget.colors.surfaceElevated;
      textColor = widget.colors.textMuted;
    }

    return MouseRegion(
      onEnter: widget.item.enabled ? (_) => setState(() => _hovered = true) : null,
      onExit: widget.item.enabled ? (_) => setState(() => _hovered = false) : null,
      cursor: widget.item.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.item.enabled ? _handleTap : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.spacing.spacingBase * 2,
            vertical: widget.spacing.spacingBase,
          ),
          color: backgroundColor,
          child: Row(
            children: [
              // Icon
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

              // Label
              Expanded(
                child: Text(
                  widget.item.label,
                  style: typography.labelMono.copyWith(
                    color: textColor,
                    fontSize: 12.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Shortcut
              if (widget.item.shortcut != null) ...{
                SizedBox(width: widget.spacing.spacingBase),
                Text(
                  widget.item.shortcut!,
                  style: typography.bodyMono.copyWith(
                    color: widget.colors.textMuted,
                    fontSize: 10.0,
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
