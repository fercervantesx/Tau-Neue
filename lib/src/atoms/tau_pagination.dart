import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE pagination component with tactical terminal aesthetic.
///
/// Page navigation controls with previous/next buttons and page numbers.
/// Automatically collapses large page ranges with ellipsis.
///
/// Example:
/// ```dart
/// TauPagination(
///   currentPage: 5,
///   totalPages: 20,
///   onPageChanged: (page) => loadPage(page),
/// )
/// ```
class TauPagination extends StatelessWidget {
  const TauPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxVisiblePages = 7,
    this.showFirstLast = true,
  })  : assert(currentPage >= 1, 'currentPage must be >= 1'),
        assert(totalPages >= 1, 'totalPages must be >= 1'),
        assert(currentPage <= totalPages, 'currentPage must be <= totalPages'),
        assert(maxVisiblePages >= 5, 'maxVisiblePages must be >= 5 for proper display');

  /// Current active page (1-indexed).
  final int currentPage;

  /// Total number of pages.
  final int totalPages;

  /// Callback when page is changed.
  final ValueChanged<int> onPageChanged;

  /// Maximum number of page buttons to show before collapsing.
  final int maxVisiblePages;

  /// Whether to show first/last page buttons when collapsed.
  final bool showFirstLast;

  List<dynamic> _calculatePageRange() {
    if (totalPages <= maxVisiblePages) {
      // Show all pages
      return List.generate(totalPages, (i) => i + 1);
    }

    // Calculate visible range with ellipsis
    final List<dynamic> pages = [];
    final int halfVisible = (maxVisiblePages - 3) ~/ 2; // Reserve 3 for first, last, and one ellipsis

    if (currentPage <= halfVisible + 2) {
      // Near start: [1, 2, 3, 4, 5, ..., 20]
      for (int i = 1; i <= maxVisiblePages - 2; i++) {
        pages.add(i);
      }
      pages.add('...');
      pages.add(totalPages);
    } else if (currentPage >= totalPages - halfVisible - 1) {
      // Near end: [1, ..., 16, 17, 18, 19, 20]
      pages.add(1);
      pages.add('...');
      for (int i = totalPages - (maxVisiblePages - 3); i <= totalPages; i++) {
        pages.add(i);
      }
    } else {
      // Middle: [1, ..., 9, 10, 11, ..., 20]
      pages.add(1);
      pages.add('...');
      for (int i = currentPage - 1; i <= currentPage + 1; i++) {
        pages.add(i);
      }
      pages.add('...');
      pages.add(totalPages);
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final pageRange = _calculatePageRange();
    final hasPrevious = currentPage > 1;
    final hasNext = currentPage < totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Previous button
        _PaginationButton(
          label: 'PREV',
          enabled: hasPrevious,
          onPressed: hasPrevious ? () => onPageChanged(currentPage - 1) : null,
          colors: colors,
          spacing: spacing,
          typography: typography,
        ),
        SizedBox(width: spacing.spacingBase),

        // Page numbers
        ...pageRange.map((item) {
          if (item is String) {
            // Ellipsis
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing.spacingBase / 2),
              child: Text(
                item,
                style: typography.labelMono.copyWith(
                  color: colors.textMuted,
                  fontSize: 12.0,
                  letterSpacing: 1.0,
                ),
              ),
            );
          } else {
            // Page number button
            final int page = item as int;
            final isActive = page == currentPage;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing.spacingBase / 4),
              child: _PaginationButton(
                label: page.toString(),
                enabled: true,
                isActive: isActive,
                onPressed: isActive ? null : () => onPageChanged(page),
                colors: colors,
                spacing: spacing,
                typography: typography,
                isCompact: true,
              ),
            );
          }
        }),

        SizedBox(width: spacing.spacingBase),

        // Next button
        _PaginationButton(
          label: 'NEXT',
          enabled: hasNext,
          onPressed: hasNext ? () => onPageChanged(currentPage + 1) : null,
          colors: colors,
          spacing: spacing,
          typography: typography,
        ),
      ],
    );
  }
}

/// Internal pagination button widget.
class _PaginationButton extends StatefulWidget {
  const _PaginationButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
    required this.colors,
    required this.spacing,
    required this.typography,
    this.isActive = false,
    this.isCompact = false,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;
  final bool isActive;
  final bool isCompact;

  @override
  State<_PaginationButton> createState() => _PaginationButtonState();
}

class _PaginationButtonState extends State<_PaginationButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (!widget.enabled) {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
      borderColor = widget.colors.borderSubtle;
    } else if (widget.isActive) {
      backgroundColor = widget.colors.accentPrimary;
      textColor = widget.colors.textOnAccent;
      borderColor = widget.colors.accentPrimary;
    } else if (_pressed) {
      backgroundColor = Color.lerp(
        widget.colors.surfaceElevated,
        widget.colors.accentPrimary,
        0.3,
      )!;
      textColor = widget.colors.textOnDark;
      borderColor = widget.colors.accentPrimary;
    } else if (_hovered) {
      backgroundColor = widget.colors.surfaceElevated;
      textColor = widget.colors.textOnDark;
      borderColor = widget.colors.borderSubtle;
    } else {
      backgroundColor = widget.colors.surfaceBase;
      textColor = widget.colors.textMuted;
      borderColor = widget.colors.borderSubtle;
    }

    final content = Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isCompact ? widget.spacing.spacingBase : widget.spacing.spacingBase * 2,
        vertical: widget.spacing.spacingBase,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        widget.label,
        style: widget.typography.labelMono.copyWith(
          color: textColor,
          fontSize: 12.0,
          fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
          letterSpacing: 0.5,
        ),
      ),
    );

    if (!widget.enabled || widget.isActive) {
      return content;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: content,
      ),
    );
  }
}
