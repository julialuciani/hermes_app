import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';

abstract class CategoryListingState {}

class CategoryListingInitial extends CategoryListingState {}

class CategoryListingLoading extends CategoryListingState {}

class CategoryListingSuccess extends CategoryListingState {
  final List<CategoryModel> categories;

  CategoryListingSuccess({
    required this.categories,
  });
}

class CategoryListingError extends CategoryListingState {
  final Failure failure;

  CategoryListingError({
    required this.failure,
  });
}
