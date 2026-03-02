import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TauListTile)
Widget tauListTileDefault(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);

  return TauListTile(
    leading: context.knobs.boolean(
      label: 'Show Leading',
      initialValue: true,
    )
        ? TauBadge(
            label: 'A1',
            backgroundColor: colors.accentPrimary,
            textColor: colors.textOnAccent,
          )
        : null,
    title: Text(
      context.knobs.string(
        label: 'Title',
        initialValue: 'REACTOR STATUS: OPTIMAL',
      ),
      style: typography.bodyMono.copyWith(
        color: colors.textOnDark,
      ),
    ),
    trailing: context.knobs.boolean(
      label: 'Show Trailing',
      initialValue: true,
    )
        ? Text(
            '98%',
            style: typography.dataMono.copyWith(
              color: colors.accentPrimary,
            ),
          )
        : null,
    showBorder: context.knobs.boolean(
      label: 'Show Border',
      initialValue: true,
    ),
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'List View', type: TauListTile)
Widget tauListTileListView(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);

  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return TauListTile(
        leading: TauBadge(
          label: 'A${index + 1}',
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
        ),
        title: Text(
          'SYSTEM LOG ENTRY ${index + 1}',
          style: typography.bodyMono.copyWith(
            color: colors.textOnDark,
          ),
        ),
        trailing: Text(
          '${90 + index}%',
          style: typography.dataMono.copyWith(
            color: colors.accentPrimary,
          ),
        ),
        showBorder: true,
        onTap: () {},
      );
    },
  );
}
