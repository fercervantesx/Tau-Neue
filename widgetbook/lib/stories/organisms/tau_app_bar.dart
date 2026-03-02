import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TauAppBar)
Widget tauAppBarDefault(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final showTicker = context.knobs.boolean(
    label: 'Show Ticker',
    initialValue: true,
  );
  final showActions = context.knobs.boolean(
    label: 'Show Actions',
    initialValue: true,
  );

  return TauScaffold(
    appBar: TauAppBar(
      title: Text(
        context.knobs.string(
          label: 'Title',
          initialValue: 'TACTICAL TERMINAL',
        ),
      ),
      tickerText: showTicker
          ? context.knobs.string(
              label: 'Ticker Text',
              initialValue: 'SECTOR-07 | SYSTEM ONLINE | TERMINAL ACTIVE',
            )
          : null,
      actions: showActions
          ? [
              TauBadge(
                label: 'v1.0',
                backgroundColor: colors.accentPrimary,
                textColor: colors.textOnAccent,
              ),
              const SizedBox(width: 8),
            ]
          : null,
    ),
    body: const Center(
      child: Text('App Bar Preview'),
    ),
  );
}
