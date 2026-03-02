import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauAccordion,
)
Widget basicTauAccordion(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauAccordion(
      items: [
        TauAccordionItem(
          header: 'SECTION 1',
          body: const Text(
            'Content for section 1. This section contains information about the first topic.',
            style: TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ),
        TauAccordionItem(
          header: 'SECTION 2',
          body: const Text(
            'Content for section 2. This section contains information about the second topic.',
            style: TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ),
        TauAccordionItem(
          header: 'SECTION 3',
          body: const Text(
            'Content for section 3. This section contains information about the third topic.',
            style: TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multi-Expand',
  type: TauAccordion,
)
Widget multiExpandTauAccordion(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauAccordion(
      allowMultiple: true,
      initialExpandedIndices: const [0, 1],
      items: [
        TauAccordionItem(
          header: 'SYSTEM STATUS',
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'All systems operational',
                style: TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        TauAccordionItem(
          header: 'NETWORK STATUS',
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Connection stable',
                style: TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        TauAccordionItem(
          header: 'DATABASE STATUS',
          body: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Database responding normally',
                style: TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Complex Content',
  type: TauAccordion,
)
Widget complexTauAccordion(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauAccordion(
      items: [
        TauAccordionItem(
          header: 'USER INFORMATION',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TauInput(
                placeholder: 'Name',
                onChanged: (value) {},
              ),
              const SizedBox(height: 12.0),
              TauInput(
                placeholder: 'Email',
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        TauAccordionItem(
          header: 'SETTINGS',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Color(0xFF8E8E8E),
                      fontSize: 12.0,
                    ),
                  ),
                  TauToggle(
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: Color(0xFF8E8E8E),
                      fontSize: 12.0,
                    ),
                  ),
                  TauToggle(
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
