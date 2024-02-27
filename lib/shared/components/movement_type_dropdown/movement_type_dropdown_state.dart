import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

abstract class MovementTypeDropdownState {}

class MovementTypeDropdownLoading extends MovementTypeDropdownState {}

class MovementTypeDropdownSuccess extends MovementTypeDropdownState {
  final List<DropdownItem> items;

  MovementTypeDropdownSuccess(this.items);
}

class MovementTypeDropdownError extends MovementTypeDropdownState {
  final Failure failure;

  MovementTypeDropdownError(this.failure);
}
