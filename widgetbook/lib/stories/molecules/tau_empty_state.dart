import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic',
  type: TauEmptyState,
)
Widget basicTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: const TauEmptyState(
      heading: 'NO DATA',
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Description',
  type: TauEmptyState,
)
Widget descriptionTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: const TauEmptyState(
      heading: 'NO MISSIONS AVAILABLE',
      description: 'All objectives have been completed. Awaiting new assignments from command.',
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icon',
  type: TauEmptyState,
)
Widget iconTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: const TauEmptyState(
      icon: Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')), // inbox
      heading: 'INBOX EMPTY',
      description: 'No messages received. All communications clear.',
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Primary Action',
  type: TauEmptyState,
)
Widget primaryActionTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: TauEmptyState(
      icon: const Icon(IconData(0xe86f, fontFamily: 'MaterialIcons')), // search_off
      heading: 'NO RESULTS FOUND',
      description: 'Try adjusting your search parameters or filters.',
      primaryAction: TauButton(
        label: 'CLEAR FILTERS',
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Two Actions',
  type: TauEmptyState,
)
Widget twoActionsTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: TauEmptyState(
      icon: const Icon(IconData(0xe24d, fontFamily: 'MaterialIcons')), // folder_open
      heading: 'NO FILES',
      description: 'This directory is empty. Upload files to get started.',
      primaryAction: TauButton(
        label: 'UPLOAD FILES',
        variant: TauButtonVariant.primary,
        onPressed: () {},
      ),
      secondaryAction: TauButton(
        label: 'CREATE FOLDER',
        variant: TauButtonVariant.secondary,
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Error State',
  type: TauEmptyState,
)
Widget errorTauEmptyState(BuildContext context) {
  return Container(
    height: 400.0,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      border: Border.all(
        color: const Color(0xFF2A2A2A),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: TauEmptyState(
      icon: const Icon(IconData(0xe000, fontFamily: 'MaterialIcons')), // error_outline
      heading: 'CONNECTION FAILED',
      description: 'Unable to establish secure connection to server. Check your network and try again.',
      primaryAction: TauButton(
        label: 'RETRY',
        onPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Different Contexts',
  type: TauEmptyState,
)
Widget contextsTauEmptyState(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 300.0,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const TauEmptyState(
            icon: Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons')), // group
            heading: 'NO OPERATORS ASSIGNED',
            description: 'Assign operators to this mission to begin operations.',
          ),
        ),
        Container(
          height: 300.0,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const TauEmptyState(
            icon: Icon(IconData(0xe85f, fontFamily: 'MaterialIcons')), // warning
            heading: 'NO THREATS DETECTED',
            description: 'All systems operational. Perimeter secure.',
          ),
        ),
        Container(
          height: 300.0,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            border: Border.all(
              color: const Color(0xFF2A2A2A),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const TauEmptyState(
            icon: Icon(IconData(0xe86c, fontFamily: 'MaterialIcons')), // check_circle
            heading: 'ALL TASKS COMPLETE',
            description: 'Excellent work. All mission objectives achieved.',
          ),
        ),
      ],
    ),
  );
}
