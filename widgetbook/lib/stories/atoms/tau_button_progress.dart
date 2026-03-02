import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'With Progress', type: TauButton)
Widget tauButtonWithProgress(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TauButton(
          label: context.knobs.string(
            label: 'Label',
            initialValue: 'DOWNLOADING - 75%',
          ),
          variant: TauButtonVariant.primary,
          width: 300.0,
          progress: context.knobs.double.slider(
            label: 'Progress',
            initialValue: 0.75,
            min: 0.0,
            max: 1.0,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        TauButton(
          label: 'UPLOAD COMPLETE',
          variant: TauButtonVariant.secondary,
          width: 300.0,
          progress: 1.0,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        TauButton(
          label: 'INITIALIZING - 15%',
          variant: TauButtonVariant.ghost,
          width: 300.0,
          progress: 0.15,
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Pill With Progress', type: TauButton)
Widget tauButtonPillWithProgress(BuildContext context) {
  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'LOADING',
      ),
      variant: TauButtonVariant.primary,
      isPill: true,
      width: context.knobs.double.slider(
        label: 'Width',
        initialValue: 200.0,
        min: 120.0,
        max: 400.0,
      ),
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 48.0,
        min: 32.0,
        max: 64.0,
      ),
      progress: context.knobs.double.slider(
        label: 'Progress',
        initialValue: 0.42,
        min: 0.0,
        max: 1.0,
      ),
      onPressed: () {},
    ),
  );
}
