import 'package:hermes_app/shared/entities/movement_model.dart';

enum ExpensePeriodGroup {
  day,
  week,
  month,
  year,
}

class ExpensesModel {
  final List<MovementModel> expenses;
  final ExpensePeriodGroup periodGroup;

  ExpensesModel({
    required this.expenses,
    required this.periodGroup,
  });
}
