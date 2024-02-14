import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

abstract class TransactionTypeDropdownState {}

class TransactionTypeDropdownLoading extends TransactionTypeDropdownState {}

class TransactionTypeDropdownSuccess extends TransactionTypeDropdownState {
  final List<DropdownItem> items;

  TransactionTypeDropdownSuccess(this.items);
}

class TransactionTypeDropdownError extends TransactionTypeDropdownState {
  final Failure failure;

  TransactionTypeDropdownError(this.failure);
}
