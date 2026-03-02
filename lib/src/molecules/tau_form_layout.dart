import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE form layout component with tactical terminal aesthetic.
///
/// Organizes form fields with consistent spacing and label positioning.
/// Supports validation messages and required field indicators.
/// Uses 8px grid system for spacing.
///
/// Example:
/// ```dart
/// TauFormLayout(
///   fields: [
///     TauFormField(
///       label: 'USERNAME',
///       isRequired: true,
///       child: TauInput(placeholder: 'Enter username'),
///     ),
///     TauFormField(
///       label: 'PASSWORD',
///       isRequired: true,
///       child: TauInput(placeholder: 'Enter password', obscureText: true),
///     ),
///   ],
/// )
/// ```
class TauFormLayout extends StatelessWidget {
  const TauFormLayout({
    super.key,
    required this.fields,
    this.spacing = 24.0,
    this.labelSpacing = 8.0,
  });

  /// List of form fields to display.
  final List<TauFormField> fields;

  /// Spacing between form fields.
  final double spacing;

  /// Spacing between label and input.
  final double labelSpacing;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < fields.length; i++) {
      children.add(_TauFormFieldWidget(
        field: fields[i],
        labelSpacing: labelSpacing,
      ));

      // Add spacing between fields (but not after the last one)
      if (i < fields.length - 1) {
        children.add(SizedBox(height: spacing));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Configuration for a single form field.
class TauFormField {
  const TauFormField({
    required this.label,
    required this.child,
    this.isRequired = false,
    this.helperText,
    this.errorText,
  });

  /// Label text displayed above the field.
  final String label;

  /// The form input widget (TauInput, TauSelect, etc.).
  final Widget child;

  /// Whether this field is required (shows indicator).
  final bool isRequired;

  /// Optional helper text displayed below the field.
  final String? helperText;

  /// Optional error text displayed below the field (overrides helperText).
  final String? errorText;
}

/// Internal widget for rendering a single form field with label and messages.
class _TauFormFieldWidget extends StatelessWidget {
  const _TauFormFieldWidget({
    required this.field,
    required this.labelSpacing,
  });

  final TauFormField field;
  final double labelSpacing;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final typography = TauTheme.typographyOf(context);
    final spacing = TauTheme.spacingOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label with required indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              field.label,
              style: typography.labelMono.copyWith(
                color: colors.textOnDark,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (field.isRequired) ...[
              SizedBox(width: spacing.spacingBase / 2),
              Text(
                '*',
                style: typography.labelMono.copyWith(
                  color: colors.accentCritical,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: labelSpacing),
        // Input field
        field.child,
        // Helper or error text
        if (field.errorText != null || field.helperText != null) ...[
          SizedBox(height: spacing.spacingBase / 2),
          Text(
            field.errorText ?? field.helperText!,
            style: typography.bodyMono.copyWith(
              color: field.errorText != null
                  ? colors.accentCritical
                  : colors.textMuted,
              fontSize: 11.0,
            ),
          ),
        ],
      ],
    );
  }
}

/// TAU NEUE form group component for organizing related fields.
///
/// Groups multiple form fields under a section heading.
/// Useful for complex forms with multiple sections.
///
/// Example:
/// ```dart
/// TauFormGroup(
///   title: 'PERSONAL INFORMATION',
///   fields: [
///     TauFormField(
///       label: 'FIRST NAME',
///       child: TauInput(),
///     ),
///     TauFormField(
///       label: 'LAST NAME',
///       child: TauInput(),
///     ),
///   ],
/// )
/// ```
class TauFormGroup extends StatelessWidget {
  const TauFormGroup({
    super.key,
    required this.title,
    required this.fields,
    this.spacing = 24.0,
    this.labelSpacing = 8.0,
  });

  /// Title text for this form group.
  final String title;

  /// List of form fields in this group.
  final List<TauFormField> fields;

  /// Spacing between form fields.
  final double spacing;

  /// Spacing between label and input.
  final double labelSpacing;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacingTokens = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Group title
        Text(
          title,
          style: typography.labelMono.copyWith(
            color: colors.accentPrimary,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: spacingTokens.spacingBase * 2),
        // Form fields
        TauFormLayout(
          fields: fields,
          spacing: spacing,
          labelSpacing: labelSpacing,
        ),
      ],
    );
  }
}
