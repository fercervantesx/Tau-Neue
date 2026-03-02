import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Material;
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE popover component with tactical terminal aesthetic.
///
/// Floating content container that positions relative to a target.
/// Supports multiple positioning options with arrow pointer.
///
/// Example:
/// ```dart
/// TauPopover(
///   position: TauPopoverPosition.bottom,
///   content: Text('Popover content'),
///   child: TauButton(
///     label: 'SHOW POPOVER',
///     onPressed: () {},
///   ),
/// )
/// ```
class TauPopover extends StatefulWidget {
  const TauPopover({
    super.key,
    required this.content,
    required this.child,
    this.position = TauPopoverPosition.bottom,
    this.width,
    this.showArrow = true,
  });

  /// Content to display in the popover.
  final Widget content;

  /// Target widget that triggers the popover.
  final Widget child;

  /// Position of popover relative to target.
  final TauPopoverPosition position;

  /// Width of the popover.
  /// If null, sizes to content.
  final double? width;

  /// Whether to show arrow pointer.
  final bool showArrow;

  @override
  State<TauPopover> createState() => _TauPopoverState();
}

class _TauPopoverState extends State<TauPopover> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _togglePopover() {
    if (_isOpen) {
      _closePopover();
    } else {
      _openPopover();
    }
  }

  void _openPopover() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closePopover() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => _TauPopoverOverlay(
        layerLink: _layerLink,
        content: widget.content,
        position: widget.position,
        width: widget.width,
        showArrow: widget.showArrow,
        onDismiss: _closePopover,
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
        onTap: _togglePopover,
        child: widget.child,
      ),
    );
  }
}

/// Position options for the popover.
enum TauPopoverPosition {
  top,
  bottom,
  left,
  right,
}

/// Internal popover overlay widget.
class _TauPopoverOverlay extends StatefulWidget {
  const _TauPopoverOverlay({
    required this.layerLink,
    required this.content,
    required this.position,
    required this.width,
    required this.showArrow,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final Widget content;
  final TauPopoverPosition position;
  final double? width;
  final bool showArrow;
  final VoidCallback onDismiss;

  @override
  State<_TauPopoverOverlay> createState() => _TauPopoverOverlayState();
}

class _TauPopoverOverlayState extends State<_TauPopoverOverlay>
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

    // Calculate offset based on position
    Offset offset;
    Alignment followerAnchor;
    Alignment targetAnchor;

    const arrowSize = 8.0;
    final gap = widget.showArrow ? arrowSize + 4.0 : 4.0;

    switch (widget.position) {
      case TauPopoverPosition.top:
        offset = Offset(0, -gap);
        followerAnchor = Alignment.bottomCenter;
        targetAnchor = Alignment.topCenter;
        break;
      case TauPopoverPosition.bottom:
        offset = Offset(0, gap);
        followerAnchor = Alignment.topCenter;
        targetAnchor = Alignment.bottomCenter;
        break;
      case TauPopoverPosition.left:
        offset = Offset(-gap, 0);
        followerAnchor = Alignment.centerRight;
        targetAnchor = Alignment.centerLeft;
        break;
      case TauPopoverPosition.right:
        offset = Offset(gap, 0);
        followerAnchor = Alignment.centerLeft;
        targetAnchor = Alignment.centerRight;
        break;
    }

    return Stack(
      children: [
        // Backdrop (invisible but tappable)
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: Container(color: const Color(0x00000000)),
          ),
        ),

        // Popover content
        CompositedTransformFollower(
          link: widget.layerLink,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          offset: offset,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              color: const Color(0x00000000),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Arrow (top position)
                  if (widget.showArrow && widget.position == TauPopoverPosition.bottom)
                    CustomPaint(
                      size: const Size(16.0, 8.0),
                      painter: _ArrowPainter(
                        color: colors.surfaceElevated,
                        borderColor: colors.borderSubtle,
                        direction: _ArrowDirection.up,
                      ),
                    ),

                  // Content container
                  Container(
                    width: widget.width,
                    padding: EdgeInsets.all(spacing.spacingBase * 2),
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
                    child: widget.content,
                  ),

                  // Arrow (bottom position)
                  if (widget.showArrow && widget.position == TauPopoverPosition.top)
                    CustomPaint(
                      size: const Size(16.0, 8.0),
                      painter: _ArrowPainter(
                        color: colors.surfaceElevated,
                        borderColor: colors.borderSubtle,
                        direction: _ArrowDirection.down,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Arrow direction for the popover pointer.
enum _ArrowDirection {
  up,
  down,
  left,
  right,
}

/// Custom painter for popover arrow.
class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({
    required this.color,
    required this.borderColor,
    required this.direction,
  });

  final Color color;
  final Color borderColor;
  final _ArrowDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path;
    switch (direction) {
      case _ArrowDirection.up:
        path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        break;
      case _ArrowDirection.down:
        path = Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width / 2, size.height)
          ..close();
        break;
      case _ArrowDirection.left:
        path = Path()
          ..moveTo(0, size.height / 2)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..close();
        break;
      case _ArrowDirection.right:
        path = Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(0, size.height)
          ..close();
        break;
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) =>
      color != oldDelegate.color ||
      borderColor != oldDelegate.borderColor ||
      direction != oldDelegate.direction;
}
