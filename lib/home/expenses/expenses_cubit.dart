import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/expenses/get_expenses_chart_sections_use_case.dart';
import 'package:hermes_app/home/expenses/get_expenses_use_case.dart';
import 'package:hermes_app/home/expenses/state/expenses_state.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final GetExpensesUseCase _getExpensesUseCase;
  final GetExpensesChartSectionsUseCase _getExpensesChartSectionsUseCase;

  ExpensesCubit(
    this._getExpensesUseCase,
    this._getExpensesChartSectionsUseCase,
  ) : super(ExpensesInitial());

  void fetch(FetchMovementsFilters filters) async {
    emit(ExpensesLoading());
    try {
      final expenses = await _getExpensesUseCase(filters);
      final chartModel = await _getExpensesChartSectionsUseCase(filters);
      emit(ExpensesSuccess(expenses, chartModel));
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
