import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE steps component with tactical terminal aesthetic.
///
/// Step indicator for multi-step flows and wizards.
/// Shows progress through sequential steps with visual indicators.
///
/// Example:
/// ```dart
/// TauSteps(
///   currentStep: 1,
///   steps: [
///     TauStep(label: 'CONFIGURE'),
///     TauStep(label: 'VALIDATE'),
///     TauStep(label: 'DEPLOY'),
///     TauStep(label: 'VERIFY'),
///   ],
///   onStepTapped: (index) => navigateToStep(index),
/// )
/// ```
class TauSteps extends StatelessWidget {
  const TauSteps({
    super.key,
    required this.currentStep,
    required this.steps,
    this.onStepTapped,
    this.axis = Axis.horizontal,
  })  : assert(currentStep >= 0, 'currentStep must be >= 0'),
        assert(currentStep < steps.length, 'currentStep must be < steps.length'),
        assert(steps.length > 0, 'At least one step is required');

  /// Current active step index (0-indexed).
  final int currentStep;

  /// List of step definitions.
  final List<TauStep> steps;

  /// Callback when a step is tapped.
  /// If null, steps are not interactive.
  final ValueChanged<int>? onStepTapped;

  /// Layout direction (horizontal or vertical).
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final typography = TauTheme.typographyOf(context);

    final children = <Widget>[];

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final isCompleted = i < currentStep;
      final isCurrent = i == currentStep;
      final isUpcoming = i > currentStep;

      children.add(
        _TauStepItem(
          step: step,
          stepNumber: i + 1,
          isCompleted: isCompleted,
          isCurrent: isCurrent,
          isUpcoming: isUpcoming,
          onTap: onStepTapped != null ? () => onStepTapped!(i) : null,
          axis: axis,
          colors: colors,
          spacing: spacing,
          typography: typography,
        ),
      );

      // Add connector line except after last step
      if (i < steps.length - 1) {
        children.add(
          _TauStepConnector(
            isCompleted: isCompleted,
            axis: axis,
            colors: colors,
            spacing: spacing,
          ),
        );
      }
    }

    if (axis == Axis.horizontal) {
      return Row(
        children: children,
      );
    } else {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      );
    }
  }
}

/// Configuration for a single step.
class TauStep {
  const TauStep({
    required this.label,
    this.description,
    this.icon,
  });

  /// Step label.
  final String label;

  /// Optional step description.
  final String? description;

  /// Optional custom icon.
  /// If null, shows step number.
  final Widget? icon;
}

/// Internal step item widget.
class _TauStepItem extends StatefulWidget {
  const _TauStepItem({
    required this.step,
    required this.stepNumber,
    required this.isCompleted,
    required this.isCurrent,
    required this.isUpcoming,
    required this.onTap,
    required this.axis,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  final TauStep step;
  final int stepNumber;
  final bool isCompleted;
  final bool isCurrent;
  final bool isUpcoming;
  final VoidCallback? onTap;
  final Axis axis;
  final dynamic colors;
  final dynamic spacing;
  final dynamic typography;

  @override
  State<_TauStepItem> createState() => _TauStepItemState();
}

class _TauStepItemState extends State<_TauStepItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onTap != null;

    // Determine colors based on state
    Color indicatorColor;
    Color indicatorBorderColor;
    Color textColor;

    if (widget.isCompleted) {
      indicatorColor = widget.colors.accentPrimary;
      indicatorBorderColor = widget.colors.accentPrimary;
      textColor = widget.colors.textOnDark;
    } else if (widget.isCurrent) {
      indicatorColor = widget.colors.accentPrimary;
      indicatorBorderColor = widget.colors.accentPrimary;
      textColor = widget.colors.textOnDark;
    } else {
      indicatorColor = widget.colors.surfaceBase;
      indicatorBorderColor = widget.colors.borderSubtle;
      textColor = widget.colors.textMuted;
    }

    if (_hovered && isInteractive) {
      textColor = widget.colors.textOnDark;
    }

    // Build indicator (circle with number or icon)
    final indicator = Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        color: indicatorColor,
        border: Border.all(color: indicatorBorderColor, width: 2.0),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: widget.step.icon != null
            ? IconTheme(
                data: IconThemeData(
                  color: widget.isCurrent || widget.isCompleted
                      ? widget.colors.textOnAccent
                      : widget.colors.textMuted,
                  size: 16.0,
                ),
                child: widget.step.icon!,
              )
            : widget.isCompleted
                ? Icon(
                    const IconData(0xe5ca, fontFamily: 'MaterialIcons'), // check
                    color: widget.colors.textOnAccent,
                    size: 16.0,
                  )
                : Text(
                    widget.stepNumber.toString(),
                    style: widget.typography.labelMono.copyWith(
                      color: widget.isCurrent
                          ? widget.colors.textOnAccent
                          : widget.colors.textMuted,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      ),
    );

    // Build label and description
    final labelWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.step.label,
          style: widget.typography.labelMono.copyWith(
            color: textColor,
            fontSize: 12.0,
            fontWeight: widget.isCurrent ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
        if (widget.step.description != null) ...{
          SizedBox(height: widget.spacing.spacingBase / 2),
          Text(
            widget.step.description!,
            style: widget.typography.bodyMono.copyWith(
              color: widget.colors.textMuted,
              fontSize: 11.0,
            ),
          ),
        },
      ],
    );

    Widget content;
    if (widget.axis == Axis.horizontal) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          SizedBox(height: widget.spacing.spacingBase),
          labelWidget,
        ],
      );
    } else {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          indicator,
          SizedBox(width: widget.spacing.spacingBase * 2),
          Expanded(child: labelWidget),
        ],
      );
    }

    if (!isInteractive) {
      return content;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: content,
      ),
    );
  }
}

/// Internal connector line between steps.
class _TauStepConnector extends StatelessWidget {
  const _TauStepConnector({
    required this.isCompleted,
    required this.axis,
    required this.colors,
    required this.spacing,
  });

  final bool isCompleted;
  final Axis axis;
  final dynamic colors;
  final dynamic spacing;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? colors.accentPrimary : colors.borderSubtle;

    if (axis == Axis.horizontal) {
      return Expanded(
        child: Container(
          height: 2.0,
          margin: EdgeInsets.symmetric(horizontal: spacing.spacingBase),
          color: color,
        ),
      );
    } else {
      return Container(
        width: 2.0,
        height: spacing.spacingBase * 3,
        margin: EdgeInsets.only(left: 15.0), // Center align with indicator
        color: color,
      );
    }
  }
}
