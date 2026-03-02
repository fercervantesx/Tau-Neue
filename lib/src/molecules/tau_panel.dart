import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE panel component with tactical terminal aesthetic.
///
/// Content panel with optional header and footer.
/// Similar to TauCard but more generic and flexible.
///
/// Example:
/// ```dart
/// TauPanel(
///   header: Text('PANEL HEADER'),
///   body: Text('Panel content'),
///   footer: TauButton(label: 'ACTION', onPressed: () {}),
/// )
/// ```
class TauPanel extends StatelessWidget {
  const TauPanel({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.padding,
  });

  /// Optional header widget.
  final Widget? header;

  /// Body content (required).
  final Widget body;

  /// Optional footer widget.
  final Widget? footer;

  /// Custom padding for body.
  /// If null, uses default spacing.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);

    final effectivePadding = padding ?? EdgeInsets.all(spacing.spacingBase * 2);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          if (header != null)
            Container(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                ),
              ),
              child: header,
            ),

          // Body
          Padding(
            padding: effectivePadding,
            child: body,
          ),

          // Footer
          if (footer != null)
            Container(
              padding: EdgeInsets.all(spacing.spacingBase * 2),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colors.borderSubtle,
                    width: 1.0,
                  ),
                ),
              ),
              child: footer,
            ),
        ],
      ),
    );
  }
}
