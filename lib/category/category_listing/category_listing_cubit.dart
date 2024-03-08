import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category_listing/category_listing_state.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class CategoryListingCubit extends Cubit<CategoryListingState> {
  CategoryListingCubit() : super(CategoryListingInitial());

  void fetch() async {
    emit(CategoryListingLoading());
    try {
      emit(CategoryListingSuccess(categories: []));
    } on Failure catch (failure) {
      emit(CategoryListingError(failure: failure));
    } catch (exception, stackTrace) {
      final failure = UnknownError(error: exception, stackTrace: stackTrace);
      emit(CategoryListingError(failure: failure));
    }
  }
}
