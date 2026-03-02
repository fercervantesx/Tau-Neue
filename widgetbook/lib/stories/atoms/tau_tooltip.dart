import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Top Position',
  type: TauTooltip,
)
Widget topTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauTooltip(
        message: 'Tooltip appears on top',
        position: TauTooltipPosition.top,
        child: TauButton(
          label: 'HOVER ME',
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Bottom Position',
  type: TauTooltip,
)
Widget bottomTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauTooltip(
        message: 'Tooltip appears on bottom',
        position: TauTooltipPosition.bottom,
        child: TauButton(
          label: 'HOVER ME',
          variant: TauButtonVariant.secondary,
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Left Position',
  type: TauTooltip,
)
Widget leftTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauTooltip(
        message: 'Tooltip on left',
        position: TauTooltipPosition.left,
        child: TauButton(
          label: 'HOVER',
          variant: TauButtonVariant.ghost,
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Right Position',
  type: TauTooltip,
)
Widget rightTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauTooltip(
        message: 'Tooltip on right',
        position: TauTooltipPosition.right,
        child: TauButton(
          label: 'INFO',
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icon Button',
  type: TauTooltip,
)
Widget iconButtonTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TauTooltip(
          message: 'Settings',
          child: GestureDetector(
            onTap: () {},
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
              child: const Icon(
                IconData(0xe8b8, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        TauTooltip(
          message: 'Notifications',
          child: GestureDetector(
            onTap: () {},
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
              child: const Icon(
                IconData(0xe7f4, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        TauTooltip(
          message: 'Help',
          child: GestureDetector(
            onTap: () {},
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
              child: const Icon(
                IconData(0xe887, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Long Message',
  type: TauTooltip,
)
Widget longMessageTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Center(
      child: TauTooltip(
        message: 'This is a longer tooltip message that provides more detailed information about the action.',
        position: TauTooltipPosition.top,
        child: TauButton(
          label: 'HOVER FOR MORE',
          variant: TauButtonVariant.secondary,
          onPressed: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Delay',
  type: TauTooltip,
)
Widget customDelayTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Different delay times:',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 24.0),
        TauTooltip(
          message: 'Instant (0ms delay)',
          delay: Duration.zero,
          child: TauButton(
            label: 'INSTANT',
            variant: TauButtonVariant.secondary,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 16.0),
        TauTooltip(
          message: 'Fast (200ms delay)',
          delay: const Duration(milliseconds: 200),
          child: TauButton(
            label: 'FAST',
            variant: TauButtonVariant.secondary,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 16.0),
        TauTooltip(
          message: 'Default (500ms delay)',
          delay: const Duration(milliseconds: 500),
          child: TauButton(
            label: 'DEFAULT',
            variant: TauButtonVariant.secondary,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 16.0),
        TauTooltip(
          message: 'Slow (1000ms delay)',
          delay: const Duration(milliseconds: 1000),
          child: TauButton(
            label: 'SLOW',
            variant: TauButtonVariant.secondary,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multiple Targets',
  type: TauTooltip,
)
Widget multipleTargetsTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(100.0),
    child: Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        12,
        (i) => TauTooltip(
          message: 'Item ${i + 1}',
          position: i % 2 == 0 ? TauTooltipPosition.top : TauTooltipPosition.bottom,
          child: Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              border: Border.all(
                color: const Color(0xFF3A3A3A),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Color(0xFF8E8E8E),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'On List Items',
  type: TauTooltip,
)
Widget listItemsTauTooltip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        5,
        (i) => TauTooltip(
          message: 'Click to view details for item ${i + 1}',
          position: TauTooltipPosition.right,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TauListTile(
              title: Text('ITEM ${i + 1}'),
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
