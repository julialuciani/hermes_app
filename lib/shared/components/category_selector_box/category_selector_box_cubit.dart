import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/shared/components/category_selector_box/category_selector_box_state.dart';
import 'package:hermes_app/shared/models/unknown_error.dart';
import 'package:hermes_app/shared/usecases/get_categories_by_transaction_type_id_use_case.dart';

class CategorySelectorBoxCubit extends Cubit<CategorySelectorBoxState> {
  final GetCategoriesByTransactionTypeIdUseCase _useCase;

  CategorySelectorBoxCubit(
    this._useCase,
  ) : super(CategorySelectorBoxInitial());

  Future<void> fetch(int transactionTypeId) async {
    emit(CategorySelectorBoxLoading());
    try {
      final categories = await _useCase(transactionTypeId);

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

class ChangeTransactionTypeEvent {
  final int? transactionTypeId;

  ChangeTransactionTypeEvent(this.transactionTypeId);
}
