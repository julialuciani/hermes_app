import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class CategorySelectorBoxState {}

class CategorySelectorBoxInitial extends CategorySelectorBoxState {}

class CategorySelectorBoxLoading extends CategorySelectorBoxState {}

class CategorySelectorBoxSuccess extends CategorySelectorBoxState {
  final List<CategoryModel> categories;

  CategorySelectorBoxSuccess(this.categories);
}

class CategorySelectorBoxError extends CategorySelectorBoxState {
  final Failure failure;

  CategorySelectorBoxError(this.failure);
}
