# Changelog

## [0.1.0] - 2024

### Initial Release

#### Foundations
- Design token system (colors, spacing, typography, motion)
- Theme factory with ThemeExtension architecture
- Custom geometry engine for 45-degree chamfered cuts
- TauContainer with optimized ClipPath + CustomPainter approach
- TauScaffold with consistent theming
- GlitchProvider for global visual effects

#### Atoms
- TauButton with instant feedback (50ms snap)
- TauInput with technical corner reticles and block cursor
- TauBadge with predefined types (barcode, coordinate, version)
- TauDecal for larger decorative elements

#### Molecules
- TauCard with slot-based layout (header, body, footer)
- TauListTile optimized for ListView with RepaintBoundary
- TauModal with mechanical snap transitions and backdrop blur

#### Organisms
- TauAppBar with oversized header (120px) and ticker tape
- TauNavBar with geometric reticle active states

#### Design System
- Two predefined themes: Sector Yellow and Void Black
- 8-pixel grid system with 4px sub-grid
- Swiss International Typography hierarchy
- Mechanical motion language (0-200ms window)

#### Performance
- RepaintBoundary isolation for high-frequency updates
- Const constructors throughout
- CustomPainter for decorative borders
- ClipPath only for child containment
- 120fps target achieved

#### Infrastructure
- Comprehensive unit tests
- Widget tests for all components
- Example app demonstrating all components
- GLSL fragment shader for chromatic aberration (prepared for future use)
