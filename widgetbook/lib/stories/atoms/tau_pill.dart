import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Single Pill', type: TauPill)
Widget tauPillSingle(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  return Center(
    child: TauPill(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'O2',
      ),
      icon: showIcon ? const Icon(Icons.circle) : null,
      backgroundColor: colors.accentPrimary,
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 32.0,
        min: 24.0,
        max: 48.0,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Pill Group', type: TauPillGroup)
Widget tauPillGroupExample(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: TauPillGroup(
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 32.0,
        min: 24.0,
        max: 48.0,
      ),
      gap: context.knobs.double.slider(
        label: 'Gap',
        initialValue: 0.0,
        min: 0.0,
        max: 16.0,
      ),
      segments: [
        TauPillSegment(
          label: 'O2',
          icon: const Icon(Icons.circle),
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
        ),
        TauPillSegment(
          label: 'I',
          backgroundColor: colors.accentSecondary,
          textColor: colors.textOnDark,
        ),
        TauPillSegment(
          label: '#10/140',
          backgroundColor: colors.surfaceHighlight,
          textColor: colors.textOnDark,
        ),
        TauPillSegment(
          label: '\$3,950',
          backgroundColor: colors.surfaceElevated,
          textColor: colors.textOnDark,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Colors', type: TauPill)
Widget tauPillCustomColors(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TauPill(
          label: 'SUCCESS',
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
          height: 32.0,
        ),
        const SizedBox(height: 8),
        TauPill(
          label: 'ERROR',
          backgroundColor: colors.accentCritical,
          textColor: colors.textOnDark,
          height: 32.0,
        ),
        const SizedBox(height: 8),
        TauPill(
          label: 'DISABLED',
          backgroundColor: colors.surfaceElevated,
          textColor: colors.textMuted,
          height: 32.0,
        ),
      ],
    ),
  );
}
