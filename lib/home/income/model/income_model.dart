import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';

class IncomeModel {
  final List<List<MovementModel>> incomes;
  final PeriodGroup periodGroup;

  IncomeModel({
    required this.incomes,
    required this.periodGroup,
  });
}

class IncomeChartModel {
  final List<ChartSection> sections;

  IncomeChartModel({
    required this.sections,
  });

  double get total =>
      sections.fold(0, (total, section) => total + section.value);
}
