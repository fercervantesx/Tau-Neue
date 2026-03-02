import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Initials', type: TauAvatar)
Widget initialsTauAvatar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        TauAvatar(initials: 'JD', size: TauAvatarSize.small),
        TauAvatar(initials: 'JD', size: TauAvatarSize.medium),
        TauAvatar(initials: 'JD', size: TauAvatarSize.large),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Icon', type: TauAvatar)
Widget iconTauAvatar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const Wrap(
      spacing: 16.0,
      children: [
        TauAvatar(icon: Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons'))),
        TauAvatar(icon: Icon(IconData(0xe7ef, fontFamily: 'MaterialIcons'))),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Shapes', type: TauAvatar)
Widget shapesTauAvatar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const Wrap(
      spacing: 16.0,
      children: [
        TauAvatar(initials: 'JD', shape: TauAvatarShape.circle),
        TauAvatar(initials: 'JD', shape: TauAvatarShape.square),
      ],
    ),
  );
}
