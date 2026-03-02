import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauPanel,
)
Widget basicTauPanel(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauPanel(
      header: Text(
        'PANEL HEADER',
        style: TextStyle(
          color: Color(0xFFE0E0E0),
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Text(
        'This is panel content. Panels provide a flexible container for organizing content with optional headers and footers.',
        style: TextStyle(
          color: Color(0xFF8E8E8E),
          fontSize: 12.0,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Footer',
  type: TauPanel,
)
Widget footerTauPanel(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: TauPanel(
      header: const Text(
        'CONFIRM ACTION',
        style: TextStyle(
          color: Color(0xFFE0E0E0),
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: const Text(
        'Are you sure you want to proceed with this operation?',
        style: TextStyle(
          color: Color(0xFF8E8E8E),
          fontSize: 12.0,
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TauButton(
            label: 'CANCEL',
            variant: TauButtonVariant.ghost,
            onPressed: () {},
          ),
          const SizedBox(width: 12.0),
          TauButton(
            label: 'CONFIRM',
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'No Header',
  type: TauPanel,
)
Widget noHeaderTauPanel(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauPanel(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'INFORMATION',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Panel without a header section.',
            style: TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    ),
  );
}
