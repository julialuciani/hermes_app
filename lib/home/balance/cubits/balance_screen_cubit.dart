import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/home/balance/get_all_movement_by_period_use_case.dart';
import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/home/balance/state/balance_screen_state.dart';
import 'package:hermes_app/shared/entities/unknown_error.dart';

class BalanceScreenCubit extends Cubit<BalanceScreenState> {
  final GetAllMovementByPeriodUseCase _useCase;

  BalanceScreenCubit(
    this._useCase,
  ) : super(BalanceScreenInitial());

  void fetch(Period period) async {
    emit(BalanceScreenLoading());
    try {
      final BalanceModel balance = await _useCase.call(period);

      emit(BalanceScreenSucess(balance));
    } catch (error, stackTrace) {
      final unknownError = UnknownError(error: error, stackTrace: stackTrace);

      emit(BalanceScreenError(unknownError));
    }
  }
}
