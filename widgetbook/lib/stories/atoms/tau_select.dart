import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: TauSelect,
)
Widget defaultTauSelect(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauSelect<String>(
          value: null,
          placeholder: 'SELECT PROTOCOL...',
          options: const [
            TauSelectOption(value: 'alpha', label: 'ALPHA PROTOCOL'),
            TauSelectOption(value: 'beta', label: 'BETA SEQUENCE'),
            TauSelectOption(value: 'gamma', label: 'GAMMA DIRECTIVE'),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauSelect<String>(
          value: 'beta',
          options: const [
            TauSelectOption(value: 'alpha', label: 'ALPHA PROTOCOL'),
            TauSelectOption(value: 'beta', label: 'BETA SEQUENCE'),
            TauSelectOption(value: 'gamma', label: 'GAMMA DIRECTIVE'),
          ],
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Width',
  type: TauSelect,
)
Widget widthTauSelect(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauSelect<String>(
          value: 'medium',
          width: 200.0,
          options: const [
            TauSelectOption(value: 'small', label: 'SMALL'),
            TauSelectOption(value: 'medium', label: 'MEDIUM'),
            TauSelectOption(value: 'large', label: 'LARGE'),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauSelect<String>(
          value: 'option2',
          width: 300.0,
          options: const [
            TauSelectOption(value: 'option1', label: 'OPTION ONE'),
            TauSelectOption(value: 'option2', label: 'OPTION TWO'),
            TauSelectOption(value: 'option3', label: 'OPTION THREE'),
          ],
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Many Options',
  type: TauSelect,
)
Widget manyOptionsTauSelect(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauSelect<int>(
      value: 5,
      width: 250.0,
      options: List.generate(
        15,
        (index) => TauSelectOption(
          value: index + 1,
          label: 'SECTOR ${(index + 1).toString().padLeft(2, '0')}',
        ),
      ),
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Options',
  type: TauSelect,
)
Widget disabledOptionsTauSelect(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauSelect<String>(
      value: 'available',
      width: 250.0,
      options: const [
        TauSelectOption(value: 'available', label: 'AVAILABLE'),
        TauSelectOption(value: 'restricted', label: 'RESTRICTED', enabled: false),
        TauSelectOption(value: 'classified', label: 'CLASSIFIED', enabled: false),
        TauSelectOption(value: 'public', label: 'PUBLIC'),
      ],
      onChanged: (value) {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: TauSelect,
)
Widget disabledTauSelect(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TauSelect<String>(
          value: null,
          enabled: false,
          placeholder: 'DISABLED SELECT...',
          options: const [
            TauSelectOption(value: 'option1', label: 'OPTION ONE'),
            TauSelectOption(value: 'option2', label: 'OPTION TWO'),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 16.0),
        TauSelect<String>(
          value: 'option1',
          enabled: false,
          options: const [
            TauSelectOption(value: 'option1', label: 'OPTION ONE'),
            TauSelectOption(value: 'option2', label: 'OPTION TWO'),
          ],
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauSelect,
)
Widget interactiveTauSelect(BuildContext context) {
  return _InteractiveTauSelectDemo();
}

class _InteractiveTauSelectDemo extends StatefulWidget {
  @override
  State<_InteractiveTauSelectDemo> createState() =>
      _InteractiveTauSelectDemoState();
}

class _InteractiveTauSelectDemoState extends State<_InteractiveTauSelectDemo> {
  String? _securityLevel = 'medium';
  String? _region = 'north-america';

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
          const SizedBox(height: 8.0),
          TauSelect<String>(
            value: _securityLevel,
            width: 300.0,
            placeholder: 'SELECT LEVEL...',
            options: const [
              TauSelectOption(value: 'low', label: 'LOW SECURITY'),
              TauSelectOption(value: 'medium', label: 'MEDIUM SECURITY'),
              TauSelectOption(value: 'high', label: 'HIGH SECURITY'),
              TauSelectOption(value: 'maximum', label: 'MAXIMUM SECURITY'),
            ],
            onChanged: (value) => setState(() => _securityLevel = value),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'DEPLOYMENT REGION:',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          TauSelect<String>(
            value: _region,
            width: 300.0,
            placeholder: 'SELECT REGION...',
            options: const [
              TauSelectOption(value: 'north-america', label: 'NORTH AMERICA'),
              TauSelectOption(value: 'south-america', label: 'SOUTH AMERICA'),
              TauSelectOption(value: 'europe', label: 'EUROPE'),
              TauSelectOption(value: 'asia', label: 'ASIA'),
              TauSelectOption(value: 'africa', label: 'AFRICA'),
              TauSelectOption(value: 'oceania', label: 'OCEANIA'),
            ],
            onChanged: (value) => setState(() => _region = value),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Selected: $_securityLevel / $_region',
            style: const TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
