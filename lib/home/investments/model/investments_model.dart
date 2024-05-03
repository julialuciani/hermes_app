import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/widgets/chart/chart.dart';

class InvestmentsModel {
  final List<List<MovementModel>> investments;
  final PeriodGroup periodGroup;

  InvestmentsModel({
    required this.investments,
    required this.periodGroup,
  });
}

class InvestmentsChartModel {
  final List<ChartSection> sections;

  InvestmentsChartModel({
    required this.sections,
  });

  double get total =>
      sections.fold(0, (total, section) => total + section.value);
}
