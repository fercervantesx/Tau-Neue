import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TauModal)
Widget tauModalDefault(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);
  final spacing = TauTheme.spacingOf(context);

  return Center(
    child: TauButton(
      label: 'SHOW MODAL',
      variant: TauButtonVariant.primary,
      onPressed: () {
        TauModal.show(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'COMMAND INTERFACE',
                  style: typography.headingSerif.copyWith(
                    color: colors.accentPrimary,
                  ),
                ),
                SizedBox(height: spacing.spacingBase * 2),
                Text(
                  'This is a tactical-style modal with mechanical snap transition.',
                  style: typography.bodyMono.copyWith(
                    color: colors.textOnDark,
                  ),
                ),
                SizedBox(height: spacing.spacingBase * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TauButton(
                      label: 'CANCEL',
                      variant: TauButtonVariant.ghost,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: spacing.spacingBase),
                    TauButton(
                      label: 'CONFIRM',
                      variant: TauButtonVariant.primary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ),
  );
}
