import 'package:flutter/widgets.dart';
import '../foundations/tau_container.dart';
import '../foundations/tau_decorators.dart';
import '../foundations/theme/tau_theme.dart';

/// Card visual variants for tactical terminal UI.
enum TauCardVariant {
  /// Black background with subtle border.
  /// Used for standard content panels.
  /// Example: "ONI" card in right panel.
  elevated,

  /// Lime green header bar with black body.
  /// Used for highlighted sections and active states.
  /// Example: "RANK 1", "UPGRADES" cards in left sidebar.
  highlight,
}

/// Color variants for card sections.
enum TauCardSectionColor {
  /// Default black background.
  defaultColor,

  /// Error/critical state (red).
  error,

  /// Success/positive state (green).
  success,

  /// Disabled/inactive state (grey).
  disabled,
}

/// TAU NEUE card component with tactical terminal aesthetic.
///
/// Primary layout vehicle with slot-based content areas:
/// header, body, and footer. Supports two visual variants.
///
/// Optional corner brackets add visual detail for emphasis.
///
/// Example:
/// ```dart
/// TauCard(
///   variant: TauCardVariant.highlight,
///   header: Text('RANK 1'),
///   body: Text('Content here'),
///   showCornerBrackets: true,
/// )
/// ```
class TauCard extends StatelessWidget {
  const TauCard({
    super.key,
    this.header,
    this.body,
    this.footer,
    this.variant = TauCardVariant.elevated,
    this.width,
    this.height,
    this.padding,
    this.showCornerBrackets = false,
    this.cornerBracketColor,
    this.cornerBracketSize = 8.0,
    this.cornerBracketCorners = const {
      Corner.topLeft,
      Corner.topRight,
      Corner.bottomLeft,
      Corner.bottomRight,
    },
    this.headerColor = TauCardSectionColor.defaultColor,
    this.bodyColor = TauCardSectionColor.defaultColor,
    this.footerColor = TauCardSectionColor.defaultColor,
    this.headerProgress,
    this.bodyProgress,
    this.footerProgress,
  }) : assert(headerProgress == null || (headerProgress >= 0.0 && headerProgress <= 1.0), 'Progress must be between 0.0 and 1.0'),
       assert(bodyProgress == null || (bodyProgress >= 0.0 && bodyProgress <= 1.0), 'Progress must be between 0.0 and 1.0'),
       assert(footerProgress == null || (footerProgress >= 0.0 && footerProgress <= 1.0), 'Progress must be between 0.0 and 1.0');

  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final TauCardVariant variant;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showCornerBrackets;
  final Color? cornerBracketColor;
  final double cornerBracketSize;
  final Set<Corner> cornerBracketCorners;
  final TauCardSectionColor headerColor;
  final TauCardSectionColor bodyColor;
  final TauCardSectionColor footerColor;

  /// Optional progress value for header from 0.0 to 1.0.
  final double? headerProgress;

  /// Optional progress value for body from 0.0 to 1.0.
  final double? bodyProgress;

  /// Optional progress value for footer from 0.0 to 1.0.
  final double? footerProgress;

  /// Resolves a section color enum to an actual Color.
  Color _resolveColor(BuildContext context, TauCardSectionColor sectionColor) {
    final colors = TauTheme.colorsOf(context);
    switch (sectionColor) {
      case TauCardSectionColor.defaultColor:
        return colors.surfaceBase;
      case TauCardSectionColor.error:
        return colors.accentCritical;
      case TauCardSectionColor.success:
        return colors.accentPrimary;
      case TauCardSectionColor.disabled:
        return colors.surfaceElevated;
    }
  }

