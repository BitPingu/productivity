import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';


class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends ConsumerState<UserPage> {

  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Icon(
              Icons.person,
              size: 70,
            ),
            // const SizedBox(height: 2),
            Text(
              "Gavin",
              style: Theme.of(context).textTheme.headlineSmall
            ),
            // const SizedBox(height: 2),
            Text('Lvl. 2'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: .25),
                  SizedBox(height: 4),
                  Text("Next Level: 29 EXP"),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              height: 300,
              child: RadarChart(
              RadarChartData(
                dataSets: showingDataSets(),
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.grey),
                titlePositionPercentageOffset: 0.1,
                titleTextStyle: TextStyle(
                  color: Colors.orange, 
                  fontWeight: FontWeight.bold,
                ),
                getTitle: (index, angle) {
                  // final usedAngle = relativeAngleMode ? angle + angleValue : angleValue;
                  double usedAngle = 0;
                  switch (index) {
                    case 0:
                      return RadarChartTitle(
                        text: 'Strength',
                        angle: usedAngle,
                      );
                    case 1:
                      return RadarChartTitle(
                        text: 'Intelligence',
                        angle: usedAngle,
                      );
                    case 2:
                      return RadarChartTitle(
                        text: 'Courage',
                        angle: usedAngle,
                      );
                    case 3:
                      return RadarChartTitle(
                        text: 'Kindness',
                        angle: usedAngle,
                      );
                    case 4:
                      return RadarChartTitle(
                        text: 'Charisma',
                        angle: usedAngle,
                      );
                    default:
                      return const RadarChartTitle(text: '');
                  }
                },
                tickCount: 1,
                ticksTextStyle: const TextStyle(
                  color: Colors.transparent,
                  fontSize: 10,
                ),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            ),
            // SizedBox(height: 4),
            Text("Your Stats"),
          ],
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withValues(alpha: 0.2)
            : rawDataSet.color.withValues(alpha: 0.05),
        borderColor: isSelected
            ? rawDataSet.color
            : rawDataSet.color.withValues(alpha: 0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Stats',
        color: Colors.greenAccent,
        values: [
          60,
          80,
          50,
          70,
          60
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}

