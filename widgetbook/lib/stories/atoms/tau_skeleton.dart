import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Box Variants',
  type: TauSkeletonBox,
)
Widget boxTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauSkeletonBox(width: 200, height: 20),
        SizedBox(height: 16.0),
        TauSkeletonBox(width: 300, height: 40),
        SizedBox(height: 16.0),
        TauSkeletonBox(width: 150, height: 100),
        SizedBox(height: 16.0),
        TauSkeletonBox(height: 60),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Circle Variants',
  type: TauSkeletonCircle,
)
Widget circleTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        TauSkeletonCircle(size: 24),
        TauSkeletonCircle(size: 40),
        TauSkeletonCircle(size: 64),
        TauSkeletonCircle(size: 96),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Text Lines',
  type: TauSkeletonText,
)
Widget textTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauSkeletonText(width: 250),
        SizedBox(height: 12.0),
        TauSkeletonText(width: 300),
        SizedBox(height: 12.0),
        TauSkeletonText(width: 180),
        SizedBox(height: 12.0),
        TauSkeletonText(width: 220),
        SizedBox(height: 12.0),
        TauSkeletonText(width: 150),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'List Tile Pattern',
  type: TauSkeletonGroup,
)
Widget listTileTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TauSkeletonGroup.listTile(),
        const SizedBox(height: 16.0),
        TauSkeletonGroup.listTile(),
        const SizedBox(height: 16.0),
        TauSkeletonGroup.listTile(),
        const SizedBox(height: 16.0),
        TauSkeletonGroup.listTile(),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Card Pattern',
  type: TauSkeletonGroup,
)
Widget cardTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: TauSkeletonGroup.card()),
        const SizedBox(width: 16.0),
        Expanded(child: TauSkeletonGroup.card()),
        const SizedBox(width: 16.0),
        Expanded(child: TauSkeletonGroup.card()),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Stat Card Pattern',
  type: TauSkeletonGroup,
)
Widget statCardTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              border: Border.all(
                color: const Color(0xFF2A2A2A),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: TauSkeletonGroup.statCard(),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              border: Border.all(
                color: const Color(0xFF2A2A2A),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: TauSkeletonGroup.statCard(),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              border: Border.all(
                color: const Color(0xFF2A2A2A),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: TauSkeletonGroup.statCard(),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Form Loading',
  type: TauSkeletonGroup,
)
Widget formTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        TauSkeletonText(width: 80, height: 10),
        SizedBox(height: 8.0),
        TauSkeletonBox(height: 40),
        SizedBox(height: 24.0),
        TauSkeletonText(width: 100, height: 10),
        SizedBox(height: 8.0),
        TauSkeletonBox(height: 40),
        SizedBox(height: 24.0),
        TauSkeletonText(width: 120, height: 10),
        SizedBox(height: 8.0),
        TauSkeletonBox(height: 80),
        SizedBox(height: 24.0),
        TauSkeletonBox(width: 150, height: 40),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Table Loading',
  type: TauSkeletonGroup,
)
Widget tableTauSkeleton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border.all(
          color: const Color(0xFF2A2A2A),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF2A2A2A),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              children: const [
                TauSkeletonText(width: 80, height: 10),
                SizedBox(width: 16.0),
                TauSkeletonText(width: 120, height: 10),
                SizedBox(width: 16.0),
                TauSkeletonText(width: 100, height: 10),
                SizedBox(width: 16.0),
                TauSkeletonText(width: 80, height: 10),
              ],
            ),
          ),
          // Rows
          for (int i = 0; i < 5; i++)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF2A2A2A),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: const [
                  TauSkeletonText(width: 80, height: 12),
                  SizedBox(width: 16.0),
                  TauSkeletonText(width: 120, height: 12),
                  SizedBox(width: 16.0),
                  TauSkeletonText(width: 100, height: 12),
                  SizedBox(width: 16.0),
                  TauSkeletonText(width: 80, height: 12),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
