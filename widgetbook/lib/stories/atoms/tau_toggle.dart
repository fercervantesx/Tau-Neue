import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: TauToggle,
)
Widget defaultTauToggle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauToggle(
          value: false,
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauToggle(
          value: true,
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Label',
  type: TauToggle,
)
Widget labelTauToggle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauToggle(
          value: false,
          label: 'SYSTEM INACTIVE',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauToggle(
          value: true,
          label: 'SYSTEM ACTIVE',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: TauToggle,
)
Widget disabledTauToggle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauToggle(
          value: false,
          enabled: false,
          label: 'DISABLED OFF',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauToggle(
          value: true,
          enabled: false,
          label: 'DISABLED ON',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Sizes',
  type: TauToggle,
)
Widget sizeTauToggle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauToggle(
          value: true,
          width: 36.0,
          height: 20.0,
          label: 'COMPACT',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauToggle(
          value: true,
          width: 44.0,
          height: 24.0,
          label: 'STANDARD',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauToggle(
          value: true,
          width: 56.0,
          height: 32.0,
          label: 'LARGE',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauToggle,
)
Widget interactiveTauToggle(BuildContext context) {
  return _InteractiveTauToggleDemo();
}

class _InteractiveTauToggleDemo extends StatefulWidget {
  @override
  State<_InteractiveTauToggleDemo> createState() =>
      _InteractiveTauToggleDemoState();
}

class _InteractiveTauToggleDemoState extends State<_InteractiveTauToggleDemo> {
  bool _encryption = true;
  bool _notifications = false;
  bool _autoSave = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TauToggle(
            value: _encryption,
            label: 'ENCRYPTION ENABLED',
            onChanged: (value) => setState(() => _encryption = value),
          ),
          const SizedBox(height: 16.0),
          TauToggle(
            value: _notifications,
            label: 'PUSH NOTIFICATIONS',
            onChanged: (value) => setState(() => _notifications = value),
          ),
          const SizedBox(height: 16.0),
          TauToggle(
            value: _autoSave,
            label: 'AUTO-SAVE PROTOCOL',
            onChanged: (value) => setState(() => _autoSave = value),
          ),
        ],
      ),
    );
  }
}
