import 'package:hermes_app/home/investments/model/investments_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class InvestmentsState {}

class InvestmentsInitial extends InvestmentsState {}

class InvestmentsLoading extends InvestmentsState {}

class InvestmentsSuccess extends InvestmentsState {
  final InvestmentsModel investments;
  final InvestmentsChartModel chartModel;

  InvestmentsSuccess(this.investments, this.chartModel);
}

class InvestmentsFailure extends InvestmentsState {
  final Failure failure;

  InvestmentsFailure(this.failure);
}
