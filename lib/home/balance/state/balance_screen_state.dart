import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class BalanceScreenState {}

class BalanceScreenInitial extends BalanceScreenState {}

class BalanceScreenLoading extends BalanceScreenState {}

class BalanceScreenSucess extends BalanceScreenState {
  final BalanceModel balance;

  BalanceScreenSucess(this.balance);
}

class BalanceScreenError extends BalanceScreenState {
  final Failure failure;

  BalanceScreenError(this.failure);
}
