import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class TransactionFormState {}

class TransactionFormInitial extends TransactionFormState {}

class TransactionFormLoading extends TransactionFormState {}

class TransactionFormSuccessChangeFields extends TransactionFormState {}

class TransactionFormSuccessSave extends TransactionFormState {}

class TransactionFormErrorSave extends TransactionFormState {
  final Failure failure;

  TransactionFormErrorSave(this.failure);
}
