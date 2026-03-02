import 'package:flutter/widgets.dart';

/// Optimized container with rounded corners for tactical terminal aesthetic.
///
/// Replaces standard Flutter Container for TAU NEUE components.
/// Uses simple BoxDecoration with BorderRadius for clean rectangular geometry.
///
/// Example:
/// ```dart
/// TauContainer(
///   width: 200,
///   height: 100,
///   borderRadius: 6.0,
///   backgroundColor: Colors.black,
///   borderColor: Colors.green,
///   child: Text('TAU NEUE'),
/// )
/// ```
class TauContainer extends StatelessWidget {
  const TauContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.strokeWidth = 1.0,
    this.borderRadius = 6.0,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double strokeWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: strokeWidth,
              )
            : null,
      ),
      child: child,
    );
  }
}
