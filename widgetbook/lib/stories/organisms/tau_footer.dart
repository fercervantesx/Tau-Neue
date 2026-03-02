import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauFooter,
)
Widget basicTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      TauFooter(
        columns: [
          TauFooterColumn(
            title: 'PRODUCT',
            links: [
              TauFooterLink(label: 'Features', onTap: () {}),
              TauFooterLink(label: 'Pricing', onTap: () {}),
              TauFooterLink(label: 'Security', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'COMPANY',
            links: [
              TauFooterLink(label: 'About', onTap: () {}),
              TauFooterLink(label: 'Careers', onTap: () {}),
              TauFooterLink(label: 'Contact', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'RESOURCES',
            links: [
              TauFooterLink(label: 'Documentation', onTap: () {}),
              TauFooterLink(label: 'API Reference', onTap: () {}),
              TauFooterLink(label: 'Support', onTap: () {}),
            ],
          ),
        ],
        copyright: '© 2024 TAU SYSTEM. All rights reserved.',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'With Logo',
  type: TauFooter,
)
Widget logoTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      TauFooter(
        logo: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconData(0xe86d, fontFamily: 'MaterialIcons'),
              color: Color(0xFFC0FC04),
              size: 32.0,
            ),
            SizedBox(width: 12.0),
            Text(
              'TAU SYSTEM',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        columns: [
          TauFooterColumn(
            title: 'PRODUCT',
            links: [
              TauFooterLink(label: 'Features', onTap: () {}),
              TauFooterLink(label: 'Pricing', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'COMPANY',
            links: [
              TauFooterLink(label: 'About', onTap: () {}),
              TauFooterLink(label: 'Contact', onTap: () {}),
            ],
          ),
        ],
        copyright: '© 2024 TAU SYSTEM. All rights reserved.',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Many Columns',
  type: TauFooter,
)
Widget manyColumnsTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      TauFooter(
        columns: [
          TauFooterColumn(
            title: 'PRODUCT',
            links: [
              TauFooterLink(label: 'Features', onTap: () {}),
              TauFooterLink(label: 'Pricing', onTap: () {}),
              TauFooterLink(label: 'Security', onTap: () {}),
              TauFooterLink(label: 'Roadmap', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'PLATFORM',
            links: [
              TauFooterLink(label: 'API', onTap: () {}),
              TauFooterLink(label: 'Integrations', onTap: () {}),
              TauFooterLink(label: 'Plugins', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'COMPANY',
            links: [
              TauFooterLink(label: 'About', onTap: () {}),
              TauFooterLink(label: 'Careers', onTap: () {}),
              TauFooterLink(label: 'Blog', onTap: () {}),
              TauFooterLink(label: 'Press', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'RESOURCES',
            links: [
              TauFooterLink(label: 'Documentation', onTap: () {}),
              TauFooterLink(label: 'Guides', onTap: () {}),
              TauFooterLink(label: 'Support', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'LEGAL',
            links: [
              TauFooterLink(label: 'Privacy', onTap: () {}),
              TauFooterLink(label: 'Terms', onTap: () {}),
              TauFooterLink(label: 'Cookies', onTap: () {}),
            ],
          ),
        ],
        copyright: '© 2024 TAU SYSTEM. All rights reserved.',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Minimal',
  type: TauFooter,
)
Widget minimalTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      const TauFooter(
        copyright: '© 2024 TAU SYSTEM. All rights reserved.',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Without Border',
  type: TauFooter,
)
Widget noBorderTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      TauFooter(
        showBorder: false,
        columns: [
          TauFooterColumn(
            title: 'LEGAL',
            links: [
              TauFooterLink(label: 'Privacy', onTap: () {}),
              TauFooterLink(label: 'Terms', onTap: () {}),
            ],
          ),
        ],
        copyright: '© 2024 TAU SYSTEM',
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Social Links',
  type: TauFooter,
)
Widget socialLinksTauFooter(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: const Color(0xFF1A1A1A),
        ),
      ),
      TauFooter(
        logo: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconData(0xe86d, fontFamily: 'MaterialIcons'),
              color: Color(0xFFC0FC04),
              size: 28.0,
            ),
            SizedBox(width: 12.0),
            Text(
              'TAU',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        columns: [
          TauFooterColumn(
            title: 'CONNECT',
            links: [
              TauFooterLink(label: 'Twitter', onTap: () {}),
              TauFooterLink(label: 'GitHub', onTap: () {}),
              TauFooterLink(label: 'Discord', onTap: () {}),
              TauFooterLink(label: 'LinkedIn', onTap: () {}),
            ],
          ),
          TauFooterColumn(
            title: 'SUPPORT',
            links: [
              TauFooterLink(label: 'Help Center', onTap: () {}),
              TauFooterLink(label: 'Community', onTap: () {}),
              TauFooterLink(label: 'Status', onTap: () {}),
            ],
          ),
        ],
        copyright: '© 2024 TAU SYSTEM. Built with Flutter.',
      ),
    ],
  );
}
