# TAU NEUE Widgetbook

Interactive component documentation for the TAU NEUE design system.

## Overview

This Widgetbook provides a comprehensive showcase of all TAU NEUE components with interactive controls, allowing designers and developers to explore component variants, customize properties, and view components in isolation.

## Running Widgetbook

Navigate to the widgetbook directory and run:

```bash
cd widgetbook
flutter pub get
flutter run
```

For web:
```bash
flutter run -d chrome
```

For a specific device:
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Features

### Component Stories

- **Atoms**: TauButton, TauInput, TauBadge
- **Molecules**: TauCard, TauListTile, TauModal
- **Organisms**: TauAppBar, TauNavBar
- **Foundations**: TauScaffold, TauStatusDot, TauDivider, TauCornerBracket

### Interactive Controls (Knobs)

Each component story includes interactive knobs to customize:
- Text content and labels
- Dimensions (width, height, size)
- Boolean flags (enabled, show/hide elements)
- Variant selection
- Color customization

### Addons

- **Theme**: TAU NEUE Standard theme
- **Localization**: English (US)
- **Text Scale**: Accessibility testing (1.0x - 2.0x)
- **Alignment**: Debug alignment helpers

## Updating Stories

After adding or modifying stories, regenerate the catalog:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Adding New Stories

1. Create a new story file in `lib/stories/{category}/`
   - `atoms/` for atomic components
   - `molecules/` for complex components
   - `organisms/` for layout patterns
   - `foundations/` for base elements

2. Import necessary packages:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:tau_neue/tau_neue.dart';
   import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
   ```

3. Annotate use cases with `@widgetbook.UseCase`:
   ```dart
   @widgetbook.UseCase(name: 'Variant Name', type: ComponentType)
   Widget componentVariant(BuildContext context) {
     return ComponentType(
       // Use context.knobs for interactive controls
       label: context.knobs.string(
         label: 'Label',
         initialValue: 'DEFAULT',
       ),
     );
   }
   ```

4. Run build_runner to update catalog:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Available Knobs

### String
```dart
context.knobs.string(
  label: 'Label',
  initialValue: 'Default Text',
)
```

### Boolean
```dart
context.knobs.boolean(
  label: 'Enabled',
  initialValue: true,
)
```

### Number (Slider)
```dart
context.knobs.double.slider(
  label: 'Size',
  initialValue: 32.0,
  min: 16.0,
  max: 64.0,
)

context.knobs.int.slider(
  label: 'Count',
  initialValue: 1,
  min: 1,
  max: 10,
)
```

## Directory Structure

```
widgetbook/
├── lib/
│   ├── main.dart                    # Widgetbook app entry point
│   ├── main.directories.g.dart      # Generated catalog
│   └── stories/
│       ├── atoms/                   # Atomic components
│       │   ├── tau_button.dart
│       │   ├── tau_input.dart
│       │   └── tau_badge.dart
│       ├── molecules/               # Complex components
│       │   ├── tau_card.dart
│       │   ├── tau_list_tile.dart
│       │   └── tau_modal.dart
│       ├── organisms/               # Layout patterns
│       │   ├── tau_app_bar.dart
│       │   └── tau_nav_bar.dart
│       └── foundations/             # Base elements
│           ├── tau_decorators.dart
│           └── tau_scaffold.dart
├── pubspec.yaml
└── README.md
```

## Hot Reload

Widgetbook supports Flutter's hot reload. After making changes to story files, press `r` in the terminal or save the file to see changes immediately.

## Troubleshooting

### Build Runner Errors

If you encounter build_runner errors, try:

```bash
# Clean generated files
flutter clean
flutter pub get

# Delete .dart_tool
rm -rf .dart_tool

# Rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

### Component Not Showing

1. Ensure the story file is in the correct directory under `lib/stories/`
2. Verify the `@widgetbook.UseCase` annotation is present
3. Run build_runner to regenerate the catalog
4. Check for compilation errors with `flutter analyze`

### Theme Not Applied

The TAU NEUE theme is automatically applied via the MaterialThemeAddon. Ensure components use:
- `TauTheme.colorsOf(context)` for colors
- `TauTheme.typographyOf(context)` for typography
- `TauTheme.spacingOf(context)` for spacing

## Contributing

When adding new components to TAU NEUE:

1. Create the component in the main `tau_neue` package
2. Add comprehensive stories in this Widgetbook
3. Include all variants and key customization options
4. Test interactive controls work correctly
5. Verify hot reload functionality
6. Update this README if adding new categories

## Resources

- [Widgetbook Documentation](https://docs.widgetbook.io/)
- [TAU NEUE Design System](../README.md)
- [Flutter Documentation](https://docs.flutter.dev/)
