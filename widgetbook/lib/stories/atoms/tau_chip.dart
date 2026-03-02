import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Basic', type: TauChip)
Widget basicTauChip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: [
        TauChip(label: 'ACTIVE', onRemove: () {}),
        TauChip(label: 'PENDING', onRemove: () {}),
        TauChip(label: 'COMPLETED', onRemove: () {}),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: TauChip)
Widget variantsTauChip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 12.0,
      children: [
        TauChip(label: 'DEFAULT', variant: TauChipVariant.default_, onRemove: () {}),
        TauChip(label: 'PRIMARY', variant: TauChipVariant.primary, onRemove: () {}),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With Icons', type: TauChip)
Widget iconsTauChip(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 12.0,
      children: [
        TauChip(
          label: 'USER',
          icon: const Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons')),
          onRemove: () {},
        ),
        TauChip(
          label: 'ADMIN',
          icon: const Icon(IconData(0xe869, fontFamily: 'MaterialIcons')),
          variant: TauChipVariant.primary,
          onRemove: () {},
        ),
      ],
    ),
  );
}
