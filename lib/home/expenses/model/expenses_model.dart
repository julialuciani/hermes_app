import 'package:hermes_app/home/utils/period_group_enum.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';

class ExpensesModel {
  final List<MovementModel> expenses;
  final PeriodGroup periodGroup;

  ExpensesModel({
    required this.expenses,
    required this.periodGroup,
  });
}
