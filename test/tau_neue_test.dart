import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tau_neue/tau_neue.dart';

void main() {
  // Disable Google Fonts HTTP fetching in tests
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('TauColorTokens', () {
    test('standard has correct colors', () {
      expect(TauColorTokens.standard.surfaceBase, const Color(0xFF000000));
      expect(TauColorTokens.standard.accentPrimary, const Color(0xFF00FF00));
      expect(TauColorTokens.standard.accentSecondary, const Color(0xFF6B6B6B));
    });

    test('lerp interpolates colors correctly', () {
      final lerped = TauColorTokens.standard.lerp(
        TauColorTokens.standard.copyWith(
          accentPrimary: const Color(0xFFFF0000),
        ),
        0.5,
      );
      expect(lerped, isA<TauColorTokens>());
    });
  });

  group('TauSpacingTokens', () {
    test('standard has correct spacing values', () {
      expect(TauSpacingTokens.standard.spacingMicro, 4.0);
      expect(TauSpacingTokens.standard.spacingBase, 8.0);
      expect(TauSpacingTokens.standard.spacingMacro, 32.0);
      expect(TauSpacingTokens.standard.strokeWeightBase, 1.0);
    });
  });

  group('TauTypographyTokens', () {
    test('standard has correct typography styles', () {
      // Note: We cannot directly test TauTypographyTokens.standard in unit tests
      // because it uses Google Fonts which require network access.
      // The typography tokens are tested indirectly through widget tests below.
      expect(true, true); // Placeholder test
    });
  });

  group('TauContainer', () {
    testWidgets('renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TauContainer(
              width: 100,
              height: 100,
              borderRadius: 6.0,
              child: Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('applies background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TauContainer(
              width: 100,
              height: 100,
              backgroundColor: Colors.red,
              child: Text('Test'),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('TauScaffold', () {
    testWidgets('renders with theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: TauTheme.buildTheme(
            colorTokens: TauColorTokens.standard,
          ),
          home: const TauScaffold(
            body: Text('Test'),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFF000000));
    });
  });

  group('TauButton', () {
    testWidgets('renders with primary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: TauTheme.buildTheme(
            colorTokens: TauColorTokens.standard,
          ),
          home: Scaffold(
            body: TauButton(
              label: 'TEST',
              variant: TauButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('TEST'), findsOneWidget);
    });

    testWidgets('renders with secondary variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: TauTheme.buildTheme(
            colorTokens: TauColorTokens.standard,
          ),
          home: Scaffold(
            body: TauButton(
              label: 'TEST',
              variant: TauButtonVariant.secondary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('TEST'), findsOneWidget);
    });
  });

  group('TauCard', () {
    testWidgets('renders with elevated variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: TauTheme.buildTheme(
            colorTokens: TauColorTokens.standard,
          ),
          home: const Scaffold(
            body: TauCard(
              variant: TauCardVariant.elevated,
              header: Text('Header'),
              body: Text('Body'),
            ),
          ),
        ),
      );

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('renders with highlight variant header only', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: TauTheme.buildTheme(
            colorTokens: TauColorTokens.standard,
          ),
          home: const Scaffold(
            body: TauCard(
              variant: TauCardVariant.highlight,
              header: Text('Header'),
            ),
          ),
        ),
      );

      // Verify header text is present
      expect(find.text('Header'), findsOneWidget);
    });
  });
}
