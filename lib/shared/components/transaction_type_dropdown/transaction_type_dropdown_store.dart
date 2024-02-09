import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/transaction_type_dropdown/transaction_type_dropdown_state.dart';

class TransactionTypeDropdownStore extends Cubit<TransactionTypeDropdownState> {
  TransactionTypeDropdownStore() : super(TransactionTypeDropdownLoading());
}
