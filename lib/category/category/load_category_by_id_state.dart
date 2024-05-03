import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class LoadCategoryByIdState {}

class LoadCategoryByIdInitial extends LoadCategoryByIdState {}

class LoadCategoryByIdLoading extends LoadCategoryByIdState {}

class LoadCategoryByIdSuccess extends LoadCategoryByIdState {
  final CategoryModel category;

  LoadCategoryByIdSuccess(this.category);
}

class LoadCategoryByIdError extends LoadCategoryByIdState {
  final Failure failure;

  LoadCategoryByIdError(this.failure);
}
