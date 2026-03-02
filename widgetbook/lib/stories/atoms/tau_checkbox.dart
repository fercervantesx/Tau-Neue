import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: TauCheckbox,
)
Widget defaultTauCheckbox(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauCheckbox(
          value: false,
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauCheckbox(
          value: true,
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauCheckbox(
          value: false,
          indeterminate: true,
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Label',
  type: TauCheckbox,
)
Widget labelTauCheckbox(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauCheckbox(
          value: false,
          label: 'ACCEPT TERMS',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauCheckbox(
          value: true,
          label: 'ENABLE NOTIFICATIONS',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauCheckbox(
          value: false,
          indeterminate: true,
          label: 'PARTIAL SELECTION',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: TauCheckbox,
)
Widget disabledTauCheckbox(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauCheckbox(
          value: false,
          enabled: false,
          label: 'DISABLED UNCHECKED',
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauCheckbox(
          value: true,
          enabled: false,
          label: 'DISABLED CHECKED',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauCheckbox,
)
Widget interactiveTauCheckbox(BuildContext context) {
  return _InteractiveTauCheckboxDemo();
}

class _InteractiveTauCheckboxDemo extends StatefulWidget {
  @override
  State<_InteractiveTauCheckboxDemo> createState() =>
      _InteractiveTauCheckboxDemoState();
}

class _InteractiveTauCheckboxDemoState
    extends State<_InteractiveTauCheckboxDemo> {
  bool _option1 = false;
  bool _option2 = true;
  bool _option3 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TauCheckbox(
            value: _option1,
            label: 'TACTICAL MODE',
            onChanged: (value) => setState(() => _option1 = value),
          ),
          const SizedBox(height: 16.0),
          TauCheckbox(
            value: _option2,
            label: 'SECURE PROTOCOL',
            onChanged: (value) => setState(() => _option2 = value),
          ),
          const SizedBox(height: 16.0),
          TauCheckbox(
            value: _option3,
            label: 'ENCRYPTED TRANSMISSION',
            onChanged: (value) => setState(() => _option3 = value),
          ),
        ],
      ),
    );
  }
}
