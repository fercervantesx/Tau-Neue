import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE data table component with tactical terminal aesthetic.
///
/// Feature-rich table with sorting, selection, and pagination support.
/// Optimized for large datasets with RepaintBoundary on rows.
///
/// Example:
/// ```dart
/// TauTable<Map<String, dynamic>>(
///   columns: [
///     TauTableColumn(id: 'id', label: 'ID', width: 80),
///     TauTableColumn(id: 'name', label: 'NAME', width: 200),
///     TauTableColumn(id: 'status', label: 'STATUS', width: 120),
///   ],
///   rows: data,
///   onSort: (columnId, ascending) => print('Sort: $columnId'),
/// )
/// ```
class TauTable<T> extends StatefulWidget {
  const TauTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onSort,
    this.sortColumnId,
    this.sortAscending = true,
    this.onRowTap,
    this.onSelectionChanged,
    this.selectedRows = const {},
    this.selectionMode = TauTableSelectionMode.none,
    this.density = TauTableDensity.comfortable,
    this.isLoading = false,
    this.emptyMessage = 'NO DATA',
  });

  /// Column definitions.
  final List<TauTableColumn> columns;

  /// Row data.
  final List<T> rows;

  /// Callback when column header is tapped for sorting.
  final void Function(String columnId, bool ascending)? onSort;

  /// Currently sorted column ID.
  final String? sortColumnId;

  /// Current sort direction.
  final bool sortAscending;

  /// Callback when row is tapped.
  final void Function(T row)? onRowTap;

  /// Callback when row selection changes.
  final void Function(Set<T> selectedRows)? onSelectionChanged;

  /// Currently selected rows.
  final Set<T> selectedRows;

  /// Selection mode.
  final TauTableSelectionMode selectionMode;

  /// Row density.
  final TauTableDensity density;

  /// Whether to show loading state.
  final bool isLoading;

  /// Message to display when no data.
  final String emptyMessage;

  @override
  State<TauTable<T>> createState() => _TauTableState<T>();
}

class _TauTableState<T> extends State<TauTable<T>> {
  int? _hoveredRowIndex;

  void _handleRowTap(T row) {
    if (widget.selectionMode != TauTableSelectionMode.none) {
      final newSelection = Set<T>.from(widget.selectedRows);
      if (newSelection.contains(row)) {
        newSelection.remove(row);
      } else {
        if (widget.selectionMode == TauTableSelectionMode.single) {
          newSelection.clear();
        }
        newSelection.add(row);
      }
      widget.onSelectionChanged?.call(newSelection);
    }
    widget.onRowTap?.call(row);
  }

