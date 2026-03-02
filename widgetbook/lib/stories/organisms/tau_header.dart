import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauHeader,
)
Widget basicTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        left: GestureDetector(
          onTap: () {},
          child: const Icon(
            IconData(0xe5d2, fontFamily: 'MaterialIcons'), // menu
            color: Color(0xFF8E8E8E),
            size: 24.0,
          ),
        ),
        center: const Text(
          'DASHBOARD',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                IconData(0xe7f4, fontFamily: 'MaterialIcons'), // notifications
                color: Color(0xFF8E8E8E),
                size: 24.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                border: Border.all(
                  color: const Color(0xFF3A3A3A),
                  width: 1.0,
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'U',
                  style: TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
          child: const Center(
            child: Text(
              'Page Content',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'With Logo',
  type: TauHeader,
)
Widget logoTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        left: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconData(0xe86d, fontFamily: 'MaterialIcons'), // flight
              color: Color(0xFFC0FC04),
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Text(
              'TAU SYSTEM',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TauButton(
              label: 'SIGN IN',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
            const SizedBox(width: 12.0),
            TauButton(
              label: 'SIGN UP',
              onPressed: () {},
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'With Search',
  type: TauHeader,
)
Widget searchTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        left: GestureDetector(
          onTap: () {},
          child: const Icon(
            IconData(0xe5d2, fontFamily: 'MaterialIcons'),
            color: Color(0xFF8E8E8E),
            size: 24.0,
          ),
        ),
        center: SizedBox(
          width: 400.0,
          child: TauInput(
            placeholder: 'Search...',
            onChanged: (value) {},
          ),
        ),
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                IconData(0xe8b8, fontFamily: 'MaterialIcons'),
                color: Color(0xFF8E8E8E),
                size: 24.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                border: Border.all(
                  color: const Color(0xFF3A3A3A),
                  width: 1.0,
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'With Navigation',
  type: TauHeader,
)
Widget navigationTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        height: 72.0,
        left: const Text(
          'TAU',
          style: TextStyle(
            color: Color(0xFFC0FC04),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        center: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TauButton(
              label: 'DASHBOARD',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
            const SizedBox(width: 8.0),
            TauButton(
              label: 'MISSIONS',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
            const SizedBox(width: 8.0),
            TauButton(
              label: 'OPERATORS',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
            const SizedBox(width: 8.0),
            TauButton(
              label: 'ANALYTICS',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
          ],
        ),
        right: TauButton(
          label: 'CONTACT',
          onPressed: () {},
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Minimal',
  type: TauHeader,
)
Widget minimalTauHeader(BuildContext context) {
  return Column(
    children: [
      const TauHeader(
        center: Text(
          'OPERATIONS CENTER',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Without Border',
  type: TauHeader,
)
Widget noBorderTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        showBorder: false,
        left: const Text(
          'TAU',
          style: TextStyle(
            color: Color(0xFFC0FC04),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TauButton(
              label: 'SETTINGS',
              variant: TauButtonVariant.ghost,
              onPressed: () {},
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Tall Header',
  type: TauHeader,
)
Widget tallTauHeader(BuildContext context) {
  return Column(
    children: [
      TauHeader(
        height: 96.0,
        left: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TAU SYSTEM',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Mission Control Center',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 11.0,
              ),
            ),
          ],
        ),
        right: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TauButton(
              label: 'DEPLOY',
              onPressed: () {},
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}
