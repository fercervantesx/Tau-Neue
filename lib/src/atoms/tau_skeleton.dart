import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE skeleton component with tactical terminal aesthetic.
///
/// Loading placeholder with shimmer animation effect.
/// Use during content loading to indicate structure.
///
/// Example:
/// ```dart
/// TauSkeletonBox(
///   width: 200,
///   height: 100,
/// )
/// ```
class TauSkeletonBox extends StatefulWidget {
  const TauSkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 6.0,
  });

  /// Width of the skeleton box.
  final double? width;

  /// Height of the skeleton box.
  final double? height;

  /// Border radius of the skeleton box.
  final double borderRadius;

  @override
  State<TauSkeletonBox> createState() => _TauSkeletonBoxState();
}

class _TauSkeletonBoxState extends State<TauSkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
              colors: [
                colors.surfaceElevated,
                Color.lerp(colors.surfaceElevated, colors.borderSubtle, 0.5)!,
                colors.surfaceElevated,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// TAU NEUE circular skeleton component.
///
/// Circular loading placeholder for avatars or circular icons.
///
/// Example:
/// ```dart
/// TauSkeletonCircle(
///   size: 48,
/// )
/// ```
class TauSkeletonCircle extends StatefulWidget {
  const TauSkeletonCircle({
    super.key,
    required this.size,
  });

  /// Diameter of the skeleton circle.
  final double size;

  @override
  State<TauSkeletonCircle> createState() => _TauSkeletonCircleState();
}

class _TauSkeletonCircleState extends State<TauSkeletonCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
              colors: [
                colors.surfaceElevated,
                Color.lerp(colors.surfaceElevated, colors.borderSubtle, 0.5)!,
                colors.surfaceElevated,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// TAU NEUE text skeleton component.
///
/// Text line loading placeholder with automatic sizing.
///
/// Example:
/// ```dart
/// TauSkeletonText(
///   width: 200,
/// )
/// ```
class TauSkeletonText extends StatelessWidget {
  const TauSkeletonText({
    super.key,
    this.width,
    this.height = 12.0,
  });

  /// Width of the text skeleton (null = full width).
  final double? width;

  /// Height of the text skeleton.
  final double height;

  @override
  Widget build(BuildContext context) {
    return TauSkeletonBox(
      width: width,
      height: height,
      borderRadius: height / 2,
    );
  }
}

/// TAU NEUE skeleton group component.
///
/// Pre-composed skeleton layouts for common patterns.
///
/// Example:
/// ```dart
/// TauSkeletonGroup.listTile()
/// ```
class TauSkeletonGroup extends StatelessWidget {
  const TauSkeletonGroup({
    super.key,
    required this.children,
    this.spacing = 8.0,
  });

  /// Factory constructor for list tile skeleton.
  factory TauSkeletonGroup.listTile() {
    return TauSkeletonGroup(
      children: [
        Row(
          children: const [
            TauSkeletonCircle(size: 40.0),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TauSkeletonText(width: 150.0),
                  SizedBox(height: 8.0),
                  TauSkeletonText(width: 100.0, height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Factory constructor for card skeleton.
  factory TauSkeletonGroup.card() {
    return TauSkeletonGroup(
      spacing: 12.0,
      children: const [
        TauSkeletonText(width: 120.0, height: 16.0),
        TauSkeletonBox(height: 120.0),
        TauSkeletonText(width: double.infinity),
        TauSkeletonText(width: 200.0),
      ],
    );
  }

  /// Factory constructor for stat card skeleton.
  factory TauSkeletonGroup.statCard() {
    return TauSkeletonGroup(
      spacing: 8.0,
      children: const [
        TauSkeletonText(width: 80.0, height: 10.0),
        TauSkeletonText(width: 120.0, height: 24.0),
        TauSkeletonText(width: 60.0, height: 10.0),
      ],
    );
  }

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: spacedChildren,
    );
  }
}
