import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauContextMenu,
)
Widget basicTauContextMenu(BuildContext context) {
  return TauContextMenu(
    items: [
      TauContextMenuItem(
        label: 'COPY',
        icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+C',
        onTap: () {},
      ),
      TauContextMenuItem(
        label: 'PASTE',
        icon: const Icon(IconData(0xe14f, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+V',
        onTap: () {},
      ),
      TauContextMenuDivider(),
      TauContextMenuItem(
        label: 'DELETE',
        icon: const Icon(IconData(0xe872, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
    ],
    child: Container(
      padding: const EdgeInsets.all(100.0),
      child: const Center(
        child: Text(
          'RIGHT-CLICK HERE',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'On Content',
  type: TauContextMenu,
)
Widget contentTauContextMenu(BuildContext context) {
  return TauContextMenu(
    items: [
      TauContextMenuItem(
        label: 'EDIT',
        icon: const Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
      TauContextMenuItem(
        label: 'DUPLICATE',
        icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
      TauContextMenuDivider(),
      TauContextMenuItem(
        label: 'SHARE',
        icon: const Icon(IconData(0xe80d, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
      TauContextMenuItem(
        label: 'DOWNLOAD',
        icon: const Icon(IconData(0xe2c4, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
      TauContextMenuDivider(),
      TauContextMenuItem(
        label: 'DELETE',
        icon: const Icon(IconData(0xe872, fontFamily: 'MaterialIcons')),
        onTap: () {},
      ),
    ],
    child: Container(
      padding: const EdgeInsets.all(32.0),
      child: TauCard(
        header: const Text(
          'DOCUMENT',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Right-click on this card to open the context menu.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'This demonstrates how context menus can be attached to any widget for quick actions.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'File Actions',
  type: TauContextMenu,
)
Widget fileActionsTauContextMenu(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        5,
        (i) => TauContextMenu(
          items: [
            TauContextMenuItem(
              label: 'OPEN',
              icon: const Icon(IconData(0xe2c7, fontFamily: 'MaterialIcons')),
              onTap: () {},
            ),
            TauContextMenuItem(
              label: 'RENAME',
              icon: const Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
              onTap: () {},
            ),
            TauContextMenuDivider(),
            TauContextMenuItem(
              label: 'COPY PATH',
              icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')),
              shortcut: 'Ctrl+Shift+C',
              onTap: () {},
            ),
            TauContextMenuItem(
              label: 'PROPERTIES',
              icon: const Icon(IconData(0xe88e, fontFamily: 'MaterialIcons')),
              onTap: () {},
            ),
            TauContextMenuDivider(),
            TauContextMenuItem(
              label: 'DELETE',
              icon: const Icon(IconData(0xe872, fontFamily: 'MaterialIcons')),
              shortcut: 'Del',
              onTap: () {},
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TauListTile(
              title: Text('FILE_${i + 1}.txt'),
              leading: const Icon(
                IconData(0xe24d, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Items',
  type: TauContextMenu,
)
Widget disabledTauContextMenu(BuildContext context) {
  return TauContextMenu(
    items: [
      TauContextMenuItem(
        label: 'CUT',
        icon: const Icon(IconData(0xe14e, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+X',
        enabled: false,
        onTap: () {},
      ),
      TauContextMenuItem(
        label: 'COPY',
        icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+C',
        enabled: false,
        onTap: () {},
      ),
      TauContextMenuItem(
        label: 'PASTE',
        icon: const Icon(IconData(0xe14f, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+V',
        onTap: () {},
      ),
      TauContextMenuDivider(),
      TauContextMenuItem(
        label: 'SELECT ALL',
        icon: const Icon(IconData(0xe162, fontFamily: 'MaterialIcons')),
        shortcut: 'Ctrl+A',
        onTap: () {},
      ),
    ],
    child: Container(
      padding: const EdgeInsets.all(100.0),
      child: const Center(
        child: Text(
          'RIGHT-CLICK (Some items disabled)',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
