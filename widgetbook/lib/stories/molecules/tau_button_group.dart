import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Single Select', type: TauButtonGroup)
Widget singleSelectTauButtonGroup(BuildContext context) {
  return _SingleSelectDemo();
}

class _SingleSelectDemo extends StatefulWidget {
  @override
  State<_SingleSelectDemo> createState() => _SingleSelectDemoState();
}

class _SingleSelectDemoState extends State<_SingleSelectDemo> {
  Set<String> _selected = {'list'};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauButtonGroup(
        items: const [
          TauButtonGroupItem(id: 'list', label: 'LIST', icon: Icon(IconData(0xe896, fontFamily: 'MaterialIcons'))),
          TauButtonGroupItem(id: 'grid', label: 'GRID', icon: Icon(IconData(0xe8f0, fontFamily: 'MaterialIcons'))),
        ],
        selectedIds: _selected,
        onSelectionChanged: (ids) => setState(() => _selected = ids),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Multi Select', type: TauButtonGroup)
Widget multiSelectTauButtonGroup(BuildContext context) {
  return _MultiSelectDemo();
}

class _MultiSelectDemo extends StatefulWidget {
  @override
  State<_MultiSelectDemo> createState() => _MultiSelectDemoState();
}

class _MultiSelectDemoState extends State<_MultiSelectDemo> {
  Set<String> _selected = {'bold'};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauButtonGroup(
        allowMultiple: true,
        items: const [
          TauButtonGroupItem(id: 'bold', label: 'B'),
          TauButtonGroupItem(id: 'italic', label: 'I'),
          TauButtonGroupItem(id: 'underline', label: 'U'),
        ],
        selectedIds: _selected,
        onSelectionChanged: (ids) => setState(() => _selected = ids),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Vertical', type: TauButtonGroup)
Widget verticalTauButtonGroup(BuildContext context) {
  return _VerticalDemo();
}

class _VerticalDemo extends StatefulWidget {
  @override
  State<_VerticalDemo> createState() => _VerticalDemoState();
}

class _VerticalDemoState extends State<_VerticalDemo> {
  Set<String> _selected = {'left'};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: TauButtonGroup(
        axis: Axis.vertical,
        items: const [
          TauButtonGroupItem(id: 'left', label: 'LEFT'),
          TauButtonGroupItem(id: 'center', label: 'CENTER'),
          TauButtonGroupItem(id: 'right', label: 'RIGHT'),
        ],
        selectedIds: _selected,
        onSelectionChanged: (ids) => setState(() => _selected = ids),
      ),
    );
  }
}
