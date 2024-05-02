import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/investments/get_investments_chart_sections_use_case.dart';
import 'package:hermes_app/home/investments/get_investments_use_case.dart';
import 'package:hermes_app/home/investments/state/investments_state.dart';
import 'package:hermes_app/home/utils/fetch_movements_filters.dart';
import 'package:hermes_app/shared/entities/failure_model.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class InvestmentsCubit extends Cubit<InvestmentsState> {
  final GetInvestmentsUseCase _getInvestmentsUseCase;
  final GetInvestmentsChartSectionsUseCase _getInvestmentsChartSectionsUseCase;

  InvestmentsCubit(
    this._getInvestmentsUseCase,
    this._getInvestmentsChartSectionsUseCase,
  ) : super(InvestmentsInitial());

  void fetch(FetchMovementsFilters filters) async {
    emit(InvestmentsLoading());
    try {
      final expenses = await _getInvestmentsUseCase(filters);
      final chartModel = await _getInvestmentsChartSectionsUseCase(filters);
      emit(InvestmentsSuccess(expenses, chartModel));
    } on Failure catch (e) {
      emit(InvestmentsFailure(e));
    } catch (exception, stackTrace) {
      final unknownError = UnknownError(
        error: exception,
        stackTrace: stackTrace,
      );
      emit(InvestmentsFailure(unknownError));
    }
  }
}
