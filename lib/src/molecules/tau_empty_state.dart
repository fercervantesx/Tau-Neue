import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE empty state component with tactical terminal aesthetic.
///
/// Placeholder shown when no data is available.
/// Supports icon, heading, description, and optional action buttons.
///
/// Example:
/// ```dart
/// TauEmptyState(
///   icon: Icon(Icons.inbox),
///   heading: 'NO MISSIONS',
///   description: 'All objectives completed. Awaiting new assignments.',
///   primaryAction: TauButton(
///     label: 'REFRESH',
///     onPressed: () => refresh(),
///   ),
/// )
/// ```
class TauEmptyState extends StatelessWidget {
  const TauEmptyState({
    super.key,
    this.icon,
    required this.heading,
    this.description,
    this.primaryAction,
    this.secondaryAction,
  });

  /// Optional icon or illustration widget.
  final Widget? icon;

  /// Heading text (required).
  final String heading;

  /// Optional description text.
  final String? description;

  /// Optional primary action button.
  final Widget? primaryAction;

  /// Optional secondary action button.
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.spacingBase * 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: colors.textMuted,
                  size: 64.0,
                ),
                child: icon!,
              ),
              SizedBox(height: spacing.spacingBase * 3),
            ],
            // Heading
            Text(
              heading,
              style: typography.labelMono.copyWith(
                color: colors.textOnDark,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            // Description
            if (description != null) ...[
              SizedBox(height: spacing.spacingBase),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(
                  description!,
                  style: typography.bodyMono.copyWith(
                    color: colors.textMuted,
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            // Actions
            if (primaryAction != null || secondaryAction != null) ...[
              SizedBox(height: spacing.spacingBase * 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (primaryAction != null) primaryAction!,
                  if (primaryAction != null && secondaryAction != null)
                    SizedBox(width: spacing.spacingBase * 2),
                  if (secondaryAction != null) secondaryAction!,
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
