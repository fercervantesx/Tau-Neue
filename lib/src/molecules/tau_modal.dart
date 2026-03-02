import 'dart:ui';

import 'package:flutter/material.dart';
import '../foundations/tau_container.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE modal bottom sheet.
///
/// Mechanical snap transition with backdrop blur effect.
/// Uses snapMechanical duration (150ms) for industrial feel.
class TauModal {
  TauModal._();

  /// Shows a modal bottom sheet with TAU NEUE styling.
  ///
  /// Example:
  /// ```dart
  /// TauModal.show(
  ///   context: context,
  ///   builder: (context) => TauCard(
  ///     header: Text('Modal Title'),
  ///     body: Text('Modal content'),
  ///   ),
  /// );
  /// ```
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
  }) {
    final colors = TauTheme.colorsOf(context);
    final spacing = TauTheme.spacingOf(context);
    final motion = TauTheme.motionOf(context);

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: motion.snapMechanical,
      ),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: height,
            margin: EdgeInsets.all(spacing.spacingBase * 2),
            child: TauContainer(
              backgroundColor: colors.surfaceBase,
              borderColor: colors.borderSubtle,
              strokeWidth: spacing.strokeWeightBase,
              borderRadius: 8.0,
              padding: EdgeInsets.all(spacing.spacingBase * 3),
              child: builder(context),
            ),
          ),
        );
      },
    );
  }
}
