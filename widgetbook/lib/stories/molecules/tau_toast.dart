import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Variants',
  type: TauToast,
)
Widget variantsTauToast(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TauToast(
          variant: TauToastVariant.info,
          message: 'System diagnostics completed successfully.',
          autoDismiss: false,
          onDismiss: () {},
        ),
        const SizedBox(height: 16.0),
        TauToast(
          variant: TauToastVariant.success,
          message: 'Files uploaded successfully to secure server.',
          autoDismiss: false,
          onDismiss: () {},
        ),
        const SizedBox(height: 16.0),
        TauToast(
          variant: TauToastVariant.warning,
          message: 'Unauthorized access attempt detected.',
          autoDismiss: false,
          onDismiss: () {},
        ),
        const SizedBox(height: 16.0),
        TauToast(
          variant: TauToastVariant.error,
          message: 'Connection to server failed. Please try again.',
          autoDismiss: false,
          onDismiss: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Title',
  type: TauToast,
)
Widget titleTauToast(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TauToast(
          variant: TauToastVariant.info,
          title: 'SYSTEM UPDATE',
          message: 'A new firmware version is available for download.',
          autoDismiss: false,
          onDismiss: () {},
        ),
        const SizedBox(height: 16.0),
        TauToast(
          variant: TauToastVariant.success,
          title: 'MISSION COMPLETE',
          message: 'All objectives achieved. Operators returning to base.',
          autoDismiss: false,
          onDismiss: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Icons',
  type: TauToast,
)
Widget iconsTauToast(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TauToast(
          variant: TauToastVariant.info,
          title: 'ENCRYPTION ACTIVE',
          message: 'All communications secured with AES-256 encryption.',
          icon: const Icon(IconData(0xe897, fontFamily: 'MaterialIcons')), // lock
          autoDismiss: false,
          onDismiss: () {},
        ),
        const SizedBox(height: 16.0),
        TauToast(
          variant: TauToastVariant.success,
          title: 'BACKUP COMPLETE',
          message: 'All data successfully backed up to secure storage.',
          icon: const Icon(IconData(0xe2c6, fontFamily: 'MaterialIcons')), // cloud_done
          autoDismiss: false,
          onDismiss: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: TauToast,
)
Widget interactiveTauToast(BuildContext context) {
  return _InteractiveTauToastDemo();
}

class _InteractiveTauToastDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'CLICK BUTTONS TO SHOW TOASTS',
            style: TextStyle(
              color: Color(0xFFC0FC04),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),
          TauButton(
            label: 'SHOW INFO',
            variant: TauButtonVariant.secondary,
            onPressed: () {
              showTauToast(
                context: context,
                variant: TauToastVariant.info,
                title: 'INFORMATION',
                message: 'This is an informational toast notification.',
              );
            },
          ),
          const SizedBox(height: 16.0),
          TauButton(
            label: 'SHOW SUCCESS',
            variant: TauButtonVariant.primary,
            onPressed: () {
              showTauToast(
                context: context,
                variant: TauToastVariant.success,
                title: 'SUCCESS',
                message: 'Operation completed successfully.',
              );
            },
          ),
          const SizedBox(height: 16.0),
          TauButton(
            label: 'SHOW WARNING',
            variant: TauButtonVariant.secondary,
            onPressed: () {
              showTauToast(
                context: context,
                variant: TauToastVariant.warning,
                title: 'WARNING',
                message: 'Please review your settings before proceeding.',
              );
            },
          ),
          const SizedBox(height: 16.0),
          TauButton(
            label: 'SHOW ERROR',
            variant: TauButtonVariant.secondary,
            onPressed: () {
              showTauToast(
                context: context,
                variant: TauToastVariant.error,
                title: 'ERROR',
                message: 'Unable to complete operation. Please try again.',
              );
            },
          ),
          const SizedBox(height: 32.0),
          const Text(
            'Toasts will auto-dismiss after 4 seconds',
            style: TextStyle(
              color: Color(0xFF8E8E8E),
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
