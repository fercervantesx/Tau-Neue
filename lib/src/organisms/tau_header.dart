import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE header component with tactical terminal aesthetic.
///
/// Top header layout with flexible slot-based positioning.
/// Supports left/center/right content areas.
///
/// Example:
/// ```dart
/// TauHeader(
///   left: Icon(Icons.menu),
///   center: Text('DASHBOARD'),
///   right: Row(
///     children: [
///       IconButton(...),
///       TauAvatar(...),
///     ],
///   ),
/// )
/// ```
class TauHeader extends StatelessWidget {
  const TauHeader({
    super.key,
    this.left,
    this.center,
    this.right,
    this.height = 64.0,
    this.showBorder = true,
  });

  /// Left slot content.
  final Widget? left;

  /// Center slot content.
  final Widget? center;

  /// Right slot content.
  final Widget? right;

  /// Header height.
  final double height;

  /// Whether to show bottom border.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: colors.borderSubtle,
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.spacingBase * 3),
        child: Row(
          children: [
            // Left section
            if (left != null) ...[
              left!,
              SizedBox(width: spacing.spacingBase * 2),
            ],

            // Center section
            if (center != null) Expanded(child: Center(child: center!)),

            // Right section
            if (right != null) ...[
              SizedBox(width: spacing.spacingBase * 2),
              right!,
            ],
          ],
        ),
      ),
    );
  }
}
