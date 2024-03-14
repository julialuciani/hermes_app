import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/category/category_listing/delete_category_by_id_use_case.dart';
import 'package:hermes_app/category/category_listing/get_categories_params.dart';
import 'package:hermes_app/category/category_listing/get_categories_use_case.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class CategoryListingCubit extends Cubit<CategoryListingState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final DeleteCategoryByIdUseCase _deleteCategoryByIdUseCase;

  CategoryListingCubit(
    this._getCategoriesUseCase,
    this._deleteCategoryByIdUseCase,
  ) : super(CategoryListingInitial());

  void fetch(GetCategoriesParams params) async {
    emit(CategoryListingLoading());
    try {
      final categories = await _getCategoriesUseCase(params);
      emit(CategoryListingSuccess(categories: categories));
    } on Failure catch (failure) {
      emit(CategoryListingError(failure: failure));
    } catch (exception, stackTrace) {
      final failure = UnknownError(error: exception, stackTrace: stackTrace);
      emit(CategoryListingError(failure: failure));
    }
  }

  Future<bool> deleteCategory(
      CategoryModel category, void Function(Failure error) onError) async {
    try {
      if (category.id == null) return false;
      final result = await _deleteCategoryByIdUseCase(category.id!);
      return result == 1;
    } catch (exception, stackTrace) {
      onError(UnknownError(error: exception, stackTrace: stackTrace));
      return false;
    }
  }
}
