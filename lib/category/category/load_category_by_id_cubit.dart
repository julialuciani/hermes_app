import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/category/category/load_category_by_id_state.dart';
import 'package:hermes_app/category/category/load_category_by_id_use_case.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class LoadCategoryByIdCubit extends Cubit<LoadCategoryByIdState> {
  final LoadCategoryByIdUseCase _useCase;
  LoadCategoryByIdCubit(
    this._useCase,
  ) : super(LoadCategoryByIdInitial());

  void fetch(int categoryId) async {
    emit(LoadCategoryByIdLoading());
    try {
      final category = await _useCase(categoryId);
      emit(LoadCategoryByIdSuccess(category));
    } on Failure catch (failure) {
      emit(LoadCategoryByIdError(failure));
    } catch (exception, stackTrace) {
      final failure = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );
      emit(LoadCategoryByIdError(failure));
    }
  }
}
