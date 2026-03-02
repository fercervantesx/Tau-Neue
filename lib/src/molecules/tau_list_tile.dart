import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE list tile component.
///
/// High-density row optimized for ListView.builder with RepaintBoundary
/// at root for scroll performance. Compressed padding for dense layouts.
class TauListTile extends StatelessWidget {
  const TauListTile({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.showBorder = false,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final effectiveBackgroundColor = backgroundColor ?? colors.surfaceBase;
    final effectiveBorderColor = borderColor ?? colors.borderSubtle;

    Widget content = Row(
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: spacing.spacingBase),
        ],
        if (title != null)
          Expanded(
            child: DefaultTextStyle(
              style: typography.bodyMono.copyWith(
                color: colors.textOnDark,
              ),
              child: title!,
            ),
          ),
        if (trailing != null) ...[
          SizedBox(width: spacing.spacingBase),
          trailing!,
        ],
      ],
    );

    content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingBase * 2,
        vertical: spacing.spacingMicro, // Compressed vertical padding
      ),
      child: content,
    );

    if (showBorder) {
      content = Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: effectiveBorderColor,
              width: 1.0,
            ),
          ),
        ),
        child: content,
      );
    }

    if (backgroundColor != null) {
      content = ColoredBox(
        color: effectiveBackgroundColor,
        child: content,
      );
    }

    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    // RepaintBoundary at root for optimal list performance
    return RepaintBoundary(
      child: content,
    );
  }
}
