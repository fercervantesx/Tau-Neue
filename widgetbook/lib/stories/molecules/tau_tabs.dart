import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Horizontal',
  type: TauTabs,
)
Widget horizontalTauTabs(BuildContext context) {
  return _HorizontalTauTabsDemo();
}

class _HorizontalTauTabsDemo extends StatefulWidget {
  @override
  State<_HorizontalTauTabsDemo> createState() => _HorizontalTauTabsDemoState();
}

class _HorizontalTauTabsDemoState extends State<_HorizontalTauTabsDemo> {
  String _currentTab = 'overview';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TauTabs(
            tabs: const [
              TauTab(id: 'overview', label: 'OVERVIEW'),
              TauTab(id: 'details', label: 'DETAILS'),
              TauTab(id: 'logs', label: 'LOGS'),
              TauTab(id: 'settings', label: 'SETTINGS'),
            ],
            currentTabId: _currentTab,
            onTabSelected: (id) => setState(() => _currentTab = id),
          ),
          const SizedBox(height: 32.0),
          Text(
            'Current tab: $_currentTab',
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
  name: 'Vertical',
  type: TauTabs,
)
Widget verticalTauTabs(BuildContext context) {
  return _VerticalTauTabsDemo();
}

class _VerticalTauTabsDemo extends StatefulWidget {
  @override
  State<_VerticalTauTabsDemo> createState() => _VerticalTauTabsDemoState();
}

class _VerticalTauTabsDemoState extends State<_VerticalTauTabsDemo> {
  String _currentTab = 'overview';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TauTabs(
            axis: Axis.vertical,
            tabs: const [
              TauTab(id: 'overview', label: 'OVERVIEW'),
              TauTab(id: 'details', label: 'DETAILS'),
              TauTab(id: 'logs', label: 'LOGS'),
              TauTab(id: 'settings', label: 'SETTINGS'),
            ],
            currentTabId: _currentTab,
            onTabSelected: (id) => setState(() => _currentTab = id),
          ),
          const SizedBox(width: 32.0),
          Text(
            'Current: $_currentTab',
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
  type: TauTabs,
)
Widget iconsTauTabs(BuildContext context) {
  return _IconsTauTabsDemo();
}

class _IconsTauTabsDemo extends StatefulWidget {
  @override
  State<_IconsTauTabsDemo> createState() => _IconsTauTabsDemoState();
}

class _IconsTauTabsDemoState extends State<_IconsTauTabsDemo> {
  String _currentTab = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauTabs(
        tabs: const [
          TauTab(
            id: 'dashboard',
            label: 'DASHBOARD',
            icon: Icon(IconData(0xe871, fontFamily: 'MaterialIcons')), // dashboard
          ),
          TauTab(
            id: 'missions',
            label: 'MISSIONS',
            icon: Icon(IconData(0xe55c, fontFamily: 'MaterialIcons')), // assignment
          ),
          TauTab(
            id: 'operators',
            label: 'OPERATORS',
            icon: Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')), // group
          ),
          TauTab(
            id: 'analytics',
            label: 'ANALYTICS',
            icon: Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')), // show_chart
          ),
        ],
        currentTabId: _currentTab,
        onTabSelected: (id) => setState(() => _currentTab = id),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Badges',
  type: TauTabs,
)
Widget badgesTauTabs(BuildContext context) {
  return _BadgesTauTabsDemo();
}

class _BadgesTauTabsDemo extends StatefulWidget {
  @override
  State<_BadgesTauTabsDemo> createState() => _BadgesTauTabsDemoState();
}

class _BadgesTauTabsDemoState extends State<_BadgesTauTabsDemo> {
  String _currentTab = 'inbox';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauTabs(
        tabs: const [
          TauTab(
            id: 'inbox',
            label: 'INBOX',
            icon: Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
            badge: '12',
          ),
          TauTab(
            id: 'drafts',
            label: 'DRAFTS',
            icon: Icon(IconData(0xe151, fontFamily: 'MaterialIcons')),
            badge: '3',
          ),
          TauTab(
            id: 'sent',
            label: 'SENT',
            icon: Icon(IconData(0xe163, fontFamily: 'MaterialIcons')),
          ),
          TauTab(
            id: 'archive',
            label: 'ARCHIVE',
            icon: Icon(IconData(0xe149, fontFamily: 'MaterialIcons')),
          ),
        ],
        currentTabId: _currentTab,
        onTabSelected: (id) => setState(() => _currentTab = id),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Disabled Tab',
  type: TauTabs,
)
Widget disabledTauTabs(BuildContext context) {
  return _DisabledTauTabsDemo();
}

class _DisabledTauTabsDemo extends StatefulWidget {
  @override
  State<_DisabledTauTabsDemo> createState() => _DisabledTauTabsDemoState();
}

class _DisabledTauTabsDemoState extends State<_DisabledTauTabsDemo> {
  String _currentTab = 'overview';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauTabs(
        tabs: const [
          TauTab(id: 'overview', label: 'OVERVIEW'),
          TauTab(id: 'details', label: 'DETAILS'),
          TauTab(id: 'logs', label: 'LOGS', enabled: false),
          TauTab(id: 'settings', label: 'SETTINGS'),
        ],
        currentTabId: _currentTab,
        onTabSelected: (id) => setState(() => _currentTab = id),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Many Tabs',
  type: TauTabs,
)
Widget manyTauTabs(BuildContext context) {
  return _ManyTauTabsDemo();
}

class _ManyTauTabsDemo extends StatefulWidget {
  @override
  State<_ManyTauTabsDemo> createState() => _ManyTauTabsDemoState();
}

class _ManyTauTabsDemoState extends State<_ManyTauTabsDemo> {
  String _currentTab = 'tab1';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: TauTabs(
          tabs: List.generate(
            12,
            (i) => TauTab(
              id: 'tab${i + 1}',
              label: 'SECTOR ${i + 1}',
            ),
          ),
          currentTabId: _currentTab,
          onTabSelected: (id) => setState(() => _currentTab = id),
        ),
      ),
    );
  }
}
