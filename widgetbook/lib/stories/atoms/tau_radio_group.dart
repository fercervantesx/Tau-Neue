import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Vertical',
  type: TauRadioGroup,
)
Widget verticalTauRadioGroup(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauRadioGroup<String>(
      value: 'alpha',
      options: const [
        TauRadioOption(value: 'alpha', label: 'ALPHA PROTOCOL'),
        TauRadioOption(value: 'beta', label: 'BETA SEQUENCE'),
        TauRadioOption(value: 'gamma', label: 'GAMMA DIRECTIVE'),
      ],
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Horizontal',
  type: TauRadioGroup,
)
Widget horizontalTauRadioGroup(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauRadioGroup<String>(
      value: 'medium',
      axis: Axis.horizontal,
      options: const [
        TauRadioOption(value: 'low', label: 'LOW'),
        TauRadioOption(value: 'medium', label: 'MEDIUM'),
        TauRadioOption(value: 'high', label: 'HIGH'),
      ],
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Options',
  type: TauRadioGroup,
)
Widget disabledTauRadioGroup(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauRadioGroup<int>(
      value: 1,
      options: const [
        TauRadioOption(value: 1, label: 'OPTION 1'),
        TauRadioOption(value: 2, label: 'OPTION 2 (DISABLED)', enabled: false),
        TauRadioOption(value: 3, label: 'OPTION 3'),
        TauRadioOption(value: 4, label: 'OPTION 4 (DISABLED)', enabled: false),
      ],
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Fully Disabled',
  type: TauRadioGroup,
)
Widget fullyDisabledTauRadioGroup(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauRadioGroup<String>(
      value: 'beta',
      enabled: false,
      options: const [
        TauRadioOption(value: 'alpha', label: 'ALPHA PROTOCOL'),
        TauRadioOption(value: 'beta', label: 'BETA SEQUENCE'),
        TauRadioOption(value: 'gamma', label: 'GAMMA DIRECTIVE'),
      ],
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauRadioGroup,
)
Widget interactiveTauRadioGroup(BuildContext context) {
  return _InteractiveTauRadioGroupDemo();
}

class _InteractiveTauRadioGroupDemo extends StatefulWidget {
  @override
  State<_InteractiveTauRadioGroupDemo> createState() =>
      _InteractiveTauRadioGroupDemoState();
}

class _InteractiveTauRadioGroupDemoState
    extends State<_InteractiveTauRadioGroupDemo> {
  String _securityLevel = 'medium';
  String _deploymentMode = 'production';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'SECURITY LEVEL:',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          TauRadioGroup<String>(
            value: _securityLevel,
            options: const [
              TauRadioOption(value: 'low', label: 'LOW SECURITY'),
              TauRadioOption(value: 'medium', label: 'MEDIUM SECURITY'),
              TauRadioOption(value: 'high', label: 'HIGH SECURITY'),
              TauRadioOption(value: 'maximum', label: 'MAXIMUM SECURITY'),
            ],
            onChanged: (value) => setState(() => _securityLevel = value),
          ),
          const SizedBox(height: 32.0),
          const Text(
            'DEPLOYMENT MODE:',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          TauRadioGroup<String>(
            value: _deploymentMode,
            axis: Axis.horizontal,
            spacing: 24.0,
            options: const [
              TauRadioOption(value: 'development', label: 'DEV'),
              TauRadioOption(value: 'staging', label: 'STAGING'),
              TauRadioOption(value: 'production', label: 'PROD'),
            ],
            onChanged: (value) => setState(() => _deploymentMode = value),
          ),
        ],
      ),
    );
  }
}
