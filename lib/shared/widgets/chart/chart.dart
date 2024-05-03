import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hermes_app/shared/extensions/build_context_extensions.dart';

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
    final typography = context.typography;
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
                centerSpaceRadius: 75,
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
                  return PieChartSectionData(
                    value: section.value,
                    color: section.color,
                    radius: 20,
                    showTitle: false,
                  );
                }).toList()),
            swapAnimationCurve: Curves.easeIn,
            swapAnimationDuration: const Duration(milliseconds: 10),
          ),
          if (widget.innerContent != null)
            Text(
              widget.innerContent!,
              style: typography.bold.medium,
            )
        ],
      ),
    );
  }
}

class ChartSection {
  final double value;
  final String title;
  final Color color;
  ChartSection({
    required this.value,
    required this.title,
    required this.color,
  });
}
