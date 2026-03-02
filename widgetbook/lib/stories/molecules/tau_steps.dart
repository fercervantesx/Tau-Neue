import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Horizontal',
  type: TauSteps,
)
Widget horizontalTauSteps(BuildContext context) {
  return _HorizontalStepsDemo();
}

class _HorizontalStepsDemo extends StatefulWidget {
  @override
  State<_HorizontalStepsDemo> createState() => _HorizontalStepsDemoState();
}

class _HorizontalStepsDemoState extends State<_HorizontalStepsDemo> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          TauSteps(
            currentStep: _currentStep,
            steps: const [
              TauStep(label: 'CONFIGURE'),
              TauStep(label: 'VALIDATE'),
              TauStep(label: 'DEPLOY'),
              TauStep(label: 'VERIFY'),
            ],
            onStepTapped: (index) => setState(() => _currentStep = index),
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentStep > 0)
                TauButton(
                  label: 'PREVIOUS',
                  variant: TauButtonVariant.secondary,
                  onPressed: () => setState(() => _currentStep--),
                ),
              const SizedBox(width: 16.0),
              if (_currentStep < 3)
                TauButton(
                  label: 'NEXT',
                  onPressed: () => setState(() => _currentStep++),
                ),
              if (_currentStep == 3)
                TauButton(
                  label: 'FINISH',
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Vertical',
  type: TauSteps,
)
Widget verticalTauSteps(BuildContext context) {
  return _VerticalStepsDemo();
}

class _VerticalStepsDemo extends StatefulWidget {
  @override
  State<_VerticalStepsDemo> createState() => _VerticalStepsDemoState();
}

class _VerticalStepsDemoState extends State<_VerticalStepsDemo> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TauSteps(
            axis: Axis.vertical,
            currentStep: _currentStep,
            steps: const [
              TauStep(label: 'CONFIGURE'),
              TauStep(label: 'VALIDATE'),
              TauStep(label: 'DEPLOY'),
              TauStep(label: 'VERIFY'),
            ],
            onStepTapped: (index) => setState(() => _currentStep = index),
          ),
          const SizedBox(width: 32.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${_currentStep + 1} of 4',
                style: const TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Descriptions',
  type: TauSteps,
)
Widget descriptiveTauSteps(BuildContext context) {
  return _DescriptiveStepsDemo();
}

class _DescriptiveStepsDemo extends StatefulWidget {
  @override
  State<_DescriptiveStepsDemo> createState() => _DescriptiveStepsDemoState();
}

class _DescriptiveStepsDemoState extends State<_DescriptiveStepsDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauSteps(
        axis: Axis.vertical,
        currentStep: _currentStep,
        steps: const [
          TauStep(
            label: 'SYSTEM CONFIGURATION',
            description: 'Set up initial parameters and preferences',
          ),
          TauStep(
            label: 'DATA VALIDATION',
            description: 'Verify inputs and check for conflicts',
          ),
          TauStep(
            label: 'DEPLOYMENT',
            description: 'Deploy to target environment',
          ),
          TauStep(
            label: 'VERIFICATION',
            description: 'Confirm successful deployment',
          ),
        ],
        onStepTapped: (index) => setState(() => _currentStep = index),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: TauSteps,
)
Widget iconsTauSteps(BuildContext context) {
  return _IconsStepsDemo();
}

class _IconsStepsDemo extends StatefulWidget {
  @override
  State<_IconsStepsDemo> createState() => _IconsStepsDemoState();
}

class _IconsStepsDemoState extends State<_IconsStepsDemo> {
  int _currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauSteps(
        currentStep: _currentStep,
        steps: const [
          TauStep(
            label: 'USER INFO',
            icon: Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons')), // person
          ),
          TauStep(
            label: 'ADDRESS',
            icon: Icon(IconData(0xe0c8, fontFamily: 'MaterialIcons')), // location_on
          ),
          TauStep(
            label: 'PAYMENT',
            icon: Icon(IconData(0xe8f7, fontFamily: 'MaterialIcons')), // payment
          ),
          TauStep(
            label: 'CONFIRM',
            icon: Icon(IconData(0xe5ca, fontFamily: 'MaterialIcons')), // check_circle
          ),
        ],
        onStepTapped: (index) => setState(() => _currentStep = index),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Non-interactive',
  type: TauSteps,
)
Widget nonInteractiveTauSteps(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauSteps(
      currentStep: 2,
      steps: const [
        TauStep(label: 'INITIALIZE'),
        TauStep(label: 'PROCESS'),
        TauStep(label: 'COMPLETE'),
      ],
      // No onStepTapped callback = non-interactive
    ),
  );
}

@widgetbook.UseCase(
  name: 'Many Steps',
  type: TauSteps,
)
Widget manyTauSteps(BuildContext context) {
  return _ManyStepsDemo();
}

class _ManyStepsDemo extends StatefulWidget {
  @override
  State<_ManyStepsDemo> createState() => _ManyStepsDemoState();
}

class _ManyStepsDemoState extends State<_ManyStepsDemo> {
  int _currentStep = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: TauSteps(
          axis: Axis.vertical,
          currentStep: _currentStep,
          steps: List.generate(
            8,
            (i) => TauStep(
              label: 'PHASE ${i + 1}',
              description: 'Step ${i + 1} of the deployment process',
            ),
          ),
          onStepTapped: (index) => setState(() => _currentStep = index),
        ),
      ),
    );
  }
}
