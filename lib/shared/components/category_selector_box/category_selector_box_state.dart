import 'package:hermes_app/shared/entities/category.dart';
import 'package:hermes_app/shared/models/failure.dart';

abstract class CategorySelectorBoxState {}

class CategorySelectorBoxInitial extends CategorySelectorBoxState {}

class CategorySelectorBoxLoading extends CategorySelectorBoxState {}

class CategorySelectorBoxSuccess extends CategorySelectorBoxState {
  final List<Category> categories;

  CategorySelectorBoxSuccess(this.categories);
}

class CategorySelectorBoxError extends CategorySelectorBoxState {
  final Failure failure;

  CategorySelectorBoxError(this.failure);
}
