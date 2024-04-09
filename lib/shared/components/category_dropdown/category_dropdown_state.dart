import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

abstract class CategoryDropdownState {}

class CategoryDropdownLoading extends CategoryDropdownState {}

class CategoryDropdownSuccess extends CategoryDropdownState {
  final List<DropdownItem> items;

  CategoryDropdownSuccess(this.items);
}

class CategoryDropdownError extends CategoryDropdownState {
  final Failure failure;

  CategoryDropdownError(this.failure);
}
