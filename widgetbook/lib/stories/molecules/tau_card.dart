import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Elevated', type: TauCard)
Widget tauCardElevated(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauCard(
      variant: TauCardVariant.elevated,
      showCornerBrackets: context.knobs.boolean(
        label: 'Show Corner Brackets',
        initialValue: false,
      ),
      cornerBracketSize: context.knobs.double.slider(
        label: 'Bracket Size',
        initialValue: 12.0,
        min: 6.0,
        max: 24.0,
      ),
      header: Text(
        'SYSTEM STATUS',
        style: typography.headingSerif.copyWith(
          color: colors.accentPrimary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This is an elevated card variant with a black background and subtle border.',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          SizedBox(height: spacing.spacingBase),
          Row(
            children: [
              TauStatusDot(color: colors.accentPrimary, size: 6.0),
              SizedBox(width: spacing.spacingMicro),
              Text(
                'ONLINE',
                style: typography.dataMono.copyWith(
                  color: colors.accentPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Highlight', type: TauCard)
Widget tauCardHighlight(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TauCard(
      variant: TauCardVariant.highlight,
      showCornerBrackets: context.knobs.boolean(
        label: 'Show Corner Brackets',
        initialValue: false,
      ),
      header: const Text('RANK 1 REWARDS'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• Complete CyberAcme contracts',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          SizedBox(height: spacing.spacingMicro),
          Text(
            '• Run successful exfils',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          SizedBox(height: spacing.spacingMicro),
          Text(
            '• Activate TADs',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Color Variants', type: TauCard)
Widget tauCardColorVariants(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        TauCard(
          variant: TauCardVariant.highlight,
          headerColor: TauCardSectionColor.success,
          bodyColor: TauCardSectionColor.defaultColor,
          header: const Text('SUCCESS'),
          body: Text(
            'Green header with default body',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ),
        SizedBox(height: spacing.spacingBase * 2),
        TauCard(
          variant: TauCardVariant.highlight,
          headerColor: TauCardSectionColor.error,
          bodyColor: TauCardSectionColor.defaultColor,
          header: const Text('ERROR'),
          body: Text(
            'Red header with default body',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ),
        SizedBox(height: spacing.spacingBase * 2),
        TauCard(
          variant: TauCardVariant.elevated,
          bodyColor: TauCardSectionColor.disabled,
          header: const Text('DISABLED'),
          body: Text(
            'Grey disabled card',
            style: typography.bodyMono.copyWith(
              color: colors.textMuted,
            ),
          ),
        ),
      ],
    ),
  );
}
