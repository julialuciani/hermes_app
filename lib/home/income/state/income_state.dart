import 'package:hermes_app/home/income/model/income_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class IncomeState {}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class IncomeSuccess extends IncomeState {
  final IncomeModel income;
  final IncomeChartModel chartModel;

  IncomeSuccess(this.income, this.chartModel);
}

class IncomeFailure extends IncomeState {
  final Failure failure;

  IncomeFailure(this.failure);
}
