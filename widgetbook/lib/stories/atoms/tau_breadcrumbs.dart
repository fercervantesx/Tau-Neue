import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauBreadcrumbs,
)
Widget basicTauBreadcrumbs(BuildContext context) {
  return _BasicBreadcrumbsDemo();
}

class _BasicBreadcrumbsDemo extends StatefulWidget {
  @override
  State<_BasicBreadcrumbsDemo> createState() => _BasicBreadcrumbsDemoState();
}

class _BasicBreadcrumbsDemoState extends State<_BasicBreadcrumbsDemo> {
  String _currentPath = '/home/missions/sector-7/details';

  void _navigateTo(String path) {
    setState(() => _currentPath = path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TauBreadcrumbs(
            items: [
              TauBreadcrumb(
                label: 'HOME',
                onTap: () => _navigateTo('/home'),
              ),
              TauBreadcrumb(
                label: 'MISSIONS',
                onTap: () => _navigateTo('/home/missions'),
              ),
              TauBreadcrumb(
                label: 'SECTOR-7',
                onTap: () => _navigateTo('/home/missions/sector-7'),
              ),
              TauBreadcrumb(
                label: 'DETAILS',
                isCurrentPage: true,
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          Text(
            'Current path: $_currentPath',
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
  name: 'With Icons',
  type: TauBreadcrumbs,
)
Widget iconsTauBreadcrumbs(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauBreadcrumbs(
      items: [
        TauBreadcrumb(
          label: 'DASHBOARD',
          icon: const Icon(IconData(0xe871, fontFamily: 'MaterialIcons')), // dashboard
          onTap: () {},
        ),
        TauBreadcrumb(
          label: 'OPERATORS',
          icon: const Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')), // group
          onTap: () {},
        ),
        TauBreadcrumb(
          label: 'PROFILE',
          icon: const Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons')), // person
          isCurrentPage: true,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Separator',
  type: TauBreadcrumbs,
)
Widget customSeparatorTauBreadcrumbs(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauBreadcrumbs(
      separator: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          IconData(0xe5df, fontFamily: 'MaterialIcons'), // chevron_right
          size: 16.0,
          color: Color(0xFF8E8E8E),
        ),
      ),
      items: [
        TauBreadcrumb(label: 'ROOT', onTap: () {}),
        TauBreadcrumb(label: 'SYSTEMS', onTap: () {}),
        TauBreadcrumb(label: 'DIAGNOSTICS', isCurrentPage: true),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Collapsed (Overflow)',
  type: TauBreadcrumbs,
)
Widget collapsedTauBreadcrumbs(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Many items (maxItems: 5):',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        TauBreadcrumbs(
          maxItems: 5,
          items: [
            TauBreadcrumb(label: 'HOME', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-1', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-2', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-3', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-4', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-5', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-6', onTap: () {}),
            TauBreadcrumb(label: 'CURRENT', isCurrentPage: true),
          ],
        ),
        const SizedBox(height: 32.0),
        const Text(
          'All items shown:',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        TauBreadcrumbs(
          items: [
            TauBreadcrumb(label: 'HOME', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-1', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-2', onTap: () {}),
            TauBreadcrumb(label: 'LEVEL-3', onTap: () {}),
            TauBreadcrumb(label: 'CURRENT', isCurrentPage: true),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Single Item',
  type: TauBreadcrumbs,
)
Widget singleTauBreadcrumbs(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauBreadcrumbs(
      items: [
        TauBreadcrumb(
          label: 'HOME',
          icon: const Icon(IconData(0xe88a, fontFamily: 'MaterialIcons')), // home
          isCurrentPage: true,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Non-interactive',
  type: TauBreadcrumbs,
)
Widget nonInteractiveTauBreadcrumbs(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauBreadcrumbs(
      items: const [
        TauBreadcrumb(label: 'ARCHIVES'),
        TauBreadcrumb(label: '2024'),
        TauBreadcrumb(label: 'Q4'),
        TauBreadcrumb(label: 'REPORTS', isCurrentPage: true),
      ],
    ),
  );
}
