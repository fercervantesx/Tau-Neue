import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE stats panel component with tactical terminal aesthetic.
///
/// Displays key metrics with optional change indicators and trends.
/// Supports single stat or grid of multiple stats.
///
/// Example:
/// ```dart
/// TauStatCard(
///   label: 'ACTIVE MISSIONS',
///   value: '247',
///   change: '+12.5%',
///   trend: TauStatTrend.up,
/// )
/// ```
class TauStatCard extends StatelessWidget {
  const TauStatCard({
    super.key,
    required this.label,
    required this.value,
    this.change,
    this.trend = TauStatTrend.neutral,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  /// Label text for the stat.
  final String label;

  /// Primary value to display.
  final String value;

  /// Optional change indicator (e.g., "+12.5%", "-3").
  final String? change;

  /// Trend direction for color coding.
  final TauStatTrend trend;

  /// Optional icon widget.
  final Widget? icon;

  /// Whether to show loading state.
  final bool isLoading;

  /// Optional fixed width.
  final double? width;

  /// Optional fixed height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // Determine change color based on trend
    Color changeColor;
    switch (trend) {
      case TauStatTrend.up:
        changeColor = colors.accentPrimary;
        break;
      case TauStatTrend.down:
        changeColor = colors.accentCritical;
        break;
      case TauStatTrend.neutral:
        changeColor = colors.textMuted;
        break;
    }

    Widget content;

    if (isLoading) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Loading skeleton for label
          Container(
            width: 80.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          SizedBox(height: spacing.spacingBase),
          // Loading skeleton for value
          Container(
            width: 120.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ],
      );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label with optional icon
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: colors.textMuted,
                    size: 16.0,
                  ),
                  child: icon!,
                ),
                SizedBox(width: spacing.spacingBase),
              ],
              Flexible(
                child: Text(
                  label,
                  style: typography.labelMono.copyWith(
                    color: colors.textMuted,
                    fontSize: 11.0,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing.spacingBase),
          // Value
          Text(
            value,
            style: typography.headingSerif.copyWith(
              color: colors.textOnDark,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          // Change indicator
          if (change != null) ...[
            SizedBox(height: spacing.spacingBase / 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trend != TauStatTrend.neutral)
                  CustomPaint(
                    size: const Size(8.0, 8.0),
                    painter: _TrendArrowPainter(
                      color: changeColor,
                      direction: trend == TauStatTrend.up
                          ? _TrendDirection.up
                          : _TrendDirection.down,
                    ),
                  ),
                if (trend != TauStatTrend.neutral)
                  SizedBox(width: spacing.spacingBase / 2),
                Text(
                  change!,
                  style: typography.bodyMono.copyWith(
                    color: changeColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    }

    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(
        minWidth: 160.0,
      ),
      padding: EdgeInsets.all(spacing.spacingBase * 2),
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: content,
    );
  }
}

/// Trend direction for stat change.
enum TauStatTrend {
  /// Positive trend (green).
  up,

  /// Negative trend (red).
  down,

  /// No trend (grey).
  neutral,
}

/// TAU NEUE stats grid component for displaying multiple metrics.
///
/// Organizes multiple stat cards in a responsive grid layout.
///
/// Example:
/// ```dart
/// TauStatsGrid(
///   stats: [
///     TauStatCard(label: 'MISSIONS', value: '247'),
///     TauStatCard(label: 'OPERATORS', value: '89'),
///     TauStatCard(label: 'SUCCESS RATE', value: '94%'),
///   ],
/// )
/// ```
class TauStatsGrid extends StatelessWidget {
  const TauStatsGrid({
    super.key,
    required this.stats,
    this.columns = 3,
    this.spacing = 16.0,
  });

  /// List of stat cards to display.
  final List<TauStatCard> stats;

  /// Number of columns in grid.
  final int columns;

  /// Spacing between cards.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < stats.length; i += columns) {
      final rowStats = stats.skip(i).take(columns).toList();
      final rowChildren = <Widget>[];

      for (int j = 0; j < rowStats.length; j++) {
        rowChildren.add(Expanded(child: rowStats[j]));
        if (j < rowStats.length - 1) {
          rowChildren.add(SizedBox(width: spacing));
        }
      }

      // Fill remaining columns with empty space
      final remaining = columns - rowStats.length;
      for (int k = 0; k < remaining; k++) {
        if (rowChildren.isNotEmpty) {
          rowChildren.add(SizedBox(width: spacing));
        }
        rowChildren.add(const Expanded(child: SizedBox()));
      }

      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      ));

      if (i + columns < stats.length) {
        rows.add(SizedBox(height: spacing));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

/// Direction for trend arrow icon.
enum _TrendDirection { up, down }

/// Custom painter for trend arrow icon.
class _TrendArrowPainter extends CustomPainter {
  _TrendArrowPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final _TrendDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    if (direction == _TrendDirection.up) {
      // Up arrow
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else {
      // Down arrow
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrendArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}
