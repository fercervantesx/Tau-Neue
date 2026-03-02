import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'With Progress', type: TauPill)
Widget tauPillWithProgress(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: TauPill(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'RANK 2 - 170/300 REP',
      ),
      backgroundColor: colors.accentPrimary,
      textColor: colors.textOnAccent,
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 48.0,
        min: 32.0,
        max: 64.0,
      ),
      progress: context.knobs.double.slider(
        label: 'Progress',
        initialValue: 0.57,
        min: 0.0,
        max: 1.0,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Group With Progress', type: TauPillGroup)
Widget tauPillGroupWithProgress(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: TauPillGroup(
      height: 40.0,
      gap: context.knobs.double.slider(
        label: 'Gap',
        initialValue: 0.0,
        min: 0.0,
        max: 16.0,
      ),
      segments: [
        TauPillSegment(
          label: 'HEALTH',
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
          progress: context.knobs.double.slider(
            label: 'Health Progress',
            initialValue: 0.75,
            min: 0.0,
            max: 1.0,
          ),
        ),
        TauPillSegment(
          label: 'SHIELD',
          backgroundColor: Color(0xFF00BFFF),
          textColor: colors.textOnAccent,
          progress: context.knobs.double.slider(
            label: 'Shield Progress',
            initialValue: 0.30,
            min: 0.0,
            max: 1.0,
          ),
        ),
        TauPillSegment(
          label: 'AMMO',
          backgroundColor: colors.accentSecondary,
          textColor: colors.textOnDark,
          progress: context.knobs.double.slider(
            label: 'Ammo Progress',
            initialValue: 0.90,
            min: 0.0,
            max: 1.0,
          ),
        ),
      ],
    ),
  );
}
