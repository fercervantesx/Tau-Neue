import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE footer component with tactical terminal aesthetic.
///
/// Page footer with flexible column layout.
/// Supports copyright, links, and multi-column content.
///
/// Example:
/// ```dart
/// TauFooter(
///   columns: [
///     TauFooterColumn(
///       title: 'PRODUCT',
///       links: [
///         TauFooterLink(label: 'Features', onTap: () {}),
///         TauFooterLink(label: 'Pricing', onTap: () {}),
///       ],
///     ),
///   ],
///   copyright: '© 2024 TAU SYSTEM. All rights reserved.',
/// )
/// ```
class TauFooter extends StatelessWidget {
  const TauFooter({
    super.key,
    this.columns = const [],
    this.copyright,
    this.logo,
    this.showBorder = true,
  });

  /// List of footer columns.
  final List<TauFooterColumn> columns;

  /// Copyright text.
  final String? copyright;

  /// Optional logo widget.
  final Widget? logo;

  /// Whether to show top border.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        border: showBorder
            ? Border(
                top: BorderSide(
                  color: colors.borderSubtle,
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.spacingBase * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            if (logo != null) ...[
              logo!,
              SizedBox(height: spacing.spacingBase * 4),
            ],

            // Columns
            if (columns.isNotEmpty) ...[
              Wrap(
                spacing: spacing.spacingBase * 8,
                runSpacing: spacing.spacingBase * 4,
                children: columns
                    .map((column) => _TauFooterColumnWidget(
                          column: column,
                          colors: colors,
                          spacing: spacing,
                          typography: typography,
                        ))
                    .toList(),
              ),
              SizedBox(height: spacing.spacingBase * 4),
            ],

            // Copyright
            if (copyright != null)
              Text(
                copyright!,
                style: typography.bodyMono.copyWith(
                  color: colors.textMuted,
                  fontSize: 11.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Footer column configuration.
class TauFooterColumn {
  const TauFooterColumn({
    required this.title,
    required this.links,
  });

  /// Column title.
  final String title;

  /// List of links in this column.
  final List<TauFooterLink> links;
}

/// Footer link configuration.
class TauFooterLink {
  const TauFooterLink({
    required this.label,
    required this.onTap,
  });

  /// Link label.
  final String label;

  /// Callback when link is tapped.
  final VoidCallback onTap;
}

/// Internal footer column widget.
class _TauFooterColumnWidget extends StatelessWidget {
  const _TauFooterColumnWidget({
    required this.column,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauFooterColumn column;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            column.title,
            style: typography.labelMono.copyWith(
              color: colors.textOnDark,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: spacing.spacingBase * 2),

          // Links
          ...column.links.map((link) => _TauFooterLinkWidget(
                link: link,
                colors: colors,
                spacing: spacing,
                typography: typography,
              )),
        ],
      ),
    );
  }
}

/// Internal footer link widget.
class _TauFooterLinkWidget extends StatefulWidget {
  const _TauFooterLinkWidget({
    required this.link,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauFooterLink link;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  State<_TauFooterLinkWidget> createState() => _TauFooterLinkWidgetState();
}

class _TauFooterLinkWidgetState extends State<_TauFooterLinkWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.link.onTap,
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.spacing.spacingBase),
          child: Text(
            widget.link.label,
            style: widget.typography.bodyMono.copyWith(
              color: _hovered ? widget.colors.textOnDark : widget.colors.textMuted,
              fontSize: 11.0,
            ),
          ),
        ),
      ),
    );
  }
}
