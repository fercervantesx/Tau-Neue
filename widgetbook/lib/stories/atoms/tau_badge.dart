import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Count Badge', type: TauBadge)
Widget tauBadgeCount(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);

  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'NOTES',
          style: typography.labelMono.copyWith(
            color: colors.textOnDark,
          ),
        ),
        const SizedBox(width: 4),
        TauBadge(
          label: context.knobs.string(
            label: 'Label',
            initialValue: '3',
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Status Badge', type: TauBadge)
Widget tauBadgeStatus(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TauBadge(
          label: 'NEW',
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
        ),
        const SizedBox(height: 8),
        TauBadge(
          label: 'BETA',
          backgroundColor: colors.accentSecondary,
          textColor: colors.textOnDark,
        ),
        const SizedBox(height: 8),
        TauBadge(
          label: 'ERROR',
          backgroundColor: colors.accentCritical,
          textColor: colors.textOnAccent,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Colors', type: TauBadge)
Widget tauBadgeCustom(BuildContext context) {
  final colors = TauTheme.colorsOf(context);

  return Center(
    child: TauBadge(
      label: context.knobs.string(
        label: 'Label',
        initialValue: '99+',
      ),
      backgroundColor: colors.accentPrimary,
      borderRadius: context.knobs.double.slider(
        label: 'Border Radius',
        initialValue: 4.0,
        min: 0.0,
        max: 12.0,
      ),
    ),
  );
}
