import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/category_dropdown/category_dropdown_state.dart';
import 'package:hermes_app/shared/entities/category_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_categories_by_movement_type_id_use_case.dart';
import 'package:hermes_app/shared/widgets/dropdown/dropdown_item.dart';

class CategoryDropdownCubit extends Cubit<CategoryDropdownState> {
  final GetCategoriesByMovementTypeIdUseCase _usecase;
  CategoryDropdownCubit(
    this._usecase,
  ) : super(CategoryDropdownLoading());

  void fetch(int categoryTypeId) async {
    emit(CategoryDropdownLoading());
    try {
      final items = await _usecase(categoryTypeId);

      emit(CategoryDropdownSuccess(items.toDropdownItems()));
    } catch (exception, stackTrace) {
      final unknownError =
          UnknownError(error: exception, stackTrace: stackTrace);
      emit(CategoryDropdownError(unknownError));
    }
  }
}

extension _ToDropdownItemList on List<CategoryModel> {
  List<DropdownItem> toDropdownItems() {
    return map((e) => DropdownItem(value: e.id!, description: e.name)).toList();
  }
}