  void _handleSort(String columnId) {
    if (widget.onSort != null) {
      final newAscending =
          widget.sortColumnId == columnId ? !widget.sortAscending : true;
      widget.onSort!(columnId, newAscending);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final rowHeight = widget.density == TauTableDensity.dense ? 36.0 : 48.0;

    if (widget.isLoading) {
      return _buildLoadingSkeleton(colors, spacing, rowHeight);
    }

    if (widget.rows.isEmpty) {
      return _buildEmptyState(colors, typography);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _TauTableHeader(
            columns: widget.columns,
            sortColumnId: widget.sortColumnId,
            sortAscending: widget.sortAscending,
            onSort: widget.onSort != null ? _handleSort : null,
            colors: colors,
            spacing: spacing,
            typography: typography,
          ),
          // Divider
          Container(
            height: 1.0,
            color: colors.borderSubtle,
          ),
          // Rows
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.rows.length,
              itemBuilder: (context, index) {
                final row = widget.rows[index];
                final isSelected = widget.selectedRows.contains(row);
                final isHovered = _hoveredRowIndex == index;

                return RepaintBoundary(
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredRowIndex = index),
                    onExit: (_) => setState(() => _hoveredRowIndex = null),
                    child: GestureDetector(
                      onTap: () => _handleRowTap(row),
                      child: _TauTableRow<T>(
                        columns: widget.columns,
                        row: row,
                        isSelected: isSelected,
                        isHovered: isHovered,
                        height: rowHeight,
                        colors: colors,
                        spacing: spacing,
                        typography: typography,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton(colors, spacing, double rowHeight) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Loading header
          Container(
            height: 48.0,
            padding: EdgeInsets.symmetric(
              horizontal: spacing.spacingBase * 2,
              vertical: spacing.spacingBase,
            ),
            color: colors.surfaceElevated,
            child: Row(
              children: [
                for (int i = 0; i < widget.columns.length; i++) ...[
                  Container(
                    width: widget.columns[i].width ?? 100.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: colors.surfaceBase,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  if (i < widget.columns.length - 1)
                    SizedBox(width: spacing.spacingBase),
                ],
              ],
            ),
          ),
          // Loading rows
          for (int i = 0; i < 5; i++) ...[
            Container(
              height: 1.0,
              color: colors.borderSubtle,
            ),
            Container(
              height: rowHeight,
              padding: EdgeInsets.symmetric(
                horizontal: spacing.spacingBase * 2,
                vertical: spacing.spacingBase,
              ),
              child: Row(
                children: [
                  for (int j = 0; j < widget.columns.length; j++) ...[
                    Container(
                      width: widget.columns[j].width ?? 100.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: colors.surfaceElevated,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    if (j < widget.columns.length - 1)
                      SizedBox(width: spacing.spacingBase),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(colors, typography) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: const EdgeInsets.all(48.0),
      child: Center(
        child: Text(
          widget.emptyMessage,
          style: typography.labelMono.copyWith(
            color: colors.textMuted,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

/// Column definition for table.
class TauTableColumn {
  const TauTableColumn({
    required this.id,
    required this.label,
    this.width,
    this.sortable = true,
    this.cellBuilder,
  });

  /// Unique identifier for this column.
  final String id;

  /// Display label in header.
  final String label;

  /// Optional fixed width (null = flexible).
  final double? width;

  /// Whether this column can be sorted.
  final bool sortable;

  /// Optional custom cell builder.
  /// If null, displays row[columnId] as string.
  final Widget Function(dynamic row)? cellBuilder;
}

/// Selection mode for table rows.
enum TauTableSelectionMode {
  /// No selection.
  none,

  /// Single row selection.
  single,

  /// Multiple row selection.
  multiple,
}

/// Row density for table.
enum TauTableDensity {
  /// Dense spacing (36px rows).
  dense,

  /// Comfortable spacing (48px rows).
  comfortable,
}

/// Table header widget.
class _TauTableHeader extends StatelessWidget {
  const _TauTableHeader({
    required this.columns,
    required this.sortColumnId,
    required this.sortAscending,
    required this.onSort,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final List<TauTableColumn> columns;
  final String? sortColumnId;
  final bool sortAscending;
  final void Function(String)? onSort;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingBase * 2,
        vertical: spacing.spacingBase,
      ),
      color: colors.surfaceElevated,
      child: Row(
        children: [
          for (int i = 0; i < columns.length; i++) ...[
            _TauTableHeaderCell(
              column: columns[i],
              isSorted: sortColumnId == columns[i].id,
              sortAscending: sortAscending,
              onTap: onSort != null && columns[i].sortable
                  ? () => onSort!(columns[i].id)
                  : null,
              colors: colors,
              typography: typography,
            ),
            if (i < columns.length - 1) SizedBox(width: spacing.spacingBase),
          ],
        ],
      ),
    );
  }
}

/// Table header cell widget.
class _TauTableHeaderCell extends StatefulWidget {
  const _TauTableHeaderCell({
    required this.column,
    required this.isSorted,
    required this.sortAscending,
    required this.onTap,
    required this.colors,
    required this.typography,
  });

  final TauTableColumn column;
  final bool isSorted;
  final bool sortAscending;
  final VoidCallback? onTap;
  final dynamic colors;
  final dynamic typography;

  @override
  State<_TauTableHeaderCell> createState() => _TauTableHeaderCellState();
}

class _TauTableHeaderCellState extends State<_TauTableHeaderCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            widget.column.label,
            style: widget.typography.labelMono.copyWith(
              color: widget.colors.textOnDark,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.column.sortable && widget.onTap != null) ...[
          const SizedBox(width: 4.0),
          CustomPaint(
            size: const Size(8.0, 6.0),
            painter: _SortArrowPainter(
              color: widget.isSorted
                  ? widget.colors.accentPrimary
                  : widget.colors.textMuted,
              direction: widget.sortAscending
                  ? _SortDirection.ascending
                  : _SortDirection.descending,
            ),
          ),
        ],
      ],
    );

    if (widget.column.width != null) {
      final content = SizedBox(
        width: widget.column.width,
        child: child,
      );

      if (widget.onTap == null) {
        return content;
      }

      return MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Opacity(
            opacity: _hovered ? 0.7 : 1.0,
            child: content,
          ),
        ),
      );
    } else {
      final content = Expanded(child: child);

      if (widget.onTap == null) {
        return content;
      }

      return Expanded(
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Opacity(
              opacity: _hovered ? 0.7 : 1.0,
              child: child,
            ),
          ),
        ),
      );
    }
  }
}

/// Table row widget.
class _TauTableRow<T> extends StatelessWidget {
  const _TauTableRow({
    required this.columns,
    required this.row,
    required this.isSelected,
    required this.isHovered,
    required this.height,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final List<TauTableColumn> columns;
  final T row;
  final bool isSelected;
  final bool isHovered;
  final double height;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (isSelected) {
      backgroundColor = Color.lerp(colors.accentPrimary, colors.surfaceBase, 0.9)!;
    } else if (isHovered) {
      backgroundColor = colors.surfaceElevated;
    } else {
      backgroundColor = colors.surfaceBase;
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.spacingBase * 2,
        vertical: spacing.spacingBase,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < columns.length; i++) ...[
            _TauTableCell(
              column: columns[i],
              row: row,
              colors: colors,
              typography: typography,
            ),
            if (i < columns.length - 1) SizedBox(width: spacing.spacingBase),
          ],
        ],
      ),
    );
  }
}

/// Table cell widget.
class _TauTableCell extends StatelessWidget {
  const _TauTableCell({
    required this.column,
    required this.row,
    required this.colors,
    required this.typography,
  });

  final TauTableColumn column;
  final dynamic row;
  final dynamic colors;
  final dynamic typography;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (column.cellBuilder != null) {
      content = column.cellBuilder!(row);
    } else {
      // Default: display row[columnId] as string
      final value = row is Map ? row[column.id] : '';
      content = Text(
        value?.toString() ?? '',
        style: typography.bodyMono.copyWith(
          color: colors.textOnDark,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    if (column.width != null) {
      return SizedBox(
        width: column.width,
        child: content,
      );
    } else {
      return Expanded(child: content);
    }
  }
}

/// Sort direction for arrow icon.
enum _SortDirection { ascending, descending }

/// Custom painter for sort arrow.
class _SortArrowPainter extends CustomPainter {
  _SortArrowPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final _SortDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    if (direction == _SortDirection.ascending) {
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
  bool shouldRepaint(covariant _SortArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}
