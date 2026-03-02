import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Bottom Position',
  type: TauPopover,
)
Widget bottomTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.bottom,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'POPOVER CONTENT',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Additional information displayed in a popover overlay.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'SHOW POPOVER',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Top Position',
  type: TauPopover,
)
Widget topTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.top,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HELP',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Click to view additional details.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'HELP',
          variant: TauButtonVariant.secondary,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Left Position',
  type: TauPopover,
)
Widget leftTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.left,
        width: 200.0,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DETAILS',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Popover on the left side.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'INFO',
          variant: TauButtonVariant.ghost,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Right Position',
  type: TauPopover,
)
Widget rightTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.right,
        width: 200.0,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MORE INFO',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Popover on the right side.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'MORE',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Actions',
  type: TauPopover,
)
Widget actionsTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.bottom,
        width: 280.0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CONFIRM ACTION',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Are you sure you want to proceed with this operation?',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TauButton(
                  label: 'CANCEL',
                  variant: TauButtonVariant.ghost,
                  onPressed: () {},
                ),
                const SizedBox(width: 8.0),
                TauButton(
                  label: 'CONFIRM',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        child: const TauButton(
          label: 'DELETE',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Form',
  type: TauPopover,
)
Widget formTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.bottom,
        width: 320.0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'QUICK ADD',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TauInput(
              placeholder: 'Enter name...',
              onChanged: (value) {},
            ),
            const SizedBox(height: 12.0),
            TauSelect<String>(
              value: 'option1',
              placeholder: 'Select type',
              options: const [
                TauSelectOption(value: 'option1', label: 'Type 1'),
                TauSelectOption(value: 'option2', label: 'Type 2'),
                TauSelectOption(value: 'option3', label: 'Type 3'),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TauButton(
                  label: 'CANCEL',
                  variant: TauButtonVariant.ghost,
                  onPressed: () {},
                ),
                const SizedBox(width: 8.0),
                TauButton(
                  label: 'ADD',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        child: const TauButton(
          label: 'NEW ITEM',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Arrow',
  type: TauPopover,
)
Widget noArrowTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.bottom,
        showArrow: false,
        width: 240.0,
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NO ARROW',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'This popover has no arrow pointer.',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'SHOW',
          variant: TauButtonVariant.secondary,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With List',
  type: TauPopover,
)
Widget listTauPopover(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauPopover(
        position: TauPopoverPosition.bottom,
        width: 280.0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'RECENT ITEMS',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            ...List.generate(
              4,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TauListTile(
                  title: Text('ITEM ${i + 1}'),
                  leading: const Icon(
                    IconData(0xe24d, fontFamily: 'MaterialIcons'),
                    color: Color(0xFF8E8E8E),
                    size: 16.0,
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        child: const TauButton(
          label: 'RECENT',
          variant: TauButtonVariant.ghost,
        ),
      ),
    ),
  );
}
