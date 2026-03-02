import 'package:flutter/widgets.dart';
import 'package:tau_neue/tau_neue.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Single Stat',
  type: TauStatCard,
)
Widget singleTauStatCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauStatCard(
      label: 'ACTIVE MISSIONS',
      value: '247',
      change: '+12.5%',
      trend: TauStatTrend.up,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Trend Variations',
  type: TauStatCard,
)
Widget trendTauStatCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauStatCard(
          label: 'REVENUE',
          value: '\$1.2M',
          change: '+23.8%',
          trend: TauStatTrend.up,
        ),
        SizedBox(height: 16.0),
        TauStatCard(
          label: 'INCIDENTS',
          value: '14',
          change: '-8.4%',
          trend: TauStatTrend.down,
        ),
        SizedBox(height: 16.0),
        TauStatCard(
          label: 'DEPLOYMENT ZONES',
          value: '42',
          change: '0.0%',
          trend: TauStatTrend.neutral,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: TauStatCard,
)
Widget iconTauStatCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauStatCard(
          label: 'OPERATORS',
          value: '89',
          change: '+7',
          trend: TauStatTrend.up,
          icon: Icon(IconData(0xe7fd, fontFamily: 'MaterialIcons')), // person
        ),
        SizedBox(height: 16.0),
        TauStatCard(
          label: 'ALERTS',
          value: '23',
          change: '-5',
          trend: TauStatTrend.down,
          icon: Icon(IconData(0xe85f, fontFamily: 'MaterialIcons')), // warning
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Without Change',
  type: TauStatCard,
)
Widget noChangeTauStatCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauStatCard(
          label: 'TOTAL SECTORS',
          value: '128',
        ),
        SizedBox(height: 16.0),
        TauStatCard(
          label: 'UPTIME',
          value: '99.9%',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading State',
  type: TauStatCard,
)
Widget loadingTauStatCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TauStatCard(
          label: 'LOADING...',
          value: '...',
          isLoading: true,
        ),
        SizedBox(height: 16.0),
        TauStatCard(
          label: 'LOADING...',
          value: '...',
          isLoading: true,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Stats Grid',
  type: TauStatsGrid,
)
Widget gridTauStatsGrid(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauStatsGrid(
      columns: 3,
      stats: [
        TauStatCard(
          label: 'TOTAL MISSIONS',
          value: '1,247',
          change: '+8.2%',
          trend: TauStatTrend.up,
        ),
        TauStatCard(
          label: 'ACTIVE OPERATORS',
          value: '89',
          change: '+12',
          trend: TauStatTrend.up,
        ),
        TauStatCard(
          label: 'SUCCESS RATE',
          value: '94.3%',
          change: '+2.1%',
          trend: TauStatTrend.up,
        ),
        TauStatCard(
          label: 'INCIDENTS',
          value: '14',
          change: '-28.5%',
          trend: TauStatTrend.down,
        ),
        TauStatCard(
          label: 'RESPONSE TIME',
          value: '2.4s',
          change: '-0.8s',
          trend: TauStatTrend.down,
        ),
        TauStatCard(
          label: 'DEPLOYMENT ZONES',
          value: '42',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Two Column Grid',
  type: TauStatsGrid,
)
Widget twoColumnTauStatsGrid(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: const TauStatsGrid(
      columns: 2,
      spacing: 24.0,
      stats: [
        TauStatCard(
          label: 'ENCRYPTED TRANSMISSIONS',
          value: '8,429',
          change: '+432',
          trend: TauStatTrend.up,
          icon: Icon(IconData(0xe897, fontFamily: 'MaterialIcons')), // lock
        ),
        TauStatCard(
          label: 'DATA PROCESSED',
          value: '2.4 TB',
          change: '+18.9%',
          trend: TauStatTrend.up,
          icon: Icon(IconData(0xe1db, fontFamily: 'MaterialIcons')), // storage
        ),
        TauStatCard(
          label: 'THREAT LEVEL',
          value: 'LOW',
          change: 'STABLE',
          trend: TauStatTrend.neutral,
          icon: Icon(IconData(0xe32a, fontFamily: 'MaterialIcons')), // security
        ),
        TauStatCard(
          label: 'SYSTEM INTEGRITY',
          value: '100%',
          trend: TauStatTrend.neutral,
          icon: Icon(IconData(0xe86c, fontFamily: 'MaterialIcons')), // check_circle
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dashboard Example',
  type: TauStatsGrid,
)
Widget dashboardTauStatsGrid(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'TACTICAL OPERATIONS DASHBOARD',
          style: TextStyle(
            color: Color(0xFFC0FC04),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 24.0),
        const TauStatsGrid(
          columns: 4,
          spacing: 16.0,
          stats: [
            TauStatCard(
              label: 'MISSIONS',
              value: '247',
              change: '+15',
              trend: TauStatTrend.up,
            ),
            TauStatCard(
              label: 'OPERATORS',
              value: '89',
              change: '+7',
              trend: TauStatTrend.up,
            ),
            TauStatCard(
              label: 'UPTIME',
              value: '99.9%',
            ),
            TauStatCard(
              label: 'THREATS',
              value: '2',
              change: '-8',
              trend: TauStatTrend.down,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const TauStatsGrid(
          columns: 3,
          spacing: 16.0,
          stats: [
            TauStatCard(
              label: 'AVG RESPONSE TIME',
              value: '2.4s',
              change: '-0.3s',
              trend: TauStatTrend.down,
            ),
            TauStatCard(
              label: 'SUCCESS RATE',
              value: '94.3%',
              change: '+2.1%',
              trend: TauStatTrend.up,
            ),
            TauStatCard(
              label: 'EFFICIENCY',
              value: '87%',
              change: '+5.2%',
              trend: TauStatTrend.up,
            ),
          ],
        ),
      ],
    ),
  );
}
