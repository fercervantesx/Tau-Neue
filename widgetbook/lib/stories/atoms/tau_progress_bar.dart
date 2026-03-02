import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Determinate',
  type: TauProgressBar,
)
Widget determinateTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(value: 0.0),
        SizedBox(height: 16.0),
        TauProgressBar(value: 0.25),
        SizedBox(height: 16.0),
        TauProgressBar(value: 0.5),
        SizedBox(height: 16.0),
        TauProgressBar(value: 0.75),
        SizedBox(height: 16.0),
        TauProgressBar(value: 1.0),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Indeterminate',
  type: TauProgressBar,
)
Widget indeterminateTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Label',
  type: TauProgressBar,
)
Widget labelTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(
          value: 0.35,
          label: 'DOWNLOADING ASSETS',
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.68,
          label: 'UPLOADING DATA',
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.92,
          label: 'ENCRYPTING FILES',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Percentage',
  type: TauProgressBar,
)
Widget percentageTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(
          value: 0.15,
          showPercentage: true,
        ),
        SizedBox(height: 16.0),
        TauProgressBar(
          value: 0.45,
          showPercentage: true,
        ),
        SizedBox(height: 16.0),
        TauProgressBar(
          value: 0.78,
          showPercentage: true,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Height Variants',
  type: TauProgressBar,
)
Widget heightTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(
          value: 0.65,
          height: 4.0,
          label: 'THIN (4px)',
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.65,
          height: 8.0,
          label: 'STANDARD (8px)',
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.65,
          height: 12.0,
          label: 'MEDIUM (12px)',
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.65,
          height: 16.0,
          label: 'THICK (16px)',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Color Variants',
  type: TauProgressBar,
)
Widget colorTauProgressBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauProgressBar(
          value: 0.7,
          label: 'PRIMARY (CHARTREUSE)',
          color: Color(0xFFC0FC04),
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.5,
          label: 'SECONDARY (HOT PINK)',
          color: Color(0xFFEA027E),
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.3,
          label: 'INFO (BLUE)',
          color: Color(0xFF3601FB),
        ),
        SizedBox(height: 24.0),
        TauProgressBar(
          value: 0.85,
          label: 'CRITICAL (ORANGE)',
          color: Color(0xFFFF5500),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauProgressBar,
)
Widget interactiveTauProgressBar(BuildContext context) {
  return _InteractiveTauProgressBarDemo();
}

class _InteractiveTauProgressBarDemo extends StatefulWidget {
  @override
  State<_InteractiveTauProgressBarDemo> createState() =>
      _InteractiveTauProgressBarDemoState();
}

class _InteractiveTauProgressBarDemoState
    extends State<_InteractiveTauProgressBarDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'SIMULATED DOWNLOAD',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return TauProgressBar(
                value: _animation.value,
                label:
                    'DOWNLOADING: ${(_animation.value * 100).toInt()}% COMPLETE',
                showPercentage: true,
              );
            },
          ),
          const SizedBox(height: 32.0),
          const Text(
            'INDETERMINATE LOADING',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const TauProgressBar(
            label: 'PROCESSING DATA...',
          ),
        ],
      ),
    );
  }
}
