import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Material;
import '../foundations/theme/tau_theme.dart';

// Conditional import for web-specific context menu prevention
import '_context_menu_stub.dart'
    if (dart.library.html) '_context_menu_web.dart';

/// TAU NEUE context menu component with tactical terminal aesthetic.
///
/// Right-click menu overlay positioned at cursor location.
/// Supports icons, shortcuts, dividers, and disabled states.
///
/// Example:
/// ```dart
/// TauContextMenu(
///   items: [
///     TauContextMenuItem(
///       label: 'COPY',
///       shortcut: 'Ctrl+C',
///       onTap: () => copy(),
///     ),
///     TauContextMenuDivider(),
///     TauContextMenuItem(
///       label: 'DELETE',
///       onTap: () => delete(),
///     ),
///   ],
///   child: Container(...),
/// )
/// ```
class TauContextMenu extends StatefulWidget {
  const TauContextMenu({
    super.key,
    required this.items,
    required this.child,
    this.width,
  });

  /// List of context menu items.
  final List<TauContextMenuEntry> items;

  /// Target widget.
  final Widget child;

  /// Width of the context menu.
  final double? width;

  @override
  State<TauContextMenu> createState() => _TauContextMenuState();
}

class _TauContextMenuState extends State<TauContextMenu> {
  OverlayEntry? _overlayEntry;
  Offset? _menuPosition;
  static bool _contextMenuInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize context menu prevention once globally
    if (!_contextMenuInitialized) {
      initializeContextMenu();
      _contextMenuInitialized = true;
    }
  }

  void _handleSecondaryTapDown(TapDownDetails details) {
    _showContextMenu(details.globalPosition);
  }

  void _showContextMenu(Offset position) {
    if (_overlayEntry != null) return;

    setState(() => _menuPosition = position);
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeContextMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _menuPosition = null);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => _TauContextMenuOverlay(
        position: _menuPosition!,
        items: widget.items,
        width: widget.width,
        onDismiss: _closeContextMenu,
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
    return GestureDetector(
      onSecondaryTapDown: _handleSecondaryTapDown,
      child: widget.child,
    );
  }
}

/// Base class for context menu entries.
abstract class TauContextMenuEntry {}

/// Context menu item.
class TauContextMenuItem extends TauContextMenuEntry {
  TauContextMenuItem({
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

/// Context menu divider.
class TauContextMenuDivider extends TauContextMenuEntry {}

/// Internal context menu overlay widget.
class _TauContextMenuOverlay extends StatefulWidget {
  const _TauContextMenuOverlay({
    required this.position,
    required this.items,
    required this.width,
    required this.onDismiss,
  });

  final Offset position;
  final List<TauContextMenuEntry> items;
  final double? width;
  final VoidCallback onDismiss;

  @override
  State<_TauContextMenuOverlay> createState() => _TauContextMenuOverlayState();
}

class _TauContextMenuOverlayState extends State<_TauContextMenuOverlay>
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
    final screenSize = MediaQuery.of(context).size;

    // Calculate position to prevent overflow
    final menuWidth = widget.width ?? 200.0;
    final menuHeight = 300.0; // Approximate max height

    // Position menu at cursor
    double left = widget.position.dx;
    double top = widget.position.dy;

    // Prevent horizontal overflow (position to the left of cursor if needed)
    if (left + menuWidth > screenSize.width) {
      left = widget.position.dx - menuWidth;
      // If that would go off the left edge, clamp to edge
      if (left < 8.0) {
        left = 8.0;
      }
    }

    // Prevent vertical overflow (position above cursor if needed)
    if (top + menuHeight > screenSize.height) {
      top = widget.position.dy - menuHeight;
      // If that would go off the top edge, clamp to edge
      if (top < 8.0) {
        top = 8.0;
      }
    }

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: widget.onDismiss,
              behavior: HitTestBehavior.translucent,
              child: Container(color: const Color(0x00000000)),
            ),
          ),

          // Context menu
          Positioned(
            left: left,
            top: top,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: const Color(0x00000000),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: widget.width ?? 180.0,
                    maxWidth: widget.width ?? 240.0,
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
                      if (entry is TauContextMenuItem) {
                        return _TauContextMenuItemWidget(
                          item: entry,
                          onDismiss: widget.onDismiss,
                          colors: colors,
                          spacing: spacing,
                        );
                      } else if (entry is TauContextMenuDivider) {
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
      ),
    );
  }
}

/// Internal context menu item widget.
class _TauContextMenuItemWidget extends StatefulWidget {
  const _TauContextMenuItemWidget({
    required this.item,
    required this.onDismiss,
    required this.colors,
    required this.spacing,
  });

  final TauContextMenuItem item;
  final VoidCallback onDismiss;
  final dynamic colors;
  final dynamic spacing;

  @override
  State<_TauContextMenuItemWidget> createState() => _TauContextMenuItemWidgetState();
}

class _TauContextMenuItemWidgetState extends State<_TauContextMenuItemWidget> {
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
      backgroundColor = widget.colors.surfaceHighlight;
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
