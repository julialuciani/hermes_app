import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Chart(),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            centerSpaceRadius: 50,
            pieTouchData: PieTouchData(
              longPressDuration: const Duration(seconds: 200),
              touchCallback: (event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            sections: [
              PieChartSectionData(
                value: 100,
                color: Colors.blue,
                radius: touchedIndex == 0 ? 50 : 20,
                showTitle: touchedIndex == 0,
                badgeWidget: touchedIndex == 0
                    ? const CircleAvatar(child: Icon(Icons.celebration))
                    : null,
                badgePositionPercentageOffset: 0.9,
                titlePositionPercentageOffset: 2,
                title: "Gym",
              ),
              PieChartSectionData(
                value: 100,
                color: Colors.amber,
                radius: touchedIndex == 1 ? 50 : 20,
                showTitle: touchedIndex == 1,
                badgeWidget: touchedIndex == 1
                    ? const CircleAvatar(child: Icon(Icons.celebration))
                    : null,
                badgePositionPercentageOffset: 0.9,
                title: "Gym",
                titlePositionPercentageOffset: 2,
              ),
              PieChartSectionData(
                value: 100,
                color: Colors.red,
                showTitle: touchedIndex == 2,
                radius: touchedIndex == 2 ? 50 : 20,
                badgeWidget: touchedIndex == 2
                    ? const CircleAvatar(child: Icon(Icons.celebration))
                    : null,
                badgePositionPercentageOffset: 0.9,
                title: "Gym",
                titlePositionPercentageOffset: 2,
              ),
            ],
          ),
          swapAnimationCurve: Curves.easeIn,
          swapAnimationDuration: const Duration(milliseconds: 10),
        ),
        const Text("Alooo")
      ],
    );
  }
}
