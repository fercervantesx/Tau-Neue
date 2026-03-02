import 'package:flutter/material.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE app bar component.
///
/// Oversized header (120px) with typography-led design and optional
/// continuous scrolling ticker tape along bottom edge.
class TauAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TauAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.tickerText,
    this.backgroundColor,
    this.height = 120.0,
  });

  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final String? tickerText;
  final Color? backgroundColor;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final effectiveBackgroundColor = backgroundColor ?? colors.surfaceBase;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: spacing.strokeWeightBase,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.spacingBase * 2,
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: spacing.spacingBase * 2),
                  ],
                  Expanded(
                    child: DefaultTextStyle(
                      style: typography.titleSerif.copyWith(
                        color: colors.textOnDark,
                        fontSize: 36.0,
                      ),
                      child: title,
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ),
          if (tickerText != null)
            RepaintBoundary(
              child: _TickerTape(
                text: tickerText!,
                textColor: colors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

/// Continuous scrolling ticker tape widget.
class _TickerTape extends StatefulWidget {
  const _TickerTape({
    required this.text,
    required this.textColor,
  });

  final String text;
  final Color textColor;

  @override
  State<_TickerTape> createState() => _TickerTapeState();
}

class _TickerTapeState extends State<_TickerTape>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = TauTheme.typographyOf(context);

    return SizedBox(
      height: 24.0,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    widget.text,
                    style: typography.dataMono.copyWith(
                      color: widget.textColor,
                      fontSize: 12.0,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
