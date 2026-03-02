import 'package:flutter/material.dart';
import 'theme/tau_theme.dart';

/// TAU NEUE scaffold wrapper.
///
/// Thin wrapper around Flutter Scaffold for consistent theming.
/// Automatically applies surfaceBase background color from theme.
class TauScaffold extends StatelessWidget {
  const TauScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.backgroundColor,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);

    return Scaffold(
      backgroundColor: backgroundColor ?? colors.surfaceBase,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }
}
