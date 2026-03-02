import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'From Right',
  type: TauDrawer,
)
Widget rightTauDrawer(BuildContext context) {
  return _DrawerDemo(direction: TauDrawerDirection.right);
}

@widgetbook.UseCase(
  name: 'From Left',
  type: TauDrawer,
)
Widget leftTauDrawer(BuildContext context) {
  return _DrawerDemo(direction: TauDrawerDirection.left);
}

@widgetbook.UseCase(
  name: 'From Top',
  type: TauDrawer,
)
Widget topTauDrawer(BuildContext context) {
  return _DrawerDemo(
    direction: TauDrawerDirection.top,
    useHeight: true,
  );
}

@widgetbook.UseCase(
  name: 'From Bottom',
  type: TauDrawer,
)
Widget bottomTauDrawer(BuildContext context) {
  return _DrawerDemo(
    direction: TauDrawerDirection.bottom,
    useHeight: true,
  );
}

class _DrawerDemo extends StatelessWidget {
  const _DrawerDemo({
    required this.direction,
    this.useHeight = false,
  });

  final TauDrawerDirection direction;
  final bool useHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: Center(
        child: TauButton(
          label: 'OPEN DRAWER',
          onPressed: () {
            showTauDrawer(
              context: context,
              direction: direction,
              width: useHeight ? null : 400.0,
              height: useHeight ? 400.0 : null,
              builder: (context) => TauDrawer(
                header: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'DRAWER PANEL',
                        style: TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        IconData(0xe5cd, fontFamily: 'MaterialIcons'), // close
                        color: Color(0xFF8E8E8E),
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'PANEL CONTENT',
                      style: TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'This is a drawer panel that slides in from the edge of the screen. Tap the backdrop to dismiss.',
                      style: TextStyle(
                        color: Color(0xFF8E8E8E),
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TauInput(
                      placeholder: 'Search...',
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16.0),
                    ...List.generate(
                      5,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TauListTile(
                          title: Text('ITEM ${i + 1}'),
                          leading: const Icon(
                            IconData(0xe24d, fontFamily: 'MaterialIcons'),
                            color: Color(0xFF8E8E8E),
                            size: 20.0,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                footer: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TauButton(
                      label: 'CANCEL',
                      variant: TauButtonVariant.ghost,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 16.0),
                    TauButton(
                      label: 'APPLY',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Settings Form',
  type: TauDrawer,
)
Widget settingsFormTauDrawer(BuildContext context) {
  return Container(
    color: const Color(0xFF1A1A1A),
    child: Center(
      child: TauButton(
        label: 'OPEN SETTINGS',
        onPressed: () {
          showTauDrawer(
            context: context,
            direction: TauDrawerDirection.right,
            width: 450.0,
            builder: (context) => TauDrawer(
              header: Row(
                children: [
                  const Icon(
                    IconData(0xe8b8, fontFamily: 'MaterialIcons'), // settings
                    color: Color(0xFFC0FC04),
                    size: 20.0,
                  ),
                  const SizedBox(width: 12.0),
                  const Expanded(
                    child: Text(
                      'SYSTEM SETTINGS',
                      style: TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
              body: TauFormLayout(
                fields: [
                  TauFormField(
                    label: 'System Name',
                    isRequired: true,
                    child: TauInput(
                      placeholder: 'Enter system name',
                      onChanged: (value) {},
                    ),
                  ),
                  TauFormField(
                    label: 'Environment',
                    child: TauSelect<String>(
                      value: 'production',
                      options: const [
                        TauSelectOption(value: 'development', label: 'Development'),
                        TauSelectOption(value: 'staging', label: 'Staging'),
                        TauSelectOption(value: 'production', label: 'Production'),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  TauFormField(
                    label: 'Email Alerts',
                    child: TauToggle(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  TauFormField(
                    label: 'Push Notifications',
                    child: TauToggle(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TauButton(
                    label: 'CANCEL',
                    variant: TauButtonVariant.ghost,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 16.0),
                  TauButton(
                    label: 'SAVE CHANGES',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Narrow Panel',
  type: TauDrawer,
)
Widget narrowTauDrawer(BuildContext context) {
  return Container(
    color: const Color(0xFF1A1A1A),
    child: Center(
      child: TauButton(
        label: 'OPEN NOTIFICATIONS',
        onPressed: () {
          showTauDrawer(
            context: context,
            direction: TauDrawerDirection.right,
            width: 320.0,
            builder: (context) => TauDrawer(
              header: const Text(
                'NOTIFICATIONS',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  8,
                  (i) => Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      border: Border.all(
                        color: const Color(0xFF3A3A3A),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOTIFICATION ${i + 1}',
                          style: const TextStyle(
                            color: Color(0xFFE0E0E0),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'System update available',
                          style: TextStyle(
                            color: Color(0xFF8E8E8E),
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Wide Panel',
  type: TauDrawer,
)
Widget wideTauDrawer(BuildContext context) {
  return Container(
    color: const Color(0xFF1A1A1A),
    child: Center(
      child: TauButton(
        label: 'OPEN ANALYTICS',
        onPressed: () {
          showTauDrawer(
            context: context,
            direction: TauDrawerDirection.right,
            width: 600.0,
            builder: (context) => TauDrawer(
              header: const Text(
                'ANALYTICS DASHBOARD',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TauStatsGrid(
                    stats: const [
                      TauStatCard(
                        label: 'TOTAL USERS',
                        value: '12,345',
                        change: '+12%',
                        trend: TauStatTrend.up,
                      ),
                      TauStatCard(
                        label: 'ACTIVE SESSIONS',
                        value: '1,234',
                        change: '+5%',
                        trend: TauStatTrend.up,
                      ),
                      TauStatCard(
                        label: 'RESPONSE TIME',
                        value: '145ms',
                        change: '-8%',
                        trend: TauStatTrend.down,
                      ),
                      TauStatCard(
                        label: 'ERROR RATE',
                        value: '0.05%',
                        change: '+0.02%',
                        trend: TauStatTrend.up,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'RECENT ACTIVITY',
                    style: TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ...List.generate(
                    5,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TauListTile(
                        title: Text('EVENT ${i + 1}'),
                        trailing: TauBadge(
                          label: 'INFO',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
