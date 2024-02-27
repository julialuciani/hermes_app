import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_state.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_categories_by_movement_type_id_use_case.dart';

class CategorySelectorBoxCubit extends Cubit<CategorySelectorBoxState> {
  final GetCategoriesByMovementTypeIdUseCase _useCase;

  CategorySelectorBoxCubit(
    this._useCase,
  ) : super(CategorySelectorBoxInitial());

  Future<void> fetch(int movementTypeId) async {
    emit(CategorySelectorBoxLoading());
    try {
      final categories = await _useCase(movementTypeId);

      emit(CategorySelectorBoxSuccess(categories));
    } catch (exception, stackTrace) {
      final unknwonError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );

      emit(CategorySelectorBoxError(unknwonError));
    }
  }

  void reset() {
    emit(CategorySelectorBoxInitial());
  }
}

class ChangeMovementTypeEvent {
  final int? movementTypeId;

  ChangeMovementTypeEvent(this.movementTypeId);
}
