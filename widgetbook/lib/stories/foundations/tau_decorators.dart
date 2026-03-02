import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Status Dot', type: TauStatusDot)
Widget tauStatusDotStory(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  return Center(
    child: TauStatusDot(
      color: colors.accentPrimary,
      size: context.knobs.double.slider(
        label: 'Size',
        initialValue: 8.0,
        min: 4.0,
        max: 16.0,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Divider', type: TauDivider)
Widget tauDividerStory(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauDivider(
      color: colors.accentPrimary,
      thickness: context.knobs.double.slider(
        label: 'Thickness',
        initialValue: 2.0,
        min: 1.0,
        max: 4.0,
      ),
      indent: context.knobs.double.slider(
        label: 'Indent',
        initialValue: 0.0,
        min: 0.0,
        max: 32.0,
      ),
      endIndent: context.knobs.double.slider(
        label: 'End Indent',
        initialValue: 0.0,
        min: 0.0,
        max: 32.0,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Corner Brackets', type: TauCornerBracket)
Widget tauCornerBracketStory(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  return Center(
    child: SizedBox(
      width: 200,
      height: 150,
      child: Stack(
        children: [
          Positioned.fill(
            child: TauCornerBracket(
              color: colors.accentPrimary,
              size: context.knobs.double.slider(
                label: 'Size',
                initialValue: 12.0,
                min: 6.0,
                max: 24.0,
              ),
              strokeWidth: context.knobs.double.slider(
                label: 'Stroke Width',
                initialValue: 1.0,
                min: 1.0,
                max: 3.0,
              ),
            ),
          ),
          Center(
            child: Text(
              'CORNER\nBRACKETS',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textOnDark),
            ),
          ),
        ],
      ),
    ),
  );
}
