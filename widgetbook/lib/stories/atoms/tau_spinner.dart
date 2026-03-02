import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Size Variants',
  type: TauSpinner,
)
Widget sizesTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        TauSpinner(
          size: TauSpinnerSize.small,
          label: 'SMALL',
        ),
        TauSpinner(
          size: TauSpinnerSize.medium,
          label: 'MEDIUM',
        ),
        TauSpinner(
          size: TauSpinnerSize.large,
          label: 'LARGE',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Label',
  type: TauSpinner,
)
Widget noLabelTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const Center(
      child: TauSpinner(),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Label',
  type: TauSpinner,
)
Widget labelTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        TauSpinner(
          label: 'LOADING...',
        ),
        TauSpinner(
          label: 'PROCESSING DATA...',
        ),
        TauSpinner(
          label: 'ESTABLISHING CONNECTION...',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Color Variants',
  type: TauSpinner,
)
Widget colorTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        TauSpinner(
          color: Color(0xFFC0FC04), // Primary
          label: 'PRIMARY',
        ),
        TauSpinner(
          color: Color(0xFFEA027E), // Secondary
          label: 'SECONDARY',
        ),
        TauSpinner(
          color: Color(0xFF3601FB), // Info
          label: 'INFO',
        ),
        TauSpinner(
          color: Color(0xFFFF5500), // Critical
          label: 'CRITICAL',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'In Container',
  type: TauSpinner,
)
Widget containerTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border.all(
          color: const Color(0xFF2A2A2A),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const Center(
        child: TauSpinner(
          size: TauSpinnerSize.large,
          label: 'LOADING CONTENT...',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading States',
  type: TauSpinner,
)
Widget loadingStatesTauSpinner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Row(
            children: [
              TauSpinner(size: TauSpinnerSize.small),
              SizedBox(width: 16.0),
              Text(
                'INITIALIZING SYSTEM...',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Row(
            children: [
              TauSpinner(size: TauSpinnerSize.small),
              SizedBox(width: 16.0),
              Text(
                'SYNCING DATA...',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Row(
            children: [
              TauSpinner(size: TauSpinnerSize.small),
              SizedBox(width: 16.0),
              Text(
                'UPLOADING FILES...',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
