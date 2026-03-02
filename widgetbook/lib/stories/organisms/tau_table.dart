import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Sample data
final _sampleData = [
  {'id': 'OPR-001', 'name': 'ALPHA UNIT', 'status': 'ACTIVE', 'missions': '23'},
  {'id': 'OPR-002', 'name': 'BETA SQUADRON', 'status': 'STANDBY', 'missions': '18'},
  {'id': 'OPR-003', 'name': 'GAMMA TEAM', 'status': 'ACTIVE', 'missions': '31'},
  {'id': 'OPR-004', 'name': 'DELTA FORCE', 'status': 'OFFLINE', 'missions': '12'},
  {'id': 'OPR-005', 'name': 'EPSILON CELL', 'status': 'ACTIVE', 'missions': '27'},
  {'id': 'OPR-006', 'name': 'ZETA DIVISION', 'status': 'STANDBY', 'missions': '15'},
  {'id': 'OPR-007', 'name': 'ETA PLATOON', 'status': 'ACTIVE', 'missions': '19'},
  {'id': 'OPR-008', 'name': 'THETA SQUAD', 'status': 'ACTIVE', 'missions': '25'},
];

@widgetbook.UseCase(
  name: 'Basic Table',
  type: TauTable,
)
Widget basicTauTable(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauTable<Map<String, dynamic>>(
      columns: const [
        TauTableColumn(id: 'id', label: 'ID', width: 100),
        TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(id: 'status', label: 'STATUS', width: 120),
        TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: _sampleData,
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Sorting',
  type: TauTable,
)
Widget sortingTauTable(BuildContext context) {
  return _SortingTauTableDemo();
}

class _SortingTauTableDemo extends StatefulWidget {
  @override
  State<_SortingTauTableDemo> createState() => _SortingTauTableDemoState();
}

class _SortingTauTableDemoState extends State<_SortingTauTableDemo> {
  List<Map<String, dynamic>> _data = List.from(_sampleData);
  String? _sortColumnId;
  bool _sortAscending = true;

  void _handleSort(String columnId, bool ascending) {
    setState(() {
      _sortColumnId = columnId;
      _sortAscending = ascending;

      _data.sort((a, b) {
        final aValue = a[columnId];
        final bValue = b[columnId];

        int comparison;
        if (aValue is String && bValue is String) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = int.parse(aValue.toString())
              .compareTo(int.parse(bValue.toString()));
        }

        return ascending ? comparison : -comparison;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauTable<Map<String, dynamic>>(
        columns: const [
          TauTableColumn(id: 'id', label: 'ID', width: 100),
          TauTableColumn(id: 'name', label: 'NAME', width: 180),
          TauTableColumn(id: 'status', label: 'STATUS', width: 120),
          TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
        ],
        rows: _data,
        sortColumnId: _sortColumnId,
        sortAscending: _sortAscending,
        onSort: _handleSort,
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Selection',
  type: TauTable,
)
Widget selectionTauTable(BuildContext context) {
  return _SelectionTauTableDemo();
}

class _SelectionTauTableDemo extends StatefulWidget {
  @override
  State<_SelectionTauTableDemo> createState() => _SelectionTauTableDemoState();
}

class _SelectionTauTableDemoState extends State<_SelectionTauTableDemo> {
  Set<Map<String, dynamic>> _selectedRows = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: ${_selectedRows.length} rows',
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 16.0),
          TauTable<Map<String, dynamic>>(
            columns: const [
              TauTableColumn(id: 'id', label: 'ID', width: 100),
              TauTableColumn(id: 'name', label: 'NAME', width: 180),
              TauTableColumn(id: 'status', label: 'STATUS', width: 120),
              TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
            ],
            rows: _sampleData,
            selectionMode: TauTableSelectionMode.multiple,
            selectedRows: _selectedRows,
            onSelectionChanged: (selected) {
              setState(() => _selectedRows = selected);
            },
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Custom Cells',
  type: TauTable,
)
Widget customCellsTauTable(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauTable<Map<String, dynamic>>(
      columns: [
        const TauTableColumn(id: 'id', label: 'ID', width: 100),
        const TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(
          id: 'status',
          label: 'STATUS',
          width: 120,
          cellBuilder: (row) {
            final status = row['status'] as String;
            Color badgeColor;
            if (status == 'ACTIVE') {
              badgeColor = const Color(0xFFC0FC04);
            } else if (status == 'STANDBY') {
              badgeColor = const Color(0xFF3601FB);
            } else {
              badgeColor = const Color(0xFF8E8E8E);
            }

            return TauBadge(
              label: status,
              backgroundColor: badgeColor,
              textColor: const Color(0xFF000000),
            );
          },
        ),
        const TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: _sampleData,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dense Mode',
  type: TauTable,
)
Widget denseTauTable(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauTable<Map<String, dynamic>>(
      columns: const [
        TauTableColumn(id: 'id', label: 'ID', width: 100),
        TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(id: 'status', label: 'STATUS', width: 120),
        TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: _sampleData,
      density: TauTableDensity.dense,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading State',
  type: TauTable,
)
Widget loadingTauTable(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauTable<Map<String, dynamic>>(
      columns: const [
        TauTableColumn(id: 'id', label: 'ID', width: 100),
        TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(id: 'status', label: 'STATUS', width: 120),
        TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: const [],
      isLoading: true,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Empty State',
  type: TauTable,
)
Widget emptyTauTable(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauTable<Map<String, dynamic>>(
      columns: const [
        TauTableColumn(id: 'id', label: 'ID', width: 100),
        TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(id: 'status', label: 'STATUS', width: 120),
        TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: const [],
      emptyMessage: 'NO OPERATORS AVAILABLE',
    ),
  );
}

@widgetbook.UseCase(
  name: 'Large Dataset',
  type: TauTable,
)
Widget largeDatasetTauTable(BuildContext context) {
  // Generate 100 rows
  final largeData = List.generate(
    100,
    (index) => {
      'id': 'OPR-${(index + 1).toString().padLeft(3, '0')}',
      'name': 'UNIT ${String.fromCharCode(65 + (index % 26))}${index ~/ 26}',
      'status': ['ACTIVE', 'STANDBY', 'OFFLINE'][index % 3],
      'missions': '${10 + (index % 30)}',
    },
  );

  return Container(
    padding: const EdgeInsets.all(32.0),
    height: 600.0,
    child: TauTable<Map<String, dynamic>>(
      columns: const [
        TauTableColumn(id: 'id', label: 'ID', width: 100),
        TauTableColumn(id: 'name', label: 'NAME', width: 180),
        TauTableColumn(id: 'status', label: 'STATUS', width: 120),
        TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
      ],
      rows: largeData,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Complete Example',
  type: TauTable,
)
Widget completeTauTable(BuildContext context) {
  return _CompleteTauTableDemo();
}

class _CompleteTauTableDemo extends StatefulWidget {
  @override
  State<_CompleteTauTableDemo> createState() => _CompleteTauTableDemoState();
}

class _CompleteTauTableDemoState extends State<_CompleteTauTableDemo> {
  List<Map<String, dynamic>> _data = List.from(_sampleData);
  Set<Map<String, dynamic>> _selectedRows = {};
  String? _sortColumnId;
  bool _sortAscending = true;

  void _handleSort(String columnId, bool ascending) {
    setState(() {
      _sortColumnId = columnId;
      _sortAscending = ascending;

      _data.sort((a, b) {
        final aValue = a[columnId];
        final bValue = b[columnId];

        int comparison;
        if (aValue is String && bValue is String) {
          comparison = aValue.compareTo(bValue);
        } else {
          comparison = int.parse(aValue.toString())
              .compareTo(int.parse(bValue.toString()));
        }

        return ascending ? comparison : -comparison;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TACTICAL OPERATIONS TABLE',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Selected: ${_selectedRows.length} / ${_data.length} units',
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 16.0),
          TauTable<Map<String, dynamic>>(
            columns: [
              const TauTableColumn(id: 'id', label: 'ID', width: 100),
              const TauTableColumn(id: 'name', label: 'NAME', width: 180),
              TauTableColumn(
                id: 'status',
                label: 'STATUS',
                width: 120,
                cellBuilder: (row) {
                  final status = row['status'] as String;
                  Color badgeColor;
                  if (status == 'ACTIVE') {
                    badgeColor = const Color(0xFFC0FC04);
                  } else if (status == 'STANDBY') {
                    badgeColor = const Color(0xFF3601FB);
                  } else {
                    badgeColor = const Color(0xFF8E8E8E);
                  }

                  return TauBadge(
                    label: status,
                    backgroundColor: badgeColor,
                    textColor: const Color(0xFF000000),
                  );
                },
              ),
              const TauTableColumn(id: 'missions', label: 'MISSIONS', width: 100),
            ],
            rows: _data,
            sortColumnId: _sortColumnId,
            sortAscending: _sortAscending,
            onSort: _handleSort,
            selectionMode: TauTableSelectionMode.multiple,
            selectedRows: _selectedRows,
            onSelectionChanged: (selected) {
              setState(() => _selectedRows = selected);
            },
          ),
        ],
      ),
    );
  }
}
