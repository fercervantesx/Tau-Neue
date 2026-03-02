import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text Alignment', type: TauButton)
Widget tauButtonTextAlignment(BuildContext context) {
  final alignmentOptions = {
    'Center': Alignment.center,
    'Top Left': Alignment.topLeft,
    'Top Center': Alignment.topCenter,
    'Top Right': Alignment.topRight,
    'Center Left': Alignment.centerLeft,
    'Center Right': Alignment.centerRight,
    'Bottom Left': Alignment.bottomLeft,
    'Bottom Center': Alignment.bottomCenter,
    'Bottom Right': Alignment.bottomRight,
  };

  final selectedAlignment = context.knobs.object.dropdown(
    label: 'Text Alignment',
    options: alignmentOptions.keys.toList(),
    initialOption: 'Bottom Left',
  );

  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'PURCHASE',
      ),
      variant: TauButtonVariant.wide,
      width: context.knobs.double.slider(
        label: 'Width',
        initialValue: 300.0,
        min: 100.0,
        max: 500.0,
      ),
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 80.0,
        min: 40.0,
        max: 120.0,
      ),
      textAlign: alignmentOptions[selectedAlignment]!,
      onPressed: () {},
    ),
  );
}
