import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Variants',
  type: TauAlert,
)
Widget variantsTauAlert(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauAlert(
          variant: TauAlertVariant.info,
          title: 'INFORMATION',
          message: 'System diagnostics completed successfully.',
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.success,
          title: 'SUCCESS',
          message: 'Mission objectives achieved. All operators returned safely.',
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.warning,
          title: 'WARNING',
          message: 'Unauthorized access attempt detected on sector 7-G.',
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.error,
          title: 'ERROR',
          message: 'Critical system failure. Immediate action required.',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Title',
  type: TauAlert,
)
Widget noTitleTauAlert(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauAlert(
          variant: TauAlertVariant.info,
          message: 'New firmware update available for download.',
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.success,
          message: 'All systems operational.',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Icon',
  type: TauAlert,
)
Widget noIconTauAlert(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauAlert(
          variant: TauAlertVariant.info,
          title: 'NOTIFICATION',
          message: 'System maintenance scheduled for 0300 hours.',
          showIcon: false,
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.warning,
          title: 'ATTENTION',
          message: 'Limited network connectivity detected.',
          showIcon: false,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Close Button',
  type: TauAlert,
)
Widget dismissibleTauAlert(BuildContext context) {
  return _DismissibleTauAlertDemo();
}

class _DismissibleTauAlertDemo extends StatefulWidget {
  @override
  State<_DismissibleTauAlertDemo> createState() =>
      _DismissibleTauAlertDemoState();
}

class _DismissibleTauAlertDemoState extends State<_DismissibleTauAlertDemo> {
  bool _showInfo = true;
  bool _showSuccess = true;
  bool _showWarning = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showInfo)
            TauAlert(
              variant: TauAlertVariant.info,
              title: 'SYSTEM UPDATE',
              message: 'A new system update is available.',
              onClose: () => setState(() => _showInfo = false),
            ),
          if (_showInfo) const SizedBox(height: 16.0),
          if (_showSuccess)
            TauAlert(
              variant: TauAlertVariant.success,
              title: 'BACKUP COMPLETE',
              message: 'All data has been backed up successfully.',
              onClose: () => setState(() => _showSuccess = false),
            ),
          if (_showSuccess) const SizedBox(height: 16.0),
          if (_showWarning)
            TauAlert(
              variant: TauAlertVariant.warning,
              title: 'LOW STORAGE',
              message: 'Less than 10% storage space remaining.',
              onClose: () => setState(() => _showWarning = false),
            ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Long Content',
  type: TauAlert,
)
Widget longContentTauAlert(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauAlert(
          variant: TauAlertVariant.info,
          title: 'MISSION BRIEFING',
          message:
              'Operation OMEGA-STRIKE commences at 0400 hours. All units are to assemble at LZ ALPHA. Primary objective: secure intelligence package from hostile territory. Secondary objective: extract embedded asset code-named NIGHTFALL. Maintain radio silence unless compromised. Exfil via helicopter at LZ BRAVO upon completion.',
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.warning,
          title: 'SECURITY PROTOCOLS',
          message:
              'Multiple unauthorized access attempts detected across sectors 4-7. All personnel are advised to update authentication credentials immediately. Two-factor authentication is now mandatory for all classified systems. Failure to comply will result in immediate access revocation.',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Icons',
  type: TauAlert,
)
Widget customIconsTauAlert(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauAlert(
          variant: TauAlertVariant.info,
          title: 'ENCRYPTION ACTIVE',
          message: 'All communications are encrypted end-to-end.',
          icon: Icon(IconData(0xe897, fontFamily: 'MaterialIcons')), // lock
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.success,
          title: 'UPLOAD COMPLETE',
          message: 'Files successfully uploaded to secure server.',
          icon: Icon(IconData(0xe2c6, fontFamily: 'MaterialIcons')), // cloud_done
        ),
        SizedBox(height: 16.0),
        TauAlert(
          variant: TauAlertVariant.warning,
          title: 'BATTERY LOW',
          message: 'Device battery below 15%. Connect to power source.',
          icon: Icon(IconData(0xe19c, fontFamily: 'MaterialIcons')), // battery_alert
        ),
      ],
    ),
  );
}
