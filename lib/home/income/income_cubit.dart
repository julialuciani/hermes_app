import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/income/get_income_chart_sections_use_case.dart';
import 'package:hermes_app/home/income/get_income_use_case.dart';
import 'package:hermes_app/home/income/state/income_state.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final GetIncomeUseCase _getIncomeUseCase;
  final GetIncomeChartSectionsUseCase _getIncomeChartSectionsUseCase;

  IncomeCubit(
    this._getIncomeUseCase,
    this._getIncomeChartSectionsUseCase,
  ) : super(IncomeInitial());

  void fetch(FetchMovementsFilters filters) async {
    emit(IncomeLoading());
    try {
      final income = await _getIncomeUseCase(filters);
      final chartModel = await _getIncomeChartSectionsUseCase(filters);
      emit(IncomeSuccess(income, chartModel));
    } on Failure catch (e) {
      emit(IncomeFailure(e));
    } catch (exception, stackTrace) {
      final unknownError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );
      emit(IncomeFailure(unknownError));
    }
  }
}
