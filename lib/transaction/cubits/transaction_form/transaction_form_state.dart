import 'package:hermes_app/shared/entities/transaction.dart';
import 'package:hermes_app/shared/models/failure.dart';

abstract class TransactionFormState {}

class TransactionFormInitial extends TransactionFormState {}

class TransactionFormLoading extends TransactionFormState {}

class TransactionFormData extends TransactionFormState {
  final Transaction transaction;

  TransactionFormData({
    required this.transaction,
  });
}

class TransactionFormError extends TransactionFormState {
  final Failure failure;

  TransactionFormError({
    required this.failure,
  });
}
