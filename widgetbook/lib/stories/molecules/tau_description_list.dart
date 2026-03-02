import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Vertical',
  type: TauDescriptionList,
)
Widget verticalTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauDescriptionList(
      items: [
        TauDescriptionItem(
          term: 'OPERATOR ID',
          description: 'ALPHA-7729',
        ),
        TauDescriptionItem(
          term: 'CLEARANCE LEVEL',
          description: 'CLASSIFIED',
        ),
        TauDescriptionItem(
          term: 'DEPLOYMENT ZONE',
          description: 'SECTOR 7-G',
        ),
        TauDescriptionItem(
          term: 'STATUS',
          description: 'ACTIVE',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Horizontal',
  type: TauDescriptionList,
)
Widget horizontalTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauDescriptionList(
      layout: TauDescriptionListLayout.horizontal,
      items: [
        TauDescriptionItem(
          term: 'OPERATOR ID',
          description: 'ALPHA-7729',
        ),
        TauDescriptionItem(
          term: 'CLEARANCE',
          description: 'CLASSIFIED',
        ),
        TauDescriptionItem(
          term: 'ZONE',
          description: 'SECTOR 7-G',
        ),
        TauDescriptionItem(
          term: 'STATUS',
          description: 'ACTIVE',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Dividers',
  type: TauDescriptionList,
)
Widget dividersTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauDescriptionList(
      layout: TauDescriptionListLayout.horizontal,
      showDividers: true,
      items: [
        TauDescriptionItem(
          term: 'MISSION CODE',
          description: 'OMEGA-STRIKE',
        ),
        TauDescriptionItem(
          term: 'COMMENCED',
          description: '2300-03-15 14:22:00',
        ),
        TauDescriptionItem(
          term: 'DURATION',
          description: '03:45:12',
        ),
        TauDescriptionItem(
          term: 'OBJECTIVE',
          description: 'SECURE PERIMETER',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dense Spacing',
  type: TauDescriptionList,
)
Widget denseTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauDescriptionList(
      spacing: TauDescriptionListSpacing.dense,
      items: [
        TauDescriptionItem(
          term: 'PROTOCOL',
          description: 'ENCRYPTED-TLS-1.3',
        ),
        TauDescriptionItem(
          term: 'CIPHER',
          description: 'AES-256-GCM',
        ),
        TauDescriptionItem(
          term: 'KEY LENGTH',
          description: '4096-BIT',
        ),
        TauDescriptionItem(
          term: 'HASH',
          description: 'SHA-512',
        ),
        TauDescriptionItem(
          term: 'SALT',
          description: 'BCRYPT-12',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Widgets',
  type: TauDescriptionList,
)
Widget widgetsTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauDescriptionList(
      layout: TauDescriptionListLayout.horizontal,
      items: [
        const TauDescriptionItem(
          term: 'OPERATOR',
          description: 'ALPHA-7729',
        ),
        TauDescriptionItem(
          term: 'STATUS',
          description: TauBadge(
            label: 'ACTIVE',
            backgroundColor: const Color(0xFFC0FC04),
            textColor: const Color(0xFF000000),
          ),
        ),
        TauDescriptionItem(
          term: 'ENCRYPTION',
          description: TauToggle(
            value: true,
            label: 'ENABLED',
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Long Content',
  type: TauDescriptionList,
)
Widget longContentTauDescriptionList(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauDescriptionList(
      layout: TauDescriptionListLayout.horizontal,
      termWidth: 150.0,
      items: [
        TauDescriptionItem(
          term: 'MISSION BRIEF',
          description:
              'Infiltrate hostile territory at coordinates 47.2N 122.3W. Secure intelligence package from embedded asset. Extract via helicopter at LZ BRAVO. Maintain radio silence unless compromised.',
        ),
        TauDescriptionItem(
          term: 'EQUIPMENT',
          description:
              'Standard tactical loadout including M4A1 carbine, sidearm, night vision goggles, encrypted radio, GPS tracker, and field medical kit.',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Inline Description',
  type: TauInlineDescription,
)
Widget inlineTauDescription(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        TauInlineDescription(
          term: 'STATUS',
          description: 'ACTIVE',
        ),
        SizedBox(height: 8.0),
        TauInlineDescription(
          term: 'ZONE',
          description: 'SECTOR 7-G',
        ),
        SizedBox(height: 8.0),
        TauInlineDescription(
          term: 'CLEARANCE',
          description: 'CLASSIFIED',
        ),
      ],
    ),
  );
}
