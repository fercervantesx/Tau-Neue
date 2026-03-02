import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';
import '../foundations/tokens/tau_motion_tokens.dart';

/// TAU NEUE navigation bar component.
///
/// Bottom-mounted navigation with geometric reticle active states.
/// Snap transitions using snapMechanical duration (150ms).
class TauNavBar extends StatelessWidget {
  const TauNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.height = 64.0,
  });

  final List<TauNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    final effectiveBackgroundColor = backgroundColor ?? colors.surfaceBase;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          top: BorderSide(
            color: colors.borderSubtle,
            width: spacing.strokeWeightBase,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          return Expanded(
            child: _NavBarItemWidget(
              item: items[index],
              isActive: index == currentIndex,
              onTap: () => onTap(index),
            ),
          );
        }),
      ),
    );
  }
}

/// Navigation bar item data.
class TauNavBarItem {
  const TauNavBarItem({
    required this.icon,
    required this.label,
  });

  final Widget icon;
  final String label;
}

/// Internal widget for rendering navigation bar items.
class _NavBarItemWidget extends StatelessWidget {
  const _NavBarItemWidget({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final TauNavBarItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);
    final motion = TauTheme.motionOf(context);

    // Inverted colors: active = green bg/black text, inactive = black bg/green text
    final backgroundColor = isActive ? colors.accentPrimary : colors.surfaceBase;
    final foregroundColor = isActive ? colors.textOnAccent : colors.accentPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: motion.snapMechanical,
        curve: TauCurves.mechanical,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32.0,
              height: 32.0,
              child: Center(
                child: IconTheme(
                  data: IconThemeData(
                    color: foregroundColor,
                    size: 24.0,
                  ),
                  child: item.icon,
                ),
              ),
            ),
            SizedBox(height: spacing.spacingMicro),
            AnimatedDefaultTextStyle(
              duration: motion.snapMechanical,
              style: typography.dataMono.copyWith(
                color: foregroundColor,
                fontSize: 10.0,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}
