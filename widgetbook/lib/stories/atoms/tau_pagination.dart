import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauPagination,
)
Widget basicTauPagination(BuildContext context) {
  return _BasicPaginationDemo();
}

class _BasicPaginationDemo extends StatefulWidget {
  @override
  State<_BasicPaginationDemo> createState() => _BasicPaginationDemoState();
}

class _BasicPaginationDemoState extends State<_BasicPaginationDemo> {
  int _currentPage = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TauPagination(
            currentPage: _currentPage,
            totalPages: 20,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
          const SizedBox(height: 32.0),
          Text(
            'Page $_currentPage of 20',
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Few Pages',
  type: TauPagination,
)
Widget fewPagesTauPagination(BuildContext context) {
  return _FewPagesDemo();
}

class _FewPagesDemo extends StatefulWidget {
  @override
  State<_FewPagesDemo> createState() => _FewPagesDemoState();
}

class _FewPagesDemoState extends State<_FewPagesDemo> {
  int _currentPage = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'All pages visible (totalPages <= maxVisiblePages)',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TauPagination(
            currentPage: _currentPage,
            totalPages: 5,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Start Position',
  type: TauPagination,
)
Widget startPositionTauPagination(BuildContext context) {
  return _StartPositionDemo();
}

class _StartPositionDemo extends StatefulWidget {
  @override
  State<_StartPositionDemo> createState() => _StartPositionDemoState();
}

class _StartPositionDemoState extends State<_StartPositionDemo> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Current page near start',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TauPagination(
            currentPage: _currentPage,
            totalPages: 50,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Middle Position',
  type: TauPagination,
)
Widget middlePositionTauPagination(BuildContext context) {
  return _MiddlePositionDemo();
}

class _MiddlePositionDemo extends StatefulWidget {
  @override
  State<_MiddlePositionDemo> createState() => _MiddlePositionDemoState();
}

class _MiddlePositionDemoState extends State<_MiddlePositionDemo> {
  int _currentPage = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Current page in middle',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TauPagination(
            currentPage: _currentPage,
            totalPages: 50,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'End Position',
  type: TauPagination,
)
Widget endPositionTauPagination(BuildContext context) {
  return _EndPositionDemo();
}

class _EndPositionDemo extends StatefulWidget {
  @override
  State<_EndPositionDemo> createState() => _EndPositionDemoState();
}

class _EndPositionDemoState extends State<_EndPositionDemo> {
  int _currentPage = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Current page near end',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TauPagination(
            currentPage: _currentPage,
            totalPages: 50,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Large Dataset',
  type: TauPagination,
)
Widget largeDatasetTauPagination(BuildContext context) {
  return _LargeDatasetDemo();
}

class _LargeDatasetDemo extends StatefulWidget {
  @override
  State<_LargeDatasetDemo> createState() => _LargeDatasetDemoState();
}

class _LargeDatasetDemoState extends State<_LargeDatasetDemo> {
  int _currentPage = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Very large dataset (1000 pages)',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TauPagination(
            currentPage: _currentPage,
            totalPages: 1000,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
          const SizedBox(height: 32.0),
          Text(
            'Page $_currentPage of 1000',
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
