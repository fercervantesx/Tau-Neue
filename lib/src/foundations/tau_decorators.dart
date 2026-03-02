import 'package:flutter/widgets.dart';

/// Corner bracket decorator for cards and containers.
///
/// Draws L-shaped brackets at specified corners to add visual detail.
/// Commonly used on cards, panels, and interactive elements.
class TauCornerBracket extends StatelessWidget {
  const TauCornerBracket({
    super.key,
    required this.color,
    this.size = 8.0,
    this.strokeWidth = 1.0,
    this.corners = const {
      Corner.topLeft,
      Corner.topRight,
      Corner.bottomLeft,
      Corner.bottomRight,
    },
  });

  final Color color;
  final double size;
  final double strokeWidth;
  final Set<Corner> corners;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CornerBracketPainter(
        color: color,
        size: size,
        strokeWidth: strokeWidth,
        corners: corners,
      ),
      child: const SizedBox.expand(),
    );
  }
}

/// Corner positions for decorators.
enum Corner {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class _CornerBracketPainter extends CustomPainter {
  const _CornerBracketPainter({
    required this.color,
    required this.size,
    required this.strokeWidth,
    required this.corners,
  });

  final Color color;
  final double size;
  final double strokeWidth;
  final Set<Corner> corners;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;

    // Top-left bracket
    if (corners.contains(Corner.topLeft)) {
      canvas.drawPath(
        Path()
          ..moveTo(0, size)
          ..lineTo(0, 0)
          ..lineTo(size, 0),
        paint,
      );
    }

    // Top-right bracket
    if (corners.contains(Corner.topRight)) {
      canvas.drawPath(
        Path()
          ..moveTo(canvasSize.width - size, 0)
          ..lineTo(canvasSize.width, 0)
          ..lineTo(canvasSize.width, size),
        paint,
      );
    }

    // Bottom-right bracket
    if (corners.contains(Corner.bottomRight)) {
      canvas.drawPath(
        Path()
          ..moveTo(canvasSize.width, canvasSize.height - size)
          ..lineTo(canvasSize.width, canvasSize.height)
          ..lineTo(canvasSize.width - size, canvasSize.height),
        paint,
      );
    }

    // Bottom-left bracket
    if (corners.contains(Corner.bottomLeft)) {
      canvas.drawPath(
        Path()
          ..moveTo(size, canvasSize.height)
          ..lineTo(0, canvasSize.height)
          ..lineTo(0, canvasSize.height - size),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CornerBracketPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.size != size ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.corners != corners;
  }
}

/// Small status indicator dot.
///
/// Used for visual emphasis, status indicators, or decorative purposes.
class TauStatusDot extends StatelessWidget {
  const TauStatusDot({
    super.key,
    required this.color,
    this.size = 4.0,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Decorative divider line.
///
/// Thin separator line for visual hierarchy and section separation.
class TauDivider extends StatelessWidget {
  const TauDivider({
    super.key,
    required this.color,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness,
      margin: EdgeInsets.only(left: indent, right: endIndent),
      color: color,
    );
  }
}
