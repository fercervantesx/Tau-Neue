import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Basic Scaffold', type: TauScaffold)
Widget tauScaffoldBasic(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);

  return TauScaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TAU NEUE',
            style: typography.headingSerif.copyWith(
              color: colors.accentPrimary,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'GRAPHIC REALISM DESIGN SYSTEM',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Full Layout', type: TauScaffold)
Widget tauScaffoldFullLayout(BuildContext context) {
  final colors = TauTheme.colorsOf(context);
  final typography = TauTheme.typographyOf(context);

  return TauScaffold(
    appBar: TauAppBar(
      title: const Text('TACTICAL TERMINAL'),
      tickerText: 'SECTOR-07 | SYSTEM ONLINE | TERMINAL ACTIVE',
      actions: [
        TauBadge(
          label: 'v1.0',
          backgroundColor: colors.accentPrimary,
          textColor: colors.textOnAccent,
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TauCard(
          variant: TauCardVariant.elevated,
          header: Text(
            'MISSION BRIEFING',
            style: typography.headingSerif.copyWith(
              color: colors.accentPrimary,
            ),
          ),
          body: Text(
            'Complete all tactical objectives within the designated time frame.',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TauListTile(
          leading: TauBadge(
            label: 'A1',
            backgroundColor: colors.accentPrimary,
            textColor: colors.textOnAccent,
          ),
          title: Text(
            'PRIMARY OBJECTIVE',
            style: typography.bodyMono.copyWith(
              color: colors.textOnDark,
            ),
          ),
          trailing: Text(
            '100%',
            style: typography.dataMono.copyWith(
              color: colors.accentPrimary,
            ),
          ),
          showBorder: true,
          onTap: () {},
        ),
      ],
    ),
    bottomNavigationBar: TauNavBar(
      currentIndex: 0,
      onTap: (index) {},
      items: const [
        TauNavBarItem(icon: Icon(Icons.terminal), label: 'COMMAND'),
        TauNavBarItem(icon: Icon(Icons.assessment), label: 'STATUS'),
        TauNavBarItem(icon: Icon(Icons.settings), label: 'CONFIG'),
      ],
    ),
  );
}
