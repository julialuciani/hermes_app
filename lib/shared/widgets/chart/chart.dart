import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final List<ChartSection> sections;
  final String? innerContent;
  final void Function(int index)? onTap;
  const Chart({
    Key? key,
    required this.sections,
    this.innerContent,
    this.onTap,
  }) : super(key: key);

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
                  if (widget.onTap != null) widget.onTap!(touchedIndex);
                },
              ),
              sections: widget.sections.map((section) {
                final isSelected =
                    widget.sections.indexOf(section) == touchedIndex;

                return PieChartSectionData(
                  value: section.value,
                  color: section.color,
                  title: section.title,
                  badgeWidget: isSelected ? section.icon : null,
                  radius: isSelected ? 35 : 20,
                  badgePositionPercentageOffset: 0.9,
                  titlePositionPercentageOffset: 2,
                );
              }).toList()),
          swapAnimationCurve: Curves.easeIn,
          swapAnimationDuration: const Duration(milliseconds: 10),
        ),
        if (widget.innerContent != null) Text(widget.innerContent!)
      ],
    );
  }
}

class ChartSection {
  final double value;
  final String title;
  final Widget icon;
  final Color color;
  ChartSection({
    required this.value,
    required this.title,
    required this.icon,
    required this.color,
  });
}
