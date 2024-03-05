import 'package:hermes_app/shared/entities/movement_model.dart';

class BalanceModel {
  final List<PeriodExtractModel> extract;
  final String currentFilter;

  BalanceModel({
    required this.extract,
    required this.currentFilter,
  });
}

class PeriodExtractModel {
  final String title;
  final List<MovementModel> income;
  final List<MovementModel> expenses;
  final List<MovementModel> investments;
  PeriodExtractModel({
    required this.title,
    required this.income,
    required this.expenses,
    required this.investments,
  });

  PeriodExtractModel copyWith({
    String? title,
    List<MovementModel>? income,
    List<MovementModel>? expenses,
    List<MovementModel>? investments,
  }) {
    return PeriodExtractModel(
      title: title ?? this.title,
      income: income ?? this.income,
      expenses: expenses ?? this.expenses,
      investments: investments ?? this.investments,
    );
  }
}
