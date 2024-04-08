import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/expenses/get_expenses_use_case.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUseCase _useCase;

  ExpensesCubit(
    this._useCase,
  ) : super(ExpensesInitial());

  void fetch(FetchMovementsFilters filters) {
    emit(ExpensesLoading());
    try {
      _useCase(filters).then((expenses) {
        emit(ExpensesSuccess(expenses));
      });
    } on Failure catch (e) {
      emit(ExpensesFailure(e));
    } catch (exception, stackTrace) {
      final unknownError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );
      emit(ExpensesFailure(unknownError));
    }
  }
}
