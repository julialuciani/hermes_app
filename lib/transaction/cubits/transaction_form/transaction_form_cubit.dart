import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/entities/transaction.dart';
import 'package:hermes_app/transaction/cubits/transaction_form/transaction_form_state.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(TransactionFormInitial());

  void init() {
    const Transaction transaction = Transaction();

    emit(TransactionFormData(transaction: transaction));
  }
}
