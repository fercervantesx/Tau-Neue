import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE drawer component with tactical terminal aesthetic.
///
/// Side panel overlay that slides in from screen edges.
/// Supports all four directions with backdrop blur.
///
/// Example:
/// ```dart
/// showTauDrawer(
///   context: context,
///   direction: TauDrawerDirection.right,
///   builder: (context) => TauDrawer(
///     header: Text('SETTINGS'),
///     body: SettingsContent(),
///   ),
/// )
/// ```
class TauDrawer extends StatelessWidget {
  const TauDrawer({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.width,
    this.height,
  });

  /// Optional header widget.
  final Widget? header;

  /// Body content (required).
  final Widget body;

  /// Optional footer widget.
  final Widget? footer;

  /// Width for left/right drawers.
  /// Defaults to 400.0.
  final double? width;

  /// Height for top/bottom drawers.
  /// Defaults to 400.0.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          if (header != null)
            Container(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                ),
              ),
              child: header,
            ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              child: body,
            ),
          ),

          // Footer
          if (footer != null)
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
              child: footer,
            ),
        ],
      ),
    );
  }
}

/// Direction from which the drawer slides in.
enum TauDrawerDirection {
  left,
  right,
  top,
  bottom,
}

/// Helper function to show a drawer overlay.
void showTauDrawer({
  required BuildContext context,
  required WidgetBuilder builder,
  TauDrawerDirection direction = TauDrawerDirection.right,
  double? width,
  double? height,
  bool barrierDismissible = true,
  VoidCallback? onClose,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  void dismiss() {
    entry.remove();
    if (onClose != null) {
      onClose();
    }
  }

  entry = OverlayEntry(
    builder: (context) => _TauDrawerOverlay(
      direction: direction,
      width: width ?? 400.0,
      height: height ?? 400.0,
      barrierDismissible: barrierDismissible,
      onDismiss: dismiss,
      child: builder(context),
    ),
  );

  overlay.insert(entry);
}

/// Internal drawer overlay widget with animation.
class _TauDrawerOverlay extends StatefulWidget {
  const _TauDrawerOverlay({
    required this.direction,
    required this.width,
    required this.height,
    required this.barrierDismissible,
    required this.onDismiss,
    required this.child,
  });

  final TauDrawerDirection direction;
  final double width;
  final double height;
  final bool barrierDismissible;
  final VoidCallback onDismiss;
  final Widget child;

  @override
  State<_TauDrawerOverlay> createState() => _TauDrawerOverlayState();
}

class _TauDrawerOverlayState extends State<_TauDrawerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));

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

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Calculate slide offset based on direction
        Offset slideOffset;
        switch (widget.direction) {
          case TauDrawerDirection.left:
            slideOffset = Offset(-1.0 + _slideAnimation.value, 0.0);
            break;
          case TauDrawerDirection.right:
            slideOffset = Offset(1.0 - _slideAnimation.value, 0.0);
            break;
          case TauDrawerDirection.top:
            slideOffset = Offset(0.0, -1.0 + _slideAnimation.value);
            break;
          case TauDrawerDirection.bottom:
            slideOffset = Offset(0.0, 1.0 - _slideAnimation.value);
            break;
        }

        return Stack(
          children: [
            // Backdrop with blur
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.barrierDismissible ? _dismiss : null,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: 3.0,
                      sigmaY: 3.0,
                    ),
                    child: Container(
                      color: const Color(0x40000000),
                    ),
                  ),
                ),
              ),
            ),

            // Drawer panel
            Positioned(
              left: widget.direction == TauDrawerDirection.left ? 0.0 : null,
              right: widget.direction == TauDrawerDirection.right ? 0.0 : null,
              top: widget.direction == TauDrawerDirection.top ? 0.0 : null,
              bottom: widget.direction == TauDrawerDirection.bottom ? 0.0 : null,
              child: FractionalTranslation(
                translation: slideOffset,
                child: Container(
                  width: (widget.direction == TauDrawerDirection.left ||
                          widget.direction == TauDrawerDirection.right)
                      ? widget.width
                      : null,
                  height: (widget.direction == TauDrawerDirection.top ||
                          widget.direction == TauDrawerDirection.bottom)
                      ? widget.height
                      : null,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