  /// Creates a container with progress indicator.
  Widget _buildProgressContainer({
    required Widget child,
    required Color backgroundColor,
    required BoxDecoration decoration,
    required EdgeInsetsGeometry padding,
    double? width,
    double? height,
    double? progress,
  }) {
    final effectiveProgress = progress ?? 1.0;

    if (effectiveProgress >= 1.0) {
      // No progress needed, return normal container
      return Container(
        width: width,
        height: height,
        padding: padding,
        decoration: decoration,
        child: child,
      );
    }

    // Progress needed: slightly darker background with filled portion overlay
    final darkerBackgroundColor = Color.lerp(backgroundColor, const Color(0xFF000000), 0.3)!;

    // If no explicit height, let content determine size and overlay progress
    if (height == null) {
      return Container(
        width: width,
        decoration: decoration.copyWith(color: darkerBackgroundColor),
        child: ClipRRect(
          borderRadius: decoration.borderRadius as BorderRadius? ?? BorderRadius.zero,
          child: Stack(
            children: [
              // Invisible content that establishes size
              Opacity(
                opacity: 0.0,
                child: Padding(
                  padding: padding,
                  child: child,
                ),
              ),
              // Progress overlay
              if (effectiveProgress < 1.0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: effectiveProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              // Visible content on top
              Padding(
                padding: padding,
                child: child,
              ),
            ],
          ),
        ),
      );
    }

    // With explicit height, use Positioned.fill
    return Container(
      width: width,
      height: height,
      decoration: decoration.copyWith(color: darkerBackgroundColor),
      child: ClipRRect(
        borderRadius: decoration.borderRadius as BorderRadius? ?? BorderRadius.zero,
        child: Stack(
          children: [
            // Filled portion (progress width)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: effectiveProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
            // Content on top
            Positioned.fill(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    // For highlight variant, we need to separate header from body
    if (variant == TauCardVariant.highlight && header != null) {
      // Resolve colors for each section
      final resolvedHeaderColor = headerColor == TauCardSectionColor.defaultColor
          ? colors.accentPrimary
          : _resolveColor(context, headerColor);
      final resolvedBodyColor = _resolveColor(context, bodyColor);

      final cardContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header bar - rounded corners only on top
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
            child: _buildProgressContainer(
              width: width,
              padding: EdgeInsets.all(spacing.spacingBase),
              backgroundColor: resolvedHeaderColor,
              decoration: BoxDecoration(
                color: resolvedHeaderColor,
                border: Border.all(
                  color: resolvedHeaderColor,
                  width: 1.0,
                ),
              ),
              progress: headerProgress,
              child: DefaultTextStyle(
                style: typography.labelMono.copyWith(
                  color: colors.textOnAccent,
                ),
                child: header!,
              ),
            ),
          ),
          // Body section - rounded corners only on bottom
          if (body != null || footer != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
              child: _buildProgressContainer(
                width: width,
                height: height,
                padding: padding ?? EdgeInsets.all(spacing.spacingBase * 2),
                backgroundColor: resolvedBodyColor,
                decoration: BoxDecoration(
                  color: resolvedBodyColor,
                  border: Border.all(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                ),
                progress: bodyProgress,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (body != null)
                    RepaintBoundary(
                      child: body!,
                    ),
                  if (footer != null)
                    Padding(
                      padding: EdgeInsets.only(top: spacing.spacingBase),
                      child: footer,
                    ),
                ],
              ),
            ),
          ),
        ],
      );

      // Wrap with corner brackets if enabled
      if (showCornerBrackets) {
        return Stack(
          children: [
            cardContent,
            Positioned.fill(
              child: TauCornerBracket(
                color: cornerBracketColor ?? colors.borderAccent,
                size: cornerBracketSize,
                corners: cornerBracketCorners,
              ),
            ),
          ],
        );
      }

      return cardContent;
    }

    // Elevated variant: simple black card with subtle border
    final children = <Widget>[];

    if (header != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(bottom: spacing.spacingBase),
          child: header,
        ),
      );
    }

    if (body != null) {
      // Only use Expanded if height is specified, otherwise shrink-wrap
      if (height != null) {
        children.add(
          Expanded(
            child: RepaintBoundary(
              child: body,
            ),
          ),
        );
      } else {
        children.add(
          RepaintBoundary(
            child: body,
          ),
        );
      }
    }

    if (footer != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(top: spacing.spacingBase),
          child: footer,
        ),
      );
    }

    final cardContent = TauContainer(
      width: width,
      height: height,
      backgroundColor: _resolveColor(context, bodyColor),
      borderColor: colors.borderSubtle,
      strokeWidth: 1.0,
      borderRadius: 6.0,
      padding: padding ?? EdgeInsets.all(spacing.spacingBase * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );

    // Wrap with corner brackets if enabled
    if (showCornerBrackets) {
      return Stack(
        children: [
          cardContent,
          Positioned.fill(
            child: TauCornerBracket(
              color: cornerBracketColor ?? colors.borderAccent,
              size: cornerBracketSize,
              corners: cornerBracketCorners,
            ),
          ),
        ],
      );
    }

    return cardContent;
  }
}
