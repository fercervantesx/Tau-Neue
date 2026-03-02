import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the generated widgetbook
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use auto-generated directories
      directories: directories,

      // Add-ons for enhanced functionality
      addons: [
        // Theme addon for TAU NEUE theme
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'TAU NEUE Standard',
              data: TauTheme.buildTheme(
                colorTokens: TauColorTokens.standard,
              ),
            ),
          ],
        ),

        // Locale addon
        LocalizationAddon(
          locales: [
            const Locale('en', 'US'),
          ],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        ),

        // Text scale addon
        TextScaleAddon(
          min: 1.0,
          max: 2.0,
          initialScale: 1.0,
        ),

        // Accessibility addon
        AlignmentAddon(),
      ],
    );
  }
}
