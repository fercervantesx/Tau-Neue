import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE breadcrumbs component with tactical terminal aesthetic.
///
/// Hierarchical navigation trail showing current location in app structure.
/// Supports icons, custom separators, and click callbacks.
///
/// Example:
/// ```dart
/// TauBreadcrumbs(
///   items: [
///     TauBreadcrumb(label: 'HOME', onTap: () => navigateTo('/home')),
///     TauBreadcrumb(label: 'MISSIONS', onTap: () => navigateTo('/missions')),
///     TauBreadcrumb(label: 'DETAILS', isCurrentPage: true),
///   ],
/// )
/// ```
class TauBreadcrumbs extends StatelessWidget {
  const TauBreadcrumbs({
    super.key,
    required this.items,
    this.separator,
    this.maxItems,
    this.collapsedText = '...',
  }) : assert(items.length > 0, 'At least one breadcrumb item is required');

  /// List of breadcrumb items.
  final List<TauBreadcrumb> items;

  /// Custom separator widget between breadcrumbs.
  /// Defaults to "/" character.
  final Widget? separator;

  /// Maximum number of items to show before collapsing.
  /// If null, shows all items.
  final int? maxItems;

  /// Text to show when items are collapsed.
  final String collapsedText;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final defaultSeparator = Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.spacingBase),
      child: Text(
        '/',
        style: typography.labelMono.copyWith(
          color: colors.textMuted,
          fontSize: 12.0,
        ),
      ),
    );

    final effectiveSeparator = separator ?? defaultSeparator;

    List<TauBreadcrumb> displayedItems = items;

    // Handle overflow collapse
    if (maxItems != null && items.length > maxItems!) {
      displayedItems = [
        items.first,
        TauBreadcrumb(
          label: collapsedText,
          onTap: null,
        ),
        ...items.sublist(items.length - (maxItems! - 2)),
      ];
    }

    final children = <Widget>[];
    for (int i = 0; i < displayedItems.length; i++) {
      children.add(
        _TauBreadcrumbItem(
          breadcrumb: displayedItems[i],
          colors: colors,
          spacing: spacing,
          typography: typography,
        ),
      );

      // Add separator except after last item
      if (i < displayedItems.length - 1) {
        children.add(effectiveSeparator);
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Configuration for a single breadcrumb item.
class TauBreadcrumb {
  const TauBreadcrumb({
    required this.label,
    this.icon,
    this.onTap,
    this.isCurrentPage = false,
  });

  /// Display label.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Callback when breadcrumb is tapped.
  /// If null, breadcrumb is not interactive.
  final VoidCallback? onTap;

  /// Whether this is the current page.
  /// Current page breadcrumbs are highlighted and non-interactive.
  final bool isCurrentPage;
}

/// Internal breadcrumb item widget.
class _TauBreadcrumbItem extends StatefulWidget {
  const _TauBreadcrumbItem({
    required this.breadcrumb,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauBreadcrumb breadcrumb;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  State<_TauBreadcrumbItem> createState() => _TauBreadcrumbItemState();
}

class _TauBreadcrumbItemState extends State<_TauBreadcrumbItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isInteractive =
        widget.breadcrumb.onTap != null && !widget.breadcrumb.isCurrentPage;

    Color textColor;
    if (widget.breadcrumb.isCurrentPage) {
      textColor = widget.colors.accentPrimary;
    } else if (_hovered && isInteractive) {
      textColor = widget.colors.textOnDark;
    } else {
      textColor = widget.colors.textMuted;
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.breadcrumb.icon != null) ...{
          IconTheme(
            data: IconThemeData(
              color: textColor,
              size: 14.0,
            ),
            child: widget.breadcrumb.icon!,
          ),
          SizedBox(width: widget.spacing.spacingBase / 2),
        },
        Text(
          widget.breadcrumb.label,
          style: widget.typography.labelMono.copyWith(
            color: textColor,
            fontSize: 12.0,
            fontWeight: widget.breadcrumb.isCurrentPage
                ? FontWeight.bold
                : FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );

    if (!isInteractive) {
      return content;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.breadcrumb.onTap,
        child: content,
      ),
    );
  }
}
