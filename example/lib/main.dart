import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';

void main() {
  runApp(const TauNeueExampleApp());
}

class TauNeueExampleApp extends StatelessWidget {
  const TauNeueExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAU NEUE Example',
      theme: TauTheme.buildTheme(
        colorTokens: TauColorTokens.standard,
        typographyTokens: TauTypographyTokens.standard,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _currentIndex = 0;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showModal(BuildContext context) {
    TauModal.show(
      context: context,
      builder: (context) {
        final colors = TauTheme.colorsOf(context);
        final spacing = TauTheme.spacingOf(context);
        final typography = TauTheme.typographyOf(context);

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
              'This is a tactical-style modal with clean rounded geometry and monospace typography.',
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
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
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
          SizedBox(width: spacing.spacingBase),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.spacingBase * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Title with Serif Typography
            Center(
              child: Text(
                'ONI',
                style: typography.titleSerif.copyWith(
                  color: colors.accentPrimary,
                  fontSize: 48.0,
                ),
              ),
            ),
            SizedBox(height: spacing.spacingBase),
            Center(
              child: Text(
                'Office of Naval Intelligence',
                style: typography.bodyMono.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ),
            SizedBox(height: spacing.spacingMacro),

            // Button Variants Showcase
            Text(
              'BUTTON VARIANTS',
              style: typography.headingSerif.copyWith(
                color: colors.textOnDark,
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),
            Wrap(
              spacing: spacing.spacingBase,
              runSpacing: spacing.spacingBase,
              children: [
                TauButton(
                  label: 'PRIMARY',
                  variant: TauButtonVariant.primary,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'SECONDARY',
                  variant: TauButtonVariant.secondary,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'GHOST',
                  variant: TauButtonVariant.ghost,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'PURCHASE',
                  variant: TauButtonVariant.wide,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'DISABLED',
                  variant: TauButtonVariant.secondary,
                  enabled: false,
                  onPressed: null,
                ),
              ],
            ),
            SizedBox(height: spacing.spacingBase * 2),

            // Button Icon Variants
            Text(
              'BUTTONS WITH ICONS',
              style: typography.labelMono.copyWith(
                color: colors.textMuted,
              ),
            ),
            SizedBox(height: spacing.spacingBase),
            Wrap(
              spacing: spacing.spacingBase,
              runSpacing: spacing.spacingBase,
              children: [
                TauButton(
                  label: 'UPGRADES',
                  variant: TauButtonVariant.secondary,
                  iconRight: const Icon(Icons.arrow_upward, size: 16),
                  iconRightBackground: colors.accentPrimary,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'CONTRACTS',
                  variant: TauButtonVariant.primary,
                  iconLeft: const Icon(Icons.assignment, size: 16),
                  iconLeftBackground: colors.accentSecondary,
                  onPressed: () {},
                ),
                TauButton(
                  label: 'EXTRACT',
                  variant: TauButtonVariant.ghost,
                  iconLeft: const Icon(Icons.download, size: 16),
                  iconRight: const Icon(Icons.check, size: 16),
                  iconRightBackground: colors.accentPrimary,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spacing.spacingMacro),

            // Card Variants Showcase
            Text(
              'CARD VARIANTS',
              style: typography.headingSerif.copyWith(
                color: colors.textOnDark,
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),

            // Highlight Variant Card
            TauCard(
              variant: TauCardVariant.highlight,
              header: const Text('RANK 1 REWARDS'),
              body: Padding(
                padding: EdgeInsets.all(spacing.spacingBase),
                child: Column(
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
            ),
            SizedBox(height: spacing.spacingBase * 2),

            // Elevated Variant Card
            TauCard(
              variant: TauCardVariant.elevated,
              header: Text(
                'SYSTEM STATUS',
                style: typography.headingSerif.copyWith(
                  color: colors.accentPrimary,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TauListTile(
                    leading: TauBadge(
                      label: 'A1',
                      backgroundColor: colors.accentPrimary,
                      textColor: colors.textOnAccent,
                    ),
                    title: Text(
                      'REACTOR STATUS: OPTIMAL',
                      style: typography.bodyMono.copyWith(
                        color: colors.textOnDark,
                      ),
                    ),
                    trailing: Text(
                      '98%',
                      style: typography.dataMono.copyWith(
                        color: colors.accentPrimary,
                      ),
                    ),
                    showBorder: true,
                  ),
                  TauListTile(
                    leading: TauBadge(
                      label: 'B2',
                      backgroundColor: colors.accentPrimary,
                      textColor: colors.textOnAccent,
                    ),
                    title: Text(
                      'THERMAL REGULATION: ACTIVE',
                      style: typography.bodyMono.copyWith(
                        color: colors.textOnDark,
                      ),
                    ),
                    trailing: Text(
                      '12°C',
                      style: typography.dataMono.copyWith(
                        color: colors.accentPrimary,
                      ),
                    ),
                    showBorder: true,
                  ),
                  TauListTile(
                    leading: TauBadge(
                      label: 'C3',
                      backgroundColor: colors.accentPrimary,
                      textColor: colors.textOnAccent,
                    ),
                    title: Text(
                      'HULL INTEGRITY: NOMINAL',
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
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),

            // Card with Corner Brackets
            Text(
              'CARD WITH CORNER BRACKETS',
              style: typography.labelMono.copyWith(
                color: colors.textMuted,
              ),
            ),
            SizedBox(height: spacing.spacingBase),
            TauCard(
              variant: TauCardVariant.elevated,
              showCornerBrackets: true,
              cornerBracketColor: colors.accentPrimary,
              cornerBracketSize: 12.0,
              header: Text(
                'SECURE CHANNEL',
                style: typography.headingSerif.copyWith(
                  color: colors.accentPrimary,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enhanced security with decorative corner brackets.',
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
            SizedBox(height: spacing.spacingMacro),

            // Decorators & Badges Showcase
            Text(
              'DECORATORS & BADGES',
              style: typography.headingSerif.copyWith(
                color: colors.textOnDark,
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),
            TauContainer(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              backgroundColor: colors.surfaceElevated,
              borderColor: colors.borderSubtle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Dots',
                    style: typography.labelMono.copyWith(
                      color: colors.textOnDark,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Row(
                    children: [
                      TauStatusDot(color: colors.accentPrimary, size: 8.0),
                      SizedBox(width: spacing.spacingBase),
                      TauStatusDot(color: colors.accentSecondary, size: 8.0),
                      SizedBox(width: spacing.spacingBase),
                      TauStatusDot(color: colors.accentCritical, size: 8.0),
                    ],
                  ),
                  SizedBox(height: spacing.spacingBase * 2),
                  TauDivider(
                    color: colors.borderSubtle,
                    thickness: 1.0,
                  ),
                  SizedBox(height: spacing.spacingBase * 2),
                  Text(
                    'Dividers',
                    style: typography.labelMono.copyWith(
                      color: colors.textOnDark,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  TauDivider(
                    color: colors.accentPrimary,
                    thickness: 2.0,
                  ),
                  SizedBox(height: spacing.spacingBase),
                  TauDivider(
                    color: colors.borderSubtle,
                    thickness: 1.0,
                    indent: spacing.spacingBase * 2,
                    endIndent: spacing.spacingBase * 2,
                  ),
                  SizedBox(height: spacing.spacingBase * 2),
                  TauDivider(
                    color: colors.borderSubtle,
                    thickness: 1.0,
                  ),
                  SizedBox(height: spacing.spacingBase * 2),
                  Text(
                    'Badges',
                    style: typography.labelMono.copyWith(
                      color: colors.textOnDark,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Row(
                    children: [
                      TauBadge(
                        label: '|||||||',
                        backgroundColor: colors.accentPrimary,
                        textColor: colors.textOnAccent,
                      ),
                      SizedBox(width: spacing.spacingBase * 2),
                      TauBadge(
                        label: 'X7',
                        backgroundColor: colors.accentPrimary,
                        textColor: colors.textOnAccent,
                      ),
                      SizedBox(width: spacing.spacingBase * 2),
                      TauBadge(
                        label: 'v2.1',
                        backgroundColor: colors.accentPrimary,
                        textColor: colors.textOnAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.spacingMacro),

            // Input Field Example
            Text(
              'INPUT FIELD',
              style: typography.headingSerif.copyWith(
                color: colors.textOnDark,
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),
            TauInput(
              controller: _textController,
              placeholder: 'Enter authorization code...',
            ),
            SizedBox(height: spacing.spacingMacro),

            // Typography Showcase
            Text(
              'TYPOGRAPHY SYSTEM',
              style: typography.headingSerif.copyWith(
                color: colors.textOnDark,
              ),
            ),
            SizedBox(height: spacing.spacingBase * 2),
            TauContainer(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              backgroundColor: colors.surfaceElevated,
              borderColor: colors.borderSubtle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title Serif (Classical)',
                    style: typography.titleSerif.copyWith(
                      color: colors.accentPrimary,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Text(
                    'Heading Serif (Elegant)',
                    style: typography.headingSerif.copyWith(
                      color: colors.textOnDark,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Text(
                    'Body Mono (Readable terminal text)',
                    style: typography.bodyMono.copyWith(
                      color: colors.textOnDark,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Text(
                    'Data Mono (0xDEADBEEF | 47.6062°N)',
                    style: typography.dataMono.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Text(
                    'LABEL MONO (COMPACT)',
                    style: typography.labelMono.copyWith(
                      color: colors.accentPrimary,
                    ),
                  ),
                  SizedBox(height: spacing.spacingBase),
                  Text(
                    'BUTTON WIDE',
                    style: typography.buttonWide.copyWith(
                      color: colors.textOnDark,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing.spacingMacro),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TauButton(
                  label: 'INITIALIZE',
                  variant: TauButtonVariant.primary,
                  onPressed: () => _showModal(context),
                ),
                SizedBox(width: spacing.spacingBase),
                TauButton(
                  label: 'DIAGNOSTICS',
                  variant: TauButtonVariant.secondary,
                  onPressed: () => _showModal(context),
                ),
              ],
            ),
            SizedBox(height: spacing.spacingMacro),
          ],
        ),
      ),
      bottomNavigationBar: TauNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          TauNavBarItem(icon: Icon(Icons.terminal), label: 'COMMAND'),
          TauNavBarItem(icon: Icon(Icons.assessment), label: 'STATUS'),
          TauNavBarItem(icon: Icon(Icons.settings), label: 'CONFIG'),
        ],
      ),
    );
  }
}
