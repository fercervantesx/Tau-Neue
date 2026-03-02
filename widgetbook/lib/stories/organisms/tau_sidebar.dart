import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauSidebar,
)
Widget basicTauSidebar(BuildContext context) {
  return _BasicSidebarDemo();
}

class _BasicSidebarDemo extends StatefulWidget {
  @override
  State<_BasicSidebarDemo> createState() => _BasicSidebarDemoState();
}

class _BasicSidebarDemoState extends State<_BasicSidebarDemo> {
  bool _isExpanded = true;
  String _currentItemId = 'missions';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          items: const [
            TauSidebarItem(
              id: 'dashboard',
              label: 'DASHBOARD',
              icon: Icon(IconData(0xe871, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'missions',
              label: 'MISSIONS',
              icon: Icon(IconData(0xe55c, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'operators',
              label: 'OPERATORS',
              icon: Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'analytics',
              label: 'ANALYTICS',
              icon: Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
            ),
          ],
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current: $_currentItemId',
                  style: const TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  _isExpanded ? 'Sidebar is expanded' : 'Sidebar is collapsed',
                  style: const TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'With Badges',
  type: TauSidebar,
)
Widget badgesTauSidebar(BuildContext context) {
  return _BadgesSidebarDemo();
}

class _BadgesSidebarDemo extends StatefulWidget {
  @override
  State<_BadgesSidebarDemo> createState() => _BadgesSidebarDemoState();
}

class _BadgesSidebarDemoState extends State<_BadgesSidebarDemo> {
  bool _isExpanded = true;
  String _currentItemId = 'inbox';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          items: const [
            TauSidebarItem(
              id: 'inbox',
              label: 'INBOX',
              icon: Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
              badge: '12',
            ),
            TauSidebarItem(
              id: 'drafts',
              label: 'DRAFTS',
              icon: Icon(IconData(0xe151, fontFamily: 'MaterialIcons')),
              badge: '3',
            ),
            TauSidebarItem(
              id: 'sent',
              label: 'SENT',
              icon: Icon(IconData(0xe163, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'archive',
              label: 'ARCHIVE',
              icon: Icon(IconData(0xe149, fontFamily: 'MaterialIcons')),
            ),
          ],
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Current: $_currentItemId\nBadges are hidden when collapsed',
              style: const TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'With Header',
  type: TauSidebar,
)
Widget headerTauSidebar(BuildContext context) {
  return _HeaderSidebarDemo();
}

class _HeaderSidebarDemo extends StatefulWidget {
  @override
  State<_HeaderSidebarDemo> createState() => _HeaderSidebarDemoState();
}

class _HeaderSidebarDemoState extends State<_HeaderSidebarDemo> {
  bool _isExpanded = true;
  String _currentItemId = 'home';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          header: const Column(
            children: [
              Icon(
                IconData(0xe86d, fontFamily: 'MaterialIcons'), // flight
                color: Color(0xFFC0FC04),
                size: 32.0,
              ),
              SizedBox(height: 8.0),
              Text(
                'TAU SYSTEM',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          items: const [
            TauSidebarItem(
              id: 'home',
              label: 'HOME',
              icon: Icon(IconData(0xe88a, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'explore',
              label: 'EXPLORE',
              icon: Icon(IconData(0xe8b6, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'library',
              label: 'LIBRARY',
              icon: Icon(IconData(0xe02e, fontFamily: 'MaterialIcons')),
            ),
          ],
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Current: $_currentItemId',
              style: const TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'With Footer',
  type: TauSidebar,
)
Widget footerTauSidebar(BuildContext context) {
  return _FooterSidebarDemo();
}

class _FooterSidebarDemo extends StatefulWidget {
  @override
  State<_FooterSidebarDemo> createState() => _FooterSidebarDemoState();
}

class _FooterSidebarDemoState extends State<_FooterSidebarDemo> {
  bool _isExpanded = true;
  String _currentItemId = 'overview';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          items: const [
            TauSidebarItem(
              id: 'overview',
              label: 'OVERVIEW',
              icon: Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'details',
              label: 'DETAILS',
              icon: Icon(IconData(0xe873, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'settings',
              label: 'SETTINGS',
              icon: Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
            ),
          ],
          footer: const Row(
            children: [
              Icon(
                IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'USER-001',
                  style: TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 11.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Current: $_currentItemId',
              style: const TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'Collapsed by Default',
  type: TauSidebar,
)
Widget collapsedTauSidebar(BuildContext context) {
  return _CollapsedSidebarDemo();
}

class _CollapsedSidebarDemo extends StatefulWidget {
  @override
  State<_CollapsedSidebarDemo> createState() => _CollapsedSidebarDemoState();
}

class _CollapsedSidebarDemoState extends State<_CollapsedSidebarDemo> {
  bool _isExpanded = false;
  String _currentItemId = 'files';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          items: const [
            TauSidebarItem(
              id: 'files',
              label: 'FILES',
              icon: Icon(IconData(0xe24d, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'search',
              label: 'SEARCH',
              icon: Icon(IconData(0xe8b6, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'source',
              label: 'SOURCE',
              icon: Icon(IconData(0xe86f, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'debug',
              label: 'DEBUG',
              icon: Icon(IconData(0xe868, fontFamily: 'MaterialIcons')),
            ),
          ],
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Current: $_currentItemId\nSidebar starts collapsed',
              style: const TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'Custom Widths',
  type: TauSidebar,
)
Widget customWidthsTauSidebar(BuildContext context) {
  return _CustomWidthsSidebarDemo();
}

class _CustomWidthsSidebarDemo extends StatefulWidget {
  @override
  State<_CustomWidthsSidebarDemo> createState() => _CustomWidthsSidebarDemoState();
}

class _CustomWidthsSidebarDemoState extends State<_CustomWidthsSidebarDemo> {
  bool _isExpanded = true;
  String _currentItemId = 'item1';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TauSidebar(
          isExpanded: _isExpanded,
          currentItemId: _currentItemId,
          expandedWidth: 280.0,
          collapsedWidth: 80.0,
          items: const [
            TauSidebarItem(
              id: 'item1',
              label: 'ITEM ONE',
              icon: Icon(IconData(0xe5ca, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'item2',
              label: 'ITEM TWO',
              icon: Icon(IconData(0xe5ca, fontFamily: 'MaterialIcons')),
            ),
            TauSidebarItem(
              id: 'item3',
              label: 'ITEM THREE',
              icon: Icon(IconData(0xe5ca, fontFamily: 'MaterialIcons')),
            ),
          ],
          onItemSelected: (id) => setState(() => _currentItemId = id),
          onToggle: () => setState(() => _isExpanded = !_isExpanded),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: const Text(
              'Expanded: 280px\nCollapsed: 80px',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
