import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TauInput)
Widget tauInputDefault(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauInput(
      placeholder: context.knobs.string(
        label: 'Placeholder',
        initialValue: 'Enter authorization code...',
      ),
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      obscureText: context.knobs.boolean(
        label: 'Obscure Text',
        initialValue: false,
      ),
      maxLines: context.knobs.int.slider(
        label: 'Max Lines',
        initialValue: 1,
        min: 1,
        max: 5,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Multi-line', type: TauInput)
Widget tauInputMultiline(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauInput(
      placeholder: 'Enter multi-line text...',
      maxLines: 5,
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Textarea', type: TauInput)
Widget tauInputTextarea(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauInput.textarea(
      placeholder: 'Enter tactical report...',
      minLines: context.knobs.int.slider(
        label: 'Min Lines',
        initialValue: 3,
        min: 1,
        max: 5,
      ),
      maxLines: context.knobs.int.slider(
        label: 'Max Lines',
        initialValue: 10,
        min: 5,
        max: 20,
      ),
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
    ),
  );
}
