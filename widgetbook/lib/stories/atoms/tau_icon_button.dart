import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Variants', type: TauIconButton)
Widget variantsTauIconButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 12.0,
      children: [
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.primary,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.secondary,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.ghost,
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Sizes', type: TauIconButton)
Widget sizesTauIconButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 12.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          size: TauIconButtonSize.small,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          size: TauIconButtonSize.medium,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe8b8, fontFamily: 'MaterialIcons')),
          size: TauIconButtonSize.large,
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Icon Group', type: TauIconButton)
Widget groupTauIconButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Wrap(
      spacing: 8.0,
      children: [
        TauIconButton(
          icon: const Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.secondary,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe14d, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.secondary,
          onPressed: () {},
        ),
        TauIconButton(
          icon: const Icon(IconData(0xe872, fontFamily: 'MaterialIcons')),
          variant: TauIconButtonVariant.secondary,
          onPressed: () {},
        ),
      ],
    ),
  );
}
