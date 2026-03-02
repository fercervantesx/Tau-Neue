import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE progress bar component with tactical terminal aesthetic.
///
/// Linear progress indicator with determinate and indeterminate modes.
/// Supports color variants and optional label display.
///
/// Example:
/// ```dart
/// TauProgressBar(
///   value: 0.65,
///   label: 'UPLOADING: 65%',
/// )
/// ```
class TauProgressBar extends StatefulWidget {
  const TauProgressBar({
    super.key,
    this.value,
    this.label,
    this.height = 8.0,
    this.color,
    this.backgroundColor,
    this.showPercentage = false,
  }) : assert(value == null || (value >= 0.0 && value <= 1.0), 'Value must be between 0.0 and 1.0');

  /// Progress value from 0.0 to 1.0.
  /// If null, shows indeterminate progress animation.
  final double? value;

  /// Optional label text displayed above progress bar.
  final String? label;

  /// Height of the progress bar.
  final double height;

  /// Color of the progress fill.
  /// Defaults to accentPrimary if not specified.
  final Color? color;

  /// Background color of the progress track.
  /// Defaults to surfaceElevated if not specified.
  final Color? backgroundColor;

  /// Whether to show percentage text inline.
  final bool showPercentage;

  @override
  State<TauProgressBar> createState() => _TauProgressBarState();
}

class _TauProgressBarState extends State<TauProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(TauProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && oldWidget.value != null) {
      _controller.repeat();
    } else if (widget.value != null && oldWidget.value == null) {
      _controller.stop();
    }
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
    final effectiveBackgroundColor =
        widget.backgroundColor ?? colors.surfaceElevated;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: typography.labelMono.copyWith(
              color: colors.textOnDark,
              fontSize: 11.0,
            ),
          ),
          SizedBox(height: spacing.spacingBase),
        ],
        // Progress bar
        Row(
          children: [
            Expanded(
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: effectiveBackgroundColor,
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  border: Border.all(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  child: widget.value != null
                      ? _buildDeterminate(effectiveColor)
                      : _buildIndeterminate(effectiveColor),
                ),
              ),
            ),
            // Percentage text
            if (widget.showPercentage && widget.value != null) ...[
              SizedBox(width: spacing.spacingBase),
              SizedBox(
                width: 40.0,
                child: Text(
                  '${(widget.value! * 100).toInt()}%',
                  style: typography.bodyMono.copyWith(
                    color: colors.textOnDark,
                    fontSize: 11.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDeterminate(Color color) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widget.value,
      child: Container(
        color: color,
      ),
    );
  }

  Widget _buildIndeterminate(Color color) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Create a sweeping animation across the bar
        // Segment goes from -0.3 to 1.0 (fully offscreen left to fully offscreen right)
        final t = _animation.value;
        final segmentWidth = 0.3; // 30% width segment
        final start = (t * 1.3) - 0.3; // Start at -0.3 (offscreen left), end at 1.0 (offscreen right)
        final end = start + segmentWidth;

        // Only render the visible portion
        final visibleStart = start.clamp(0.0, 1.0);
        final visibleEnd = end.clamp(0.0, 1.0);
        final visibleWidth = visibleEnd - visibleStart;

        if (visibleWidth <= 0.0) {
          return const SizedBox.shrink();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            return Stack(
              children: [
                Positioned(
                  left: visibleStart * barWidth,
                  width: visibleWidth * barWidth,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    color: color,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
