import 'package:hermes_app/home/balance/model/balance_model.dart';
import 'package:hermes_app/shared/entities/movement_model.dart';
import 'package:hermes_app/shared/repositories/movement_repository.dart';

import 'group_movement_use_case.dart';

class GetAllMovementByPeriodUseCase {
  final MovementRepository _repository;
  final GroupMovementUseCase _groupMovementsUseCase;

  GetAllMovementByPeriodUseCase(
    this._repository,
    this._groupMovementsUseCase,
  );

  Future<BalanceModel> call(Period period) async {
    return BalanceModel(
      currentFilter: _getCurrentFilterName(period),
      extract: _groupMovementsUseCase.groupMovementsByPeriod(
        await getAllMovements(),
        period,
      ),
    );
  }

  String _getCurrentFilterName(Period period) {
    final month = _monthString(
      DateTime.now().month,
    );
    switch (period) {
      case Period.day:
        return '${DateTime.now().day} - $month - ${DateTime.now().year}';
      case Period.week:
        return 'não sei';
      case Period.month:
        return '$month - ${DateTime.now().year}';
      case Period.year:
        return DateTime.now().year.toString();
      default:
        return '';
    }
  }

  String _monthString(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';

      default:
        return '';
    }
  }

  Future<List<MovementModel>> getAllMovements() async {
    final result = await _repository.getAll();
    return result;
  }
}

enum Period { day, week, month, year }
