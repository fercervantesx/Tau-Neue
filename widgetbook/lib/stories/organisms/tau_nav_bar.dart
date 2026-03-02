import 'package:flutter/material.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TauNavBar)
Widget tauNavBarDefault(BuildContext context) {
  return TauScaffold(
    body: const Center(
      child: Text('Nav Bar Preview'),
    ),
    bottomNavigationBar: TauNavBar(
      currentIndex: context.knobs.int.slider(
        label: 'Current Index',
        initialValue: 0,
        min: 0,
        max: 2,
      ),
      onTap: (index) {},
      items: const [
        TauNavBarItem(icon: Icon(Icons.terminal), label: 'COMMAND'),
        TauNavBarItem(icon: Icon(Icons.assessment), label: 'STATUS'),
        TauNavBarItem(icon: Icon(Icons.settings), label: 'CONFIG'),
      ],
    ),
  );
}
