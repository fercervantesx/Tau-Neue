# TAU NEUE

High-fidelity Flutter design system implementing "Graphic Realism" aesthetics with 45-degree chamfered cuts, Swiss International Typographic Style, and GPU-accelerated effects targeting 120fps performance.

## Features

- **Graphic Realism Visual Language**: Industrial sci-fi aesthetic inspired by Marathon 2026
- **Chamfered Geometry**: Signature 45-degree cuts using optimized CustomPainter + ClipPath approach
- **Performance-Optimized**: RepaintBoundary isolation, const constructors, 120fps target
- **Design Token System**: Type-safe ThemeExtension-based tokens for colors, spacing, typography, motion
- **8-Pixel Grid**: Consistent spacing with 4px sub-grid for dense layouts
- **Motion Language**: Mechanical snap animations (50-200ms) with no elastic physics
- **Atomic Design**: Complete component library from primitives to organisms
- **GPU Shaders**: Chromatic aberration effects via GLSL fragment shaders (optional)

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tau_neue:
    path: path/to/tau_neue
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TauTheme.buildTheme(
        colorTokens: TauColorTokens.sectorYellow,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    return TauScaffold(
      appBar: TauAppBar(
        title: const Text('TAU NEUE'),
        tickerText: 'SECTOR-07 | GRAPHIC REALISM',
      ),
      body: Center(
        child: TauContainer(
          width: 300,
          height: 150,
          cutSize: spacing.cutCornerLarge,
          backgroundColor: colors.surfaceHighlight,
          borderColor: colors.borderIndustrial,
          strokeWidth: spacing.strokeWeightBase,
          padding: EdgeInsets.all(spacing.spacingBase * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GRAPHIC REALISM',
                style: typography.displaySec.copyWith(
                  color: colors.accentSector,
                ),
              ),
              SizedBox(height: spacing.spacingBase),
              TauButton(
                label: 'AUTHENTICATE',
                onPressed: () {
                  // Your action here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Interactive Documentation

TAU NEUE includes a comprehensive Widgetbook for interactive component exploration and documentation.

### Running Widgetbook

```bash
cd widgetbook
flutter pub get
flutter run
```

For web:
```bash
flutter run -d chrome
```

### Features

The Widgetbook provides:
- **Live Component Preview**: All component variants with real-time rendering
- **Interactive Knobs**: Customize properties like text, dimensions, colors, and states
- **Theme Switching**: Preview components with different theme configurations
- **Accessibility Testing**: Test with different text scales and alignment helpers
- **Hot Reload Support**: Instant updates when modifying story files

### Available Stories

- **Atoms**: TauButton (5 variants), TauInput (2 variants), TauBadge (3 types)
- **Molecules**: TauCard (2 variants), TauListTile (2 examples), TauModal
- **Organisms**: TauAppBar, TauNavBar
- **Foundations**: TauScaffold (2 layouts), TauStatusDot, TauDivider, TauCornerBracket

See [widgetbook/README.md](widgetbook/README.md) for detailed documentation on creating and updating stories.

## Components

### Foundations

#### TauContainer
Optimized container with chamfered geometry. Replaces standard Flutter Container.

```dart
TauContainer(
  width: 200,
  height: 100,
  cutSize: 24,
  backgroundColor: colors.surfaceHighlight,
  borderColor: colors.borderIndustrial,
  showInsetLine: true,
  child: Text('Content'),
)
```

#### TauScaffold
Application-level container with consistent theming.

```dart
TauScaffold(
  appBar: TauAppBar(title: Text('Title')),
  body: Content(),
  bottomNavigationBar: TauNavBar(...),
)
```

### Atoms

#### TauButton
Heavy text-forward control with instant feedback (50ms).

```dart
TauButton(
  label: 'AUTHENTICATE',
  onPressed: () {},
  width: 200,
  height: 56,
)
```

#### TauInput
Rigid input field with technical corner reticles and block cursor.

```dart
TauInput(
  controller: controller,
  placeholder: 'ENTER CODE...',
  onChanged: (value) {},
)
```

#### TauBadge
Non-interactive diegetic elements (barcodes, coordinates, versions).

```dart
TauBadge.barcode(size: 24)
TauBadge.coordinate(coordinate: 'A1', size: 24)
TauBadge.version(version: 'v0.1.0', size: 32)
```

### Molecules

#### TauCard
Slot-based layout with header, body, and footer.

```dart
TauCard(
  header: Text('SYSTEM STATUS'),
  body: Column(children: [...]),
  footer: TauButton(...),
)
```

#### TauListTile
High-density row optimized for lists with RepaintBoundary.

```dart
TauListTile(
  leading: Icon(Icons.dashboard),
  title: Text('REACTOR STATUS'),
  trailing: Text('98%'),
  showBorder: true,
  onTap: () {},
)
```

#### TauModal
Mechanical snap modal with backdrop blur.

```dart
TauModal.show(
  context: context,
  builder: (context) => Column(children: [...]),
)
```

### Organisms

#### TauAppBar
Oversized header (120px) with optional ticker tape.

```dart
TauAppBar(
  title: Text('TAU NEUE'),
  tickerText: 'SECTOR-07 | GRAPHIC REALISM',
  actions: [Icon(Icons.settings)],
)
```

#### TauNavBar
Bottom navigation with geometric reticle active states.

```dart
TauNavBar(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    TauNavBarItem(icon: Icon(Icons.dashboard), label: 'COMMAND'),
    TauNavBarItem(icon: Icon(Icons.map), label: 'TACTICAL'),
  ],
)
```

## Design Tokens

### Colors

Two predefined themes:

- **Sector Yellow**: Bright yellow brand (#C2FE0B) with dark backgrounds
- **Void Black**: Cyan brand (#01FFFF) with pure black backgrounds

```dart
TauTheme.buildTheme(
  colorTokens: TauColorTokens.sectorYellow,
  // or: TauColorTokens.voidBlack
)
```

Token names:
- `surfaceBase`: Foundational background
- `surfaceHighlight`: Elevated layers
- `accentCritical`: Errors, destructive actions (red)
- `accentSector`: Brand color, active states
- `textDisplay`: Headers, structural anchors
- `textMonospace`: Log data, coordinates
- `borderIndustrial`: Hard separations

### Spacing

8-pixel grid system:

- `spacingMicro`: 4px (dense clustering)
- `spacingBase`: 8px (standard padding)
- `spacingMacro`: 32px (major divisions)
- `cutCornerSmall`: 8px (minor elements)
- `cutCornerLarge`: 24px (major components)
- `strokeWeightBase`: 2px (borders)

### Typography

Variable font tiers:

- `displayPrime`: Black (900) - Massive headers
- `displaySec`: Light Extended (300, 125%) - Sub-headers
- `dataMatrix`: Monospace Medium Condensed (500, 85%) - Technical data
- `bodyTactical`: Regular (400) - Standard content

### Motion

Mechanical timing:

- `snapInstant`: 50ms, linear - Hover, press
- `snapMechanical`: 150ms, easeOutExpo - Modals, routes
- `glitchFrequency`: 100ms - Error states

## Glitch Effects

Wrap your app in `GlitchProvider` and use `TauGlitchReceiver` for reactive effects:

```dart
GlitchProvider(
  child: TauScaffold(
    body: TauGlitchReceiver(
      child: YourContent(),
      builder: (context, intensity, child) {
        // Custom glitch effect based on intensity
        return Opacity(opacity: 1.0 - (intensity * 0.2), child: child);
      },
    ),
  ),
)

// Trigger glitch
TauButton(
  label: 'ACTION',
  onPressed: () {
    GlitchProvider.triggerGlitch(context, intensity: 2.0);
  },
)
```

## Performance

TAU NEUE targets 120fps (8.33ms frame budget) through:

1. **CustomPainter for Borders**: Avoids expensive saveLayer() operations
2. **RepaintBoundary Isolation**: High-frequency updates don't cascade
3. **Const Constructors**: Widget tree pruning
4. **ClipPath Only for Containment**: Child overflow prevention only
5. **AOT-Compiled Shaders**: No runtime compilation jank

## Development

```bash
# Run example app
cd example
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .
```

## Credits

Visual philosophy inspired by:
- Marathon (2026) - Industrial sci-fi aesthetic
- Swiss International Typographic Style - Typography hierarchy
- Alien (1979) - Diegetic industrial UI

## License

MIT License
