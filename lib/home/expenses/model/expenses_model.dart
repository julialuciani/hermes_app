import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';

class ExpensesModel {
  final List<List<MovementModel>> expenses;
  final PeriodGroup periodGroup;

  ExpensesModel({
    required this.expenses,
    required this.periodGroup,
  });
}

class ExpensesChartModel {
  final List<ChartSection> sections;

  ExpensesChartModel({
    required this.sections,
  });

  double get total =>
      sections.fold(0, (total, section) => total + section.value);
}
