import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE description list component with tactical terminal aesthetic.
///
/// Displays key-value pairs in a structured format.
/// Supports horizontal and vertical layouts with optional dividers.
///
/// Example:
/// ```dart
/// TauDescriptionList(
///   items: [
///     TauDescriptionItem(
///       term: 'OPERATOR ID',
///       description: 'ALPHA-7729',
///     ),
///     TauDescriptionItem(
///       term: 'CLEARANCE LEVEL',
///       description: 'CLASSIFIED',
///     ),
///   ],
/// )
/// ```
class TauDescriptionList extends StatelessWidget {
  const TauDescriptionList({
    super.key,
    required this.items,
    this.layout = TauDescriptionListLayout.vertical,
    this.spacing = TauDescriptionListSpacing.comfortable,
    this.showDividers = false,
    this.termWidth = 120.0,
  });

  /// List of description items to display.
  final List<TauDescriptionItem> items;

  /// Layout direction for each item.
  final TauDescriptionListLayout layout;

  /// Spacing density between items.
  final TauDescriptionListSpacing spacing;

  /// Whether to show dividers between items.
  final bool showDividers;

  /// Width of term column in horizontal layout.
  final double termWidth;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacingTokens = TauTheme.spacingOf(context);

    final itemSpacing = spacing == TauDescriptionListSpacing.dense
        ? spacingTokens.spacingBase
        : spacingTokens.spacingBase * 2;

    final children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      children.add(
        _TauDescriptionItemWidget(
          item: items[i],
          layout: layout,
          termWidth: termWidth,
        ),
      );

      // Add spacing/divider between items (but not after the last one)
      if (i < items.length - 1) {
        if (showDividers) {
          children.add(SizedBox(height: itemSpacing));
          children.add(
            Container(
              height: 1.0,
              color: colors.borderSubtle,
            ),
          );
          children.add(SizedBox(height: itemSpacing));
        } else {
          children.add(SizedBox(height: itemSpacing));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Layout mode for description list items.
enum TauDescriptionListLayout {
  /// Term and description stacked vertically.
  vertical,

  /// Term and description side-by-side horizontally.
  horizontal,
}

/// Spacing density for description list.
enum TauDescriptionListSpacing {
  /// Dense spacing (8px between items).
  dense,

  /// Comfortable spacing (16px between items).
  comfortable,
}

/// Configuration for a single description list item.
class TauDescriptionItem {
  const TauDescriptionItem({
    required this.term,
    required this.description,
  });

  /// The term/label (e.g., "OPERATOR ID").
  final String term;

  /// The description/value (can be a String or Widget).
  final dynamic description;
}

/// Internal widget for rendering a single description item.
class _TauDescriptionItemWidget extends StatelessWidget {
  const _TauDescriptionItemWidget({
    required this.item,
    required this.layout,
    required this.termWidth,
  });

  final TauDescriptionItem item;
  final TauDescriptionListLayout layout;
  final double termWidth;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final termWidget = Text(
      item.term,
      style: typography.labelMono.copyWith(
        color: colors.textMuted,
        fontSize: 11.0,
        letterSpacing: 0.5,
      ),
    );

    final descriptionWidget = item.description is String
        ? Text(
            item.description as String,
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          )
        : item.description as Widget;

    if (layout == TauDescriptionListLayout.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: termWidth,
            child: termWidget,
          ),
          SizedBox(width: spacing.spacingBase * 2),
          Expanded(child: descriptionWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          termWidget,
          SizedBox(height: spacing.spacingBase / 2),
          descriptionWidget,
        ],
      );
    }
  }
}

/// TAU NEUE inline description component for horizontal key-value pairs.
///
/// Displays a single term-description pair inline with colon separator.
/// Useful for compact inline metadata display.
///
/// Example:
/// ```dart
/// TauInlineDescription(
///   term: 'STATUS',
///   description: 'ACTIVE',
/// )
/// ```
class TauInlineDescription extends StatelessWidget {
  const TauInlineDescription({
    super.key,
    required this.term,
    required this.description,
    this.separator = ': ',
  });

  /// The term/label text.
  final String term;

  /// The description/value (can be String or Widget).
  final dynamic description;

  /// Separator between term and description.
  final String separator;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          term,
          style: typography.labelMono.copyWith(
            color: colors.textMuted,
            fontSize: 11.0,
          ),
        ),
        Text(
          separator,
          style: typography.labelMono.copyWith(
            color: colors.textMuted,
            fontSize: 11.0,
          ),
        ),
        SizedBox(width: spacing.spacingBase / 2),
        description is String
            ? Text(
                description as String,
                style: typography.bodyMono.copyWith(
                  color: colors.textOnDark,
                ),
              )
            : description as Widget,
      ],
    );
  }
}
