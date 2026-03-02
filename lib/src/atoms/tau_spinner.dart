import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE spinner component with tactical terminal aesthetic.
///
/// Rotating loading indicator with size variants.
/// Optimized for 120fps performance.
///
/// Example:
/// ```dart
/// TauSpinner(
///   size: TauSpinnerSize.medium,
///   label: 'LOADING...',
/// )
/// ```
class TauSpinner extends StatefulWidget {
  const TauSpinner({
    super.key,
    this.size = TauSpinnerSize.medium,
    this.color,
    this.label,
  });

  /// Size variant for the spinner.
  final TauSpinnerSize size;

  /// Color of the spinner.
  /// Defaults to accentPrimary if not specified.
  final Color? color;

  /// Optional label text displayed below spinner.
  final String? label;

  @override
  State<TauSpinner> createState() => _TauSpinnerState();
}

class _TauSpinnerState extends State<TauSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
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

    final effectiveColor = widget.color ?? colors.accentPrimary;

    double spinnerSize;
    switch (widget.size) {
      case TauSpinnerSize.small:
        spinnerSize = 16.0;
        break;
      case TauSpinnerSize.medium:
        spinnerSize = 32.0;
        break;
      case TauSpinnerSize.large:
        spinnerSize = 48.0;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * math.pi,
                child: CustomPaint(
                  size: Size(spinnerSize, spinnerSize),
                  painter: _SpinnerPainter(
                    color: effectiveColor,
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.label != null) ...[
          SizedBox(height: spacing.spacingBase),
          Text(
            widget.label!,
            style: typography.labelMono.copyWith(
              color: colors.textMuted,
              fontSize: 11.0,
            ),
          ),
        ],
      ],
    );
  }
}

/// Size variants for spinner.
enum TauSpinnerSize {
  /// Small spinner (16px).
  small,

  /// Medium spinner (32px).
  medium,

  /// Large spinner (48px).
  large,
}

/// Custom painter for spinner geometry.
class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.125 // 12.5% of size
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - paint.strokeWidth) / 2;

    // Draw arc (270 degrees, leaving 90 degree gap)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start at top
      math.pi * 1.5, // 270 degrees
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SpinnerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
