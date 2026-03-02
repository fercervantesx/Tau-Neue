import 'dart:async';
import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE tooltip component with tactical terminal aesthetic.
///
/// Hover help text that appears after a delay.
/// Simple text display positioned relative to target.
///
/// Example:
/// ```dart
/// TauTooltip(
///   message: 'Click to execute command',
///   child: TauButton(
///     label: 'EXECUTE',
///     onPressed: () {},
///   ),
/// )
/// ```
class TauTooltip extends StatefulWidget {
  const TauTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = TauTooltipPosition.top,
    this.delay = const Duration(milliseconds: 500),
  });

  /// Tooltip message text.
  final String message;

  /// Target widget.
  final Widget child;

  /// Position of tooltip relative to target.
  final TauTooltipPosition position;

  /// Delay before showing tooltip.
  final Duration delay;

  @override
  State<TauTooltip> createState() => _TauTooltipState();
}

class _TauTooltipState extends State<TauTooltip> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _timer;

  void _onEnter(PointerEvent event) {
    _timer = Timer(widget.delay, _showTooltip);
  }

  void _onExit(PointerEvent event) {
    _timer?.cancel();
    _hideTooltip();
  }

  void _showTooltip() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => _TauTooltipOverlay(
        layerLink: _layerLink,
        message: widget.message,
        position: widget.position,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: widget.child,
      ),
    );
  }
}

/// Position options for the tooltip.
enum TauTooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// Internal tooltip overlay widget.
class _TauTooltipOverlay extends StatefulWidget {
  const _TauTooltipOverlay({
    required this.layerLink,
    required this.message,
    required this.position,
  });

  final LayerLink layerLink;
  final String message;
  final TauTooltipPosition position;

  @override
  State<_TauTooltipOverlay> createState() => _TauTooltipOverlayState();
}

class _TauTooltipOverlayState extends State<_TauTooltipOverlay>
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
    final typography = TauTheme.typographyOf(context);

    // Calculate offset based on position
    Offset offset;
    Alignment followerAnchor;
    Alignment targetAnchor;

    const gap = 8.0;

    switch (widget.position) {
      case TauTooltipPosition.top:
        offset = const Offset(0, -gap);
        followerAnchor = Alignment.bottomCenter;
        targetAnchor = Alignment.topCenter;
        break;
      case TauTooltipPosition.bottom:
        offset = const Offset(0, gap);
        followerAnchor = Alignment.topCenter;
        targetAnchor = Alignment.bottomCenter;
        break;
      case TauTooltipPosition.left:
        offset = const Offset(-gap, 0);
        followerAnchor = Alignment.centerRight;
        targetAnchor = Alignment.centerLeft;
        break;
      case TauTooltipPosition.right:
        offset = const Offset(gap, 0);
        followerAnchor = Alignment.centerLeft;
        targetAnchor = Alignment.centerRight;
        break;
    }

    return CompositedTransformFollower(
      link: widget.layerLink,
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      offset: offset,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: IgnorePointer(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 200.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: spacing.spacingBase * 1.5,
              vertical: spacing.spacingBase,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              border: Border.all(
                color: colors.borderSubtle,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              widget.message,
              style: typography.bodyMono.copyWith(
                color: colors.textOnDark,
                fontSize: 11.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
