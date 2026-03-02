import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Highlight With Progress', type: TauCard)
Widget tauCardHighlightWithProgress(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauCard(
      variant: TauCardVariant.highlight,
      header: Text(
        context.knobs.string(
          label: 'Header Text',
          initialValue: 'RANK 2 - 170/300 REP',
        ),
      ),
      headerProgress: context.knobs.double.slider(
        label: 'Header Progress',
        initialValue: 0.57,
        min: 0.0,
        max: 1.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress shows reputation advancement toward next rank.',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          SizedBox(height: spacing.spacingBase),
          Text(
            '• Complete contracts: +50 REP',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          SizedBox(height: spacing.spacingMicro),
          Text(
            '• Successful exfils: +25 REP',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Multi-Section Progress', type: TauCard)
Widget tauCardMultiSectionProgress(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        TauCard(
          variant: TauCardVariant.highlight,
          header: const Text('SHIELD SYSTEMS'),
          headerColor: TauCardSectionColor.success,
          headerProgress: context.knobs.double.slider(
            label: 'Shield Progress',
            initialValue: 0.85,
            min: 0.0,
            max: 1.0,
          ),
          body: Text(
            'Shield recharge at 85%',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ),
        SizedBox(height: spacing.spacingBase),
        TauCard(
          variant: TauCardVariant.highlight,
          header: const Text('HEALTH STATUS'),
          headerColor: TauCardSectionColor.error,
          headerProgress: context.knobs.double.slider(
            label: 'Health Progress',
            initialValue: 0.32,
            min: 0.0,
            max: 1.0,
          ),
          body: Text(
            'Critical damage detected',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ),
        SizedBox(height: spacing.spacingBase),
        TauCard(
          variant: TauCardVariant.highlight,
          header: const Text('POWER CORE'),
          headerColor: TauCardSectionColor.disabled,
          headerProgress: context.knobs.double.slider(
            label: 'Power Progress',
            initialValue: 0.0,
            min: 0.0,
            max: 1.0,
          ),
          body: Text(
            'Offline - maintenance required',
            style: typography.bodyMono.copyWith(
              color: colors.textMuted,
            ),
          ),
        ),
      ],
    ),
  );
}
