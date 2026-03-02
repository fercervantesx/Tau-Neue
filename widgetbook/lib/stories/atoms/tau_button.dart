import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Primary', type: TauButton)
Widget tauButtonPrimary(BuildContext context) {
  final useCustomWidth = context.knobs.boolean(
    label: 'Use Custom Width',
    initialValue: false,
  );

  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'PRIMARY',
      ),
      variant: TauButtonVariant.primary,
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      width: useCustomWidth
          ? context.knobs.double.slider(
              label: 'Width',
              initialValue: 200.0,
              min: 100.0,
              max: 400.0,
            )
          : null,
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 40.0,
        min: 32.0,
        max: 64.0,
      ),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Secondary', type: TauButton)
Widget tauButtonSecondary(BuildContext context) {
  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'SECONDARY',
      ),
      variant: TauButtonVariant.secondary,
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Ghost', type: TauButton)
Widget tauButtonGhost(BuildContext context) {
  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'GHOST',
      ),
      variant: TauButtonVariant.ghost,
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Wide', type: TauButton)
Widget tauButtonWide(BuildContext context) {
  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'PURCHASE',
      ),
      variant: TauButtonVariant.wide,
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'With Icons', type: TauButton)
Widget tauButtonWithIcons(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final showLeftIcon = context.knobs.boolean(
    label: 'Show Left Icon',
    initialValue: false,
  );
  final showRightIcon = context.knobs.boolean(
    label: 'Show Right Icon',
    initialValue: true,
  );

  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'UPGRADES',
      ),
      variant: TauButtonVariant.secondary,
      iconLeft: showLeftIcon ? const Icon(Icons.assignment, size: 16) : null,
      iconLeftBackground: showLeftIcon ? colors.accentSecondary : null,
      iconRight: showRightIcon ? const Icon(Icons.arrow_upward, size: 16) : null,
      iconRightBackground: showRightIcon ? colors.accentPrimary : null,
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Pill', type: TauButton)
Widget tauButtonPill(BuildContext context) {
  return Center(
    child: TauButton(
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'PILL BUTTON',
      ),
      variant: TauButtonVariant.primary,
      isPill: context.knobs.boolean(
        label: 'Is Pill',
        initialValue: true,
      ),
      enabled: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ),
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 40.0,
        min: 32.0,
        max: 64.0,
      ),
      onPressed: () {},
    ),
  );
}
