import 'package:hermes_app/home/expenses/model/expenses_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesSuccess extends ExpensesState {
  final ExpensesModel expenses;

  ExpensesSuccess(this.expenses);
}

class ExpensesFailure extends ExpensesState {
  final Failure failure;

  ExpensesFailure(this.failure);
}
