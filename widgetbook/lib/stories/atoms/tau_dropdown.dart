import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauDropdown,
)
Widget basicTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        items: [
          TauDropdownItem(
            label: 'EDIT',
            icon: const Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')), // edit
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'DUPLICATE',
            icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')), // content_copy
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'DELETE',
            icon: const Icon(IconData(0xe872, fontFamily: 'MaterialIcons')), // delete
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'ACTIONS',
          variant: TauButtonVariant.secondary,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: TauDropdown,
)
Widget iconsTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        items: [
          TauDropdownItem(
            label: 'NEW FILE',
            icon: const Icon(IconData(0xe24d, fontFamily: 'MaterialIcons')), // insert_drive_file
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'NEW FOLDER',
            icon: const Icon(IconData(0xe2c8, fontFamily: 'MaterialIcons')), // create_new_folder
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'UPLOAD',
            icon: const Icon(IconData(0xe2c6, fontFamily: 'MaterialIcons')), // upload
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'DOWNLOAD',
            icon: const Icon(IconData(0xe2c4, fontFamily: 'MaterialIcons')), // download
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'NEW',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Shortcuts',
  type: TauDropdown,
)
Widget shortcutsTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        width: 220.0,
        items: [
          TauDropdownItem(
            label: 'SAVE',
            icon: const Icon(IconData(0xe161, fontFamily: 'MaterialIcons')), // save
            shortcut: 'Ctrl+S',
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'SAVE AS',
            icon: const Icon(IconData(0xe161, fontFamily: 'MaterialIcons')), // save
            shortcut: 'Ctrl+Shift+S',
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'EXPORT',
            icon: const Icon(IconData(0xe0ee, fontFamily: 'MaterialIcons')), // ios_share
            shortcut: 'Ctrl+E',
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'PRINT',
            icon: const Icon(IconData(0xe8ad, fontFamily: 'MaterialIcons')), // print
            shortcut: 'Ctrl+P',
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'FILE',
          variant: TauButtonVariant.ghost,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Items',
  type: TauDropdown,
)
Widget disabledTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        items: [
          TauDropdownItem(
            label: 'CUT',
            icon: const Icon(IconData(0xe14e, fontFamily: 'MaterialIcons')), // content_cut
            enabled: false,
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'COPY',
            icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')), // content_copy
            enabled: false,
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'PASTE',
            icon: const Icon(IconData(0xe14f, fontFamily: 'MaterialIcons')), // content_paste
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'SELECT ALL',
            icon: const Icon(IconData(0xe162, fontFamily: 'MaterialIcons')), // select_all
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'EDIT',
          variant: TauButtonVariant.secondary,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Wide Menu',
  type: TauDropdown,
)
Widget wideTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        width: 300.0,
        items: [
          TauDropdownItem(
            label: 'SYSTEM PREFERENCES',
            icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')), // settings
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'USER MANAGEMENT',
            icon: const Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')), // group
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'SECURITY SETTINGS',
            icon: const Icon(IconData(0xe32a, fontFamily: 'MaterialIcons')), // security
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'ABOUT',
            icon: const Icon(IconData(0xe88e, fontFamily: 'MaterialIcons')), // info
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'SETTINGS',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'User Menu',
  type: TauDropdown,
)
Widget userMenuTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        width: 200.0,
        items: [
          TauDropdownItem(
            label: 'PROFILE',
            icon: const Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons')), // person
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'SETTINGS',
            icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')), // settings
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'HELP',
            icon: const Icon(IconData(0xe887, fontFamily: 'MaterialIcons')), // help
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'FEEDBACK',
            icon: const Icon(IconData(0xe87f, fontFamily: 'MaterialIcons')), // feedback
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'LOGOUT',
            icon: const Icon(IconData(0xe9ba, fontFamily: 'MaterialIcons')), // logout
            onTap: () {},
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            border: Border.all(
              color: const Color(0xFF3A3A3A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'USER',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                IconData(0xe5cf, fontFamily: 'MaterialIcons'), // expand_more
                color: Color(0xFF8E8E8E),
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Icons',
  type: TauDropdown,
)
Widget noIconsTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        items: [
          TauDropdownItem(
            label: 'OPTION 1',
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'OPTION 2',
            onTap: () {},
          ),
          TauDropdownItem(
            label: 'OPTION 3',
            onTap: () {},
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'MORE OPTIONS',
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'OPTIONS',
          variant: TauButtonVariant.secondary,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Many Items',
  type: TauDropdown,
)
Widget manyItemsTauDropdown(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauDropdown(
        width: 240.0,
        items: [
          ...List.generate(
            10,
            (i) => TauDropdownItem(
              label: 'ITEM ${i + 1}',
              icon: const Icon(IconData(0xe5ca, fontFamily: 'MaterialIcons')),
              onTap: () {},
            ),
          ),
          TauDropdownDivider(),
          TauDropdownItem(
            label: 'SHOW MORE',
            onTap: () {},
          ),
        ],
        child: const TauButton(
          label: 'ITEMS',
        ),
      ),
    ),
  );
}
