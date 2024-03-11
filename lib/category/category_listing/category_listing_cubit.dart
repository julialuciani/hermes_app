import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/category/category_listing/get_categories_params.dart';
import 'package:hermes_app/category/category_listing/get_categories_use_case.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class CategoryListingCubit extends Cubit<CategoryListingState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryListingCubit(
    this._getCategoriesUseCase,
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
}
